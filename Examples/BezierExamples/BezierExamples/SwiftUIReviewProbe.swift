#if DEBUG
import SwiftUI
import UIKit
import Combine
import BezierSwift

private struct ReviewEnvironmentKey: EnvironmentKey { static let defaultValue = "DEFAULT" }
private extension EnvironmentValues {
  var reviewMarker: String {
    get { self[ReviewEnvironmentKey.self] }
    set { self[ReviewEnvironmentKey.self] = newValue }
  }
}
private final class ReviewEnvironmentObject: ObservableObject { let marker = "OBJECT-INHERITED" }

struct SwiftUIReviewProbe: View {
  static var requestedCase: String? {
    let args = ProcessInfo.processInfo.arguments
    guard let index = args.firstIndex(of: "--swiftui-review"), args.indices.contains(index + 1) else { return nil }
    return args[index + 1]
  }
  let scenario: String
  @StateObject private var object = ReviewEnvironmentObject()
  var body: some View {
    NavigationStack {
      ScrollView {
        VStack(alignment: .leading, spacing: 22) {
          Text("실제 BezierSwift 컴포넌트 재현").font(.caption).foregroundStyle(.secondary)
          switch scenario {
          case "environment", "confirm-environment", "environment-object", "confirm-environment-object", "environment-initial", "confirm-environment-initial": ReviewEnvironmentProbe(scenario: scenario)
          case "confirm-update": ReviewConfirmProbe()
          case "retry", "confirm-retry": ReviewRetryProbe(confirm: scenario == "confirm-retry")
          case "toast": ReviewToastProbe()
          case "legacy-toast": ReviewLegacyToastProbe()
          case "card": ReviewCardProbe()
          case "accessibility": ReviewAccessibilityProbe()
          case "section": ReviewSectionProbe()
          default: Text("알 수 없는 재현 항목")
          }
        }.padding(20)
      }.navigationTitle(scenario).navigationBarTitleDisplayMode(.inline)
    }
    .environment(\.reviewMarker, "INHERITED")
    .environmentObject(object)
  }
}

private struct ReviewEnvironmentProbe: View {
  let scenario: String
  @State private var presented: Bool
  init(scenario: String) {
    self.scenario = scenario
    self._presented = State(initialValue: scenario.contains("initial"))
  }
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("부모 주입값: INHERITED / OBJECT-INHERITED")
      Text("모달에도 같은 값이 나타나야 합니다.")
      Button("모달 열기") { presented = true }.buttonStyle(.borderedProminent)
    }
    .bezierModal(isPresented: Binding(get: { presented && !scenario.hasPrefix("confirm") }, set: { presented = $0 })) {
      VStack(spacing: 20) {
        ReviewEnvironmentReader(readObject: scenario.contains("object"))
        Button("닫기") { presented = false }
      }.padding(30).background(.white)
    }
    .bezierConfirmModal(isPresented: Binding(get: { presented && scenario.hasPrefix("confirm") }, set: { presented = $0 }), title: "환경 상속", confirmAction: .init(title: "닫기", handler: {}), cancelAction: nil) {
      ReviewEnvironmentReader(readObject: scenario.contains("object"))
    }
  }
}
private struct ReviewEnvironmentReader: View {
  @Environment(\.reviewMarker) private var marker
  let readObject: Bool
  var body: some View {
    VStack {
      Text("모달 환경값: \(marker)")
      if readObject { ReviewObjectReader() }
    }.padding(12)
  }
}
private struct ReviewObjectReader: View {
  @EnvironmentObject private var object: ReviewEnvironmentObject
  var body: some View { Text("객체: \(object.marker)") }
}

private struct ReviewConfirmProbe: View {
  @State private var presented = false
  @State private var target = "A"
  @State private var confirmed = "미실행"
  var body: some View {
    let capturedTarget = target
    VStack(alignment: .leading, spacing: 20) {
      Text("현재 대상: \(target)")
      Text("확인 액션이 처리한 대상: \(confirmed)").font(.headline)
      Text("모달 안에서 B로 변경한 후 확인합니다. 제목과 처리 대상 모두 B여야 합니다.")
      Button("확인 모달 열기") { presented = true }.buttonStyle(.borderedProminent)
    }
    .bezierConfirmModal(isPresented: $presented, title: "대상 \(target)", description: "설명 \(target)", confirmAction: .init(title: "\(target) 확인", handler: { confirmed = capturedTarget }), cancelAction: .init(title: "취소", handler: {})) {
      VStack(spacing: 16) {
        Text("현재 선택: \(target)")
        Button("대상을 B로 변경") { target = "B" }.buttonStyle(.borderedProminent)
      }.padding(16)
    }
  }
}

