import Combine
import SwiftUI
import Testing
import UIKit
@testable import BezierSwift

@Suite("SwiftUI 컴포넌트 회귀", .serialized)
@MainActor
struct SwiftUIRegressionTests {}

extension SwiftUIRegressionTests {
  @Suite("상태 보존")
  @MainActor
  struct State {
    @Test("섹션 외형을 바꿔도 동일한 행의 로컬 상태를 유지한다")
    func sectionPreservesRowState() async throws {
      let model = SectionStateModel()
      let samples = SectionStateSamples()
      let host = UIHostingController(rootView: SectionStateFixture(model: model, samples: samples))
      let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
      window.rootViewController = host
      window.makeKeyAndVisible()
      defer {
        window.isHidden = true
        window.rootViewController = nil
      }

      try await waitForUI { samples.tokens[.solid] != nil }
      let original = try #require(samples.tokens[.solid])
      model.variant = .card
      try await waitForUI { samples.tokens[.card] != nil }
      #expect(samples.tokens[.card] == original)

      samples.tokens[.solid] = nil
      model.variant = .solid
      try await waitForUI { samples.tokens[.solid] != nil }
      #expect(samples.tokens[.solid] == original)
    }

    @Test("이전 토스트의 종료는 새 토스트 요청을 초기화하지 않는다")
    func replacementToastKeepsCurrentBinding() async throws {
      let model = ToastStateModel()
      let host = UIHostingController(rootView: ToastStateFixture(model: model))
      let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 390, height: 844))
      window.rootViewController = host
      window.makeKeyAndVisible()
      defer {
        window.isHidden = true
        window.rootViewController = nil
        BezierSwift.showToast(title: "테스트 정리")
      }

      try await waitForUI { model.appeared }
      let first = BezierToastParam(title: "첫 번째")
      let second = BezierToastParam(title: "두 번째")
      model.param = first
      try await waitForUI { currentToastTitle == "첫 번째" }
      model.param = second
      try await waitForUI { currentToastTitle == "두 번째" }
      #expect(model.param == second)
    }

    private var currentToastTitle: String? {
      guard let presentation = BezierSwift.shared.toastViewModel.toastPresentations.last,
        case .v3(_, let title) = presentation.content else { return nil }
      return title
    }

    private func waitForUI(_ condition: () -> Bool) async throws {
      for _ in 0..<200 {
        if condition() { return }
        try await Task.sleep(for: .milliseconds(10))
      }
      #expect(condition(), "SwiftUI 갱신이 제한 시간 안에 완료되어야 한다")
    }
  }

}

@MainActor
private final class SectionStateModel: ObservableObject {
  @Published var variant = BezierSectionVariant.solid
}

@MainActor
private final class SectionStateSamples {
  var tokens: [BezierSectionVariant: UUID] = [:]
}

private struct SectionStateFixture: View {
  @ObservedObject var model: SectionStateModel
  let samples: SectionStateSamples

  var body: some View {
    SUBezierSection([1], id: \.self, variant: model.variant) { _ in
      StatefulSectionRow(variant: model.variant, samples: samples)
    }
  }
}

private struct StatefulSectionRow: View {
  @State private var token = UUID()
  let variant: BezierSectionVariant
  let samples: SectionStateSamples

  var body: some View {
    SectionStateRecorder(token: token, variant: variant, samples: samples)
      .frame(height: 44)
  }
}

private struct SectionStateRecorder: UIViewRepresentable {
  let token: UUID
  let variant: BezierSectionVariant
  let samples: SectionStateSamples

  func makeUIView(context: Context) -> UIView { UIView() }

  func updateUIView(_ uiView: UIView, context: Context) {
    samples.tokens[variant] = token
  }
}

@MainActor
private final class ToastStateModel: ObservableObject {
  @Published var param: BezierToastParam?
  var appeared = false
}

private struct ToastStateFixture: View {
  @ObservedObject var model: ToastStateModel

  var body: some View {
    Color.clear
      .bezierToast(param: $model.param)
      .onAppear { model.appeared = true }
  }
}
