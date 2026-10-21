import SwiftUI
import UIKit
import BezierSwift

struct SwitchSettingsDemo: View {
  @State private var isOn = false
  @State private var revision = 0
  @State private var iconIsFilled = false
  @State private var rejectChange = false
  @State private var recreateSwitch = false
  @State private var isEnabled = true
  @State private var status = "스위치 또는 외부 변경 버튼을 눌러 보세요."
  @State private var responseTask: Task<Void, Never>?

  var body: some View {
    CatalogScreen(title: "Settings 방식 갱신") {
      Text("행의 아이콘과 스위치 값을 순서대로 갱신합니다. SwiftUI 행은 UIKit 호스트의 rootView를 교체합니다.")
        .font(.callout)
      SettingsSwitchHost(
        isOn: self.isOn,
        revision: self.revision,
        iconIsFilled: self.iconIsFilled,
        isEnabled: self.isEnabled,
        recreateSwitch: self.recreateSwitch,
        onChange: self.requestChange
      )
      .frame(height: 132)

      HStack {
        Button("외부 ON") { self.apply(true) }
        Button("외부 OFF") { self.apply(false) }
        Button("아이콘만 갱신") {
          self.iconIsFilled.toggle()
          self.revision &+= 1
        }
      }
      .buttonStyle(.bordered)

      Toggle("변경 거절 후 원복", isOn: self.$rejectChange)
      Toggle("Enabled", isOn: self.$isEnabled)
      Toggle("이전 방식 비교: SwiftUI 뷰 재생성", isOn: self.$recreateSwitch)
      Text("스위치 입력은 0.5초 후 확정됩니다. 원복을 켜면 기존 값으로 돌아갑니다. 외부 ON/OFF는 즉시 두 행을 갱신합니다.")
        .font(.footnote)
        .foregroundStyle(.secondary)
      Text(self.status)
        .font(.callout)
      Text("확정 상태: \(self.isOn ? "ON" : "OFF") · 갱신: \(self.revision)")
        .font(.caption.monospacedDigit())
    }
    .onDisappear { self.responseTask?.cancel() }
  }

  private func apply(_ value: Bool) {
    self.responseTask?.cancel()
    self.isOn = value
    self.iconIsFilled = value
    self.revision &+= 1
    self.status = "외부 상태 반영"
  }

  private func requestChange(_ value: Bool) {
    self.responseTask?.cancel()
    let shouldReject = self.rejectChange
    self.status = "응답 대기 중…"
    self.responseTask = Task { @MainActor in
      do {
        try await Task.sleep(nanoseconds: 500_000_000)
      } catch {
        return
      }
      if !shouldReject {
        self.isOn = value
      }
      self.iconIsFilled = self.isOn
      self.revision &+= 1
      self.status = shouldReject ? "변경 거절 · 기존 값 복원" : "변경 확정"
    }
  }
}

private struct SettingsSwitchHost: UIViewControllerRepresentable {
  let isOn: Bool
  let revision: Int
  let iconIsFilled: Bool
  let isEnabled: Bool
  let recreateSwitch: Bool
  let onChange: (Bool) -> Void

  func makeUIViewController(context: Context) -> SettingsSwitchController {
    SettingsSwitchController()
  }

  func updateUIViewController(_ controller: SettingsSwitchController, context: Context) {
    controller.onChange = self.onChange
    controller.render(
      isOn: self.isOn,
      revision: self.revision,
      iconIsFilled: self.iconIsFilled,
      isEnabled: self.isEnabled,
      recreateSwitch: self.recreateSwitch
    )
  }
}

