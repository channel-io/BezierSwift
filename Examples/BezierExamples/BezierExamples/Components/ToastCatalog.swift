import SwiftUI
import UIKit
import BezierSwift

struct ToastCatalog: View {
  @State private var preset: BezierToastPreset = .success
  @State private var title: String = "Message"

  private var displayTitle: String {
    self.title.isEmpty ? "Message" : self.title
  }

  var body: some View {
    CatalogScreen(title: "Toast") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
    .onAppear {
      // UIKit present 경로는 keyWindow에 컨테이너를 부착해야 하므로 명시적 prepare 필요.
      BezierToastManager.shared.prepare()
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      LabeledSegmented(label: "Preset", selection: self.$preset, options: BezierToastPreset.allCases)
      HStack(spacing: 8) {
        Text("Title")
          .font(.caption)
          .foregroundStyle(.secondary)
          .frame(width: 72, alignment: .leading)
        TextField("Title", text: self.$title)
          .textFieldStyle(.roundedBorder)
      }
    }
  }

  private var swiftUIPreview: some View {
    VStack(spacing: 16) {
      SUBezierToast(preset: self.preset, title: self.displayTitle)

      SUBezierButton(
        size: .medium,
        variant: .filled,
        semantic: .primary,
        title: "Present (SwiftUI)"
      ) {
        BezierSwift.showToast(preset: self.preset, title: self.displayTitle)
      }
    }
    .frame(maxWidth: .infinity)
  }

  private var uiKitPreview: some View {
    VStack(spacing: 16) {
      ToastUIKitRepresentable(preset: self.preset, title: self.displayTitle)

      SUBezierButton(
        size: .medium,
        variant: .filled,
        semantic: .secondary,
        title: "Present (UIKit)"
      ) {
        BezierToastManager.shared.show(preset: self.preset, title: self.displayTitle)
      }
    }
    .frame(maxWidth: .infinity)
  }
}

// UIKitWrap의 .fittingSizeLevel 계산은 긴 제목에서 라벨 압축 저항(750)이 제안 폭(50)을 이겨
// BezierToast가 maxWidth(460)까지 벌어지고 화면 폭을 넘는다. 표시 컨테이너(BezierToastManager)와
// 같은 제약으로 제안 폭을 required로 고정한 wrapper 안에서 toast가 hug·개행하게 한다.
private struct ToastUIKitRepresentable: UIViewRepresentable {
  let preset: BezierToastPreset
  let title: String

  func makeUIView(context: Context) -> UIView {
    let wrapper = UIView()
    let toast = BezierToast(preset: self.preset, title: self.title)
    wrapper.addSubview(toast)
    NSLayoutConstraint.activate([
      toast.topAnchor.constraint(equalTo: wrapper.topAnchor),
      toast.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor),
      toast.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
      toast.leadingAnchor.constraint(greaterThanOrEqualTo: wrapper.leadingAnchor),
      toast.trailingAnchor.constraint(lessThanOrEqualTo: wrapper.trailingAnchor),
    ])
    return wrapper
  }

  func updateUIView(_ uiView: UIView, context: Context) {
    guard let toast = uiView.subviews.compactMap({ $0 as? BezierToast }).first else { return }
    toast.preset = self.preset
    toast.title = self.title
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
    let width = proposal.width ?? BezierToastSpec.maxWidth
    let height = uiView.systemLayoutSizeFitting(
      CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
      withHorizontalFittingPriority: .required,
      verticalFittingPriority: .fittingSizeLevel
    ).height
    return CGSize(width: width, height: height)
  }
}