private struct ReviewCardProbe: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("두 자식을 직접 전달 — 카드 1개 기대").font(.headline)
      SUBezierCard { Text("첫 번째 자식"); Text("두 번째 자식") }
      Text("빈 콘텐츠 — 패딩 높이의 카드 기대").font(.headline)
      SUBezierCard { EmptyView() }
      Text("위 두 사례 모두 카드 외형을 확인합니다.").font(.caption)
    }
  }
}
private struct ReviewSectionProbe: View {
  @State private var card = false
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("행의 횟수를 올린 후 스타일을 바꿉니다.")
      Button("스타일 변경: \(card ? "card" : "solid")") { card.toggle() }.buttonStyle(.borderedProminent)
      SUBezierSection(["stable-row"], id: \.self, variant: card ? .card : .solid) { _ in ReviewCounterRow() }
    }
  }
}
private struct ReviewCounterRow: View {
  @State private var count = 0
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("행 로컬 상태: \(count)").font(.title2)
      Button("행 횟수 +1") { count += 1 }.buttonStyle(.bordered)
    }.padding(16)
  }
}
private struct ReviewAccessibilityProbe: View {
  @State private var isOn = false
  @State private var checked = BezierCheckboxChecked.unchecked
  @State private var selected = false
  @State private var multi = false
  var body: some View {
    VStack(alignment: .leading, spacing: 18) {
      Text("각 컨트롤을 탭하고 접근성 value/traits를 비교합니다.")
      HStack { Text("Switch"); SUBezierSwitch(isOn: $isOn).accessibilityLabel("Review switch") }
      SUBezierCheckbox(label: "Review checkbox", checked: checked) { checked = $0 }
      SUBezierCheckbox(label: "Review mixed checkbox", checked: .indeterminate)
      SUBezierSelectOption(title: "Review select", isSelected: selected, onSelect: { selected.toggle() })
      SUBezierMultiSelectOption(title: "Review multi select", isSelected: multi, onToggle: { multi.toggle() })
      Text("실제 상태: switch=\(isOn.description), checkbox=\(String(describing: checked)), select=\(selected.description), multi=\(multi.description)").font(.caption)
    }
  }
}
private struct ReviewToastProbe: View {
  @State private var param: BezierToastParam?
  @State private var report = "대기"
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("A 표시 → 0.7초 후 B로 교체 → 0.1초 후 바인딩 검사")
      Text("현재 바인딩: \(param == nil ? "nil" : (param == BezierToastParam(title: "Toast B") ? "B" : "A"))").font(.headline)
      Text("교체 직후 기록: \(report)").font(.headline)
      Button("A → B 실행") {
        param = .init(title: "Toast A")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
          param = .init(title: "Toast B")
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            report = param == nil ? "nil (B 유실)" : "B 유지"
          }
        }
      }.buttonStyle(.borderedProminent)
    }.bezierToast(param: $param)
  }
}
private struct ReviewLegacyToastProbe: View {
  @State private var param: LegacyBezierToastParam?
  @State private var report = "대기"
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("A 표시 → 0.7초 후 B로 교체 → 0.1초 후 바인딩 검사")
      Text("현재 바인딩: \(param == nil ? "nil" : (param == LegacyBezierToastParam(title: "Toast B") ? "B" : "A"))").font(.headline)
      Text("교체 직후 기록: \(report)").font(.headline)
      Button("A → B 실행") {
        param = .init(title: "Toast A")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
          param = .init(title: "Toast B")
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            report = param == nil ? "nil (B 유실)" : "B 유지"
          }
        }
      }.buttonStyle(.borderedProminent)
    }.legacyBezierToast(param: $param)
  }
}

private final class ReviewRetryTracker {
  var reads = 0
  weak var anchor: UIViewController?
  var host: UIHostingController<AnyView>?
  var presented = false
  var container: UIViewController?
  func start(confirm: Bool) {
    let binding = Binding<Bool>(get: { [weak self] in self?.reads += 1; return self?.presented ?? false }, set: { _ in })
    let content: AnyView
    if confirm {
      content = AnyView(Color.clear.bezierConfirmModal(isPresented: binding, title: "분리된 anchor", confirmAction: .init(title: "확인", handler: {}), cancelAction: nil))
    } else {
      content = AnyView(Color.clear.bezierModal(isPresented: binding) { Text("분리된 anchor") })
    }
    let host = UIHostingController(rootView: content)
    self.host = host
    let container = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.flatMap(\.windows).first(where: { $0.rootViewController != nil && !$0.isHidden })?.rootViewController
    self.container = container
    container?.addChild(host)
    container?.view.addSubview(host.view)
    host.didMove(toParent: container)
    host.loadViewIfNeeded()
    host.view.frame = CGRect(x: 0, y: 0, width: 300, height: 200)
    host.view.setNeedsLayout()
    host.view.layoutIfNeeded()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
      self.anchor = host.children.first
      host.view.removeFromSuperview()
      self.presented = true
      host.rootView = content
      host.view.setNeedsLayout()
      host.view.layoutIfNeeded()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
      host.rootView = AnyView(EmptyView())
      host.view.setNeedsLayout()
      host.view.layoutIfNeeded()
      host.willMove(toParent: nil)
      host.removeFromParent()
      self.host = nil
      self.container = nil
      }
    }
  }
}
private struct ReviewRetryProbe: View {
  let confirm: Bool
  @State private var tracker = ReviewRetryTracker()
  @State private var report = "대기"
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("window 미부착 호스트 렌더 후 콘텐츠 제거. 제거 0.5초 이후에도 binding 읽기가 계속되는지 측정합니다.")
      Text(report).font(.headline).monospacedDigit()
      Button("분리 및 해제 재현") {
        tracker.start(confirm: confirm)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
          let first = tracker.reads
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            report = "제거 후 0.3초 읽기: \(tracker.reads - first)회\nanchor 생존: \(tracker.anchor != nil)\n누적 읽기: \(tracker.reads)"
            print("REVIEW_RETRY \(confirm ? "confirm" : "modal") \(report)")
          }
        }
      }.buttonStyle(.borderedProminent)
    }
  }
}
#endif