final class SettingsSwitchController: UIViewController {
  var onChange: (Bool) -> Void = { _ in }
  let uiKitSwitch = BezierSwitch()
  private let icon = UIImageView()
  private var revision: Int?
  private var rowRevision = 0
  private var isOn = false
  private var iconIsFilled = false
  private var isEnabled = true
  private var recreateSwitch = false
  private lazy var host = UIHostingController(rootView: self.makeRow())

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .clear
    let label = UILabel()
    label.text = "UIKit"
    self.icon.contentMode = .scaleAspectFit
    self.icon.widthAnchor.constraint(equalToConstant: 24).isActive = true
    let row = UIStackView(arrangedSubviews: [self.icon, label, self.uiKitSwitch])
    row.spacing = 12
    row.alignment = .center
    self.uiKitSwitch.accessibilityIdentifier = "settings-uikit-switch"
    self.uiKitSwitch.isAccessibilityElement = true
    self.uiKitSwitch.accessibilityLabel = "UIKit 스위치"
    self.uiKitSwitch.accessibilityTraits = .button
    self.uiKitSwitch.addAction(UIAction { [weak self] _ in
      guard let self else { return }
      self.uiKitSwitch.accessibilityValue = self.uiKitSwitch.isOn ? "ON" : "OFF"
      self.onChange(self.uiKitSwitch.isOn)
    }, for: .valueChanged)

    self.addChild(self.host)
    self.host.view.backgroundColor = .clear
    let stack = UIStackView(arrangedSubviews: [row, self.host.view])
    stack.axis = .vertical
    stack.distribution = .fillEqually
    stack.spacing = 12
    stack.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(stack)
    NSLayoutConstraint.activate([
      stack.topAnchor.constraint(equalTo: self.view.topAnchor),
      stack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      stack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
    ])
    self.host.didMove(toParent: self)
  }

  func render(isOn: Bool, revision: Int, iconIsFilled: Bool, isEnabled: Bool, recreateSwitch: Bool) {
    self.loadViewIfNeeded()
    guard self.revision != revision || self.isEnabled != isEnabled
      || self.recreateSwitch != recreateSwitch else { return }
    let animated = self.revision != nil
    self.revision = revision
    self.isEnabled = isEnabled
    self.recreateSwitch = recreateSwitch
    self.iconIsFilled = iconIsFilled
    self.icon.image = UIImage(systemName: iconIsFilled ? "moon.fill" : "moon")
    self.rowRevision &+= 1
    self.host.rootView = self.makeRow()

    self.isOn = isOn
    self.uiKitSwitch.isEnabled = isEnabled
    self.uiKitSwitch.setOn(isOn, animated: animated)
    self.uiKitSwitch.accessibilityValue = isOn ? "ON" : "OFF"
    self.rowRevision &+= 1
    self.host.rootView = self.makeRow()
  }

  private func makeRow() -> SettingsSwiftUISwitchRow {
    SettingsSwiftUISwitchRow(
      isOn: self.isOn,
      revision: self.rowRevision,
      iconIsFilled: self.iconIsFilled,
      isEnabled: self.isEnabled,
      recreateSwitch: self.recreateSwitch,
      onChange: { [weak self] in self?.onChange($0) }
    )
  }
}

private struct SettingsSwiftUISwitchRow: View {
  let isOn: Bool
  let revision: Int
  let iconIsFilled: Bool
  let isEnabled: Bool
  let recreateSwitch: Bool
  let onChange: (Bool) -> Void

  var body: some View {
    HStack(spacing: 12) {
      Image(systemName: self.iconIsFilled ? "moon.fill" : "moon")
        .frame(width: 24)
      Text("SwiftUI")
      Spacer()
      SettingsSwiftUISwitch(isOn: self.isOn, revision: self.revision, onChange: self.onChange)
        .disabled(!self.isEnabled)
        .id(self.recreateSwitch ? self.revision : 0)
    }
  }
}

private struct SettingsSwiftUISwitch: View {
  let isOn: Bool
  let revision: Int
  let onChange: (Bool) -> Void
  @State private var pendingOn: (value: Bool, revision: Int)?

  private var displayedIsOn: Bool {
    guard let pendingOn = self.pendingOn, pendingOn.revision == self.revision else {
      return self.isOn
    }
    return pendingOn.value
  }

  var body: some View {
    SUBezierSwitch(isOn: Binding(
      get: { self.displayedIsOn },
      set: {
        self.pendingOn = ($0, self.revision)
        self.onChange($0)
      }
    ))
    .accessibilityIdentifier("settings-swiftui-switch")
    .accessibilityLabel("SwiftUI 스위치")
    .accessibilityValue(self.displayedIsOn ? "ON" : "OFF")
    .onChange(of: self.isOn) { _ in self.pendingOn = nil }
  }
}
