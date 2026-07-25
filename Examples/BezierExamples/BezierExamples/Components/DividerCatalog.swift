import SwiftUI
import UIKit
import BezierSwift

struct DividerCatalog: View {
  @State private var sideIndent = true
  @State private var parallelIndent = true

  var body: some View {
    CatalogScreen(title: "Divider") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      Toggle("sideIndent", isOn: self.$sideIndent)
      Toggle("parallelIndent", isOn: self.$parallelIndent)
    }
    .font(.caption)
  }

  private var swiftUIPreview: some View {
    self.demoGroup {
      SUBezierDivider(sideIndent: self.sideIndent, parallelIndent: self.parallelIndent)
    }
  }

  private var uiKitPreview: some View {
    self.demoGroup {
      DividerUIKitRepresentable(sideIndent: self.sideIndent, parallelIndent: self.parallelIndent)
    }
  }

  @ViewBuilder
  private func demoGroup<Divider: View>(@ViewBuilder divider: () -> Divider) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      self.groupLabel("Group A")
      divider()
      self.groupLabel("Group B")
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  private func groupLabel(_ text: String) -> some View {
    Text(text)
      .font(.system(size: 13))
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.vertical, 8)
  }
}

// UIKitWrap은 systemLayoutSizeFitting(.fittingSizeLevel)로 너비를 계산하는데,
// BezierDivider는 intrinsic width가 없어 너비가 0으로 접힌다. 프리뷰에서 라인이
// 보이도록 sizeThatFits가 제안 너비를 그대로 반환하는 전용 래퍼를 사용한다.
private struct DividerUIKitRepresentable: UIViewRepresentable {
  let sideIndent: Bool
  let parallelIndent: Bool

  func makeUIView(context: Context) -> BezierDivider {
    BezierDivider(sideIndent: self.sideIndent, parallelIndent: self.parallelIndent)
  }

  func updateUIView(_ uiView: BezierDivider, context: Context) {
    uiView.sideIndent = self.sideIndent
    uiView.parallelIndent = self.parallelIndent
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: BezierDivider, context: Context) -> CGSize? {
    let height = BezierDividerConstant.lineThickness
      + (self.parallelIndent ? BezierDividerConstant.indentSize * 2 : 0)
    return CGSize(width: proposal.width ?? 320, height: height)
  }
}
