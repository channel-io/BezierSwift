import SwiftUI
import UIKit
import BezierSwift

struct ProgressBarCatalog: View {
  @State private var value: Double = 0.6
  @State private var variant: BezierProgressBarVariant = .default
  @State private var size: BezierProgressBarSize = .medium

  var body: some View {
    CatalogScreen(title: "ProgressBar") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Variant × Size")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIMatrix }
      CatalogSection(.uiKit) { self.uiKitMatrix }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 8) {
        Text("Variant").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierProgressBarVariant.allCases, id: \.self) { variant in
            Text(variant.rawValue).tag(variant)
          }
        }
        .pickerStyle(.segmented)
      }
      HStack(spacing: 8) {
        Text("Size").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Size", selection: self.$size) {
          ForEach(BezierProgressBarSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
        .pickerStyle(.segmented)
      }
      HStack(spacing: 8) {
        Text("Value").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Slider(value: self.$value, in: 0...1)
        Text("\(Int((self.value * 100).rounded()))%")
          .font(.caption.monospacedDigit())
          .frame(width: 44, alignment: .trailing)
      }
      HStack(spacing: 8) {
        ForEach([0.0, 0.25, 0.5, 0.75, 1.0], id: \.self) { preset in
          Button("\(Int(preset * 100))%") { self.value = preset }
            .font(.caption)
            .buttonStyle(.bordered)
        }
      }
    }
  }

  private var swiftUIPreview: some View {
    self.demoSurface(variant: self.variant) {
      SUBezierProgressBar(value: self.value, variant: self.variant, size: self.size)
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    self.demoSurface(variant: self.variant) {
      ProgressBarUIKitRepresentable(value: self.value, variant: self.variant, size: self.size)
    }
    .padding(.vertical, 8)
  }

  private var swiftUIMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierProgressBarVariant.allCases, id: \.self) { variant in
        ForEach(BezierProgressBarSize.allCases, id: \.self) { size in
          VStack(alignment: .leading, spacing: 4) {
            self.matrixLabel(variant: variant, size: size)
            self.demoSurface(variant: variant) {
              SUBezierProgressBar(value: self.value, variant: variant, size: size)
            }
          }
        }
      }
    }
    .padding(.vertical, 8)
  }

  private var uiKitMatrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(BezierProgressBarVariant.allCases, id: \.self) { variant in
        ForEach(BezierProgressBarSize.allCases, id: \.self) { size in
          VStack(alignment: .leading, spacing: 4) {
            self.matrixLabel(variant: variant, size: size)
            self.demoSurface(variant: variant) {
              ProgressBarUIKitRepresentable(value: self.value, variant: variant, size: size)
            }
          }
        }
      }
    }
    .padding(.vertical, 8)
  }

  private func matrixLabel(variant: BezierProgressBarVariant, size: BezierProgressBarSize) -> some View {
    Text("\(variant.rawValue) / \(size.rawValue)")
      .font(.caption2)
      .foregroundStyle(.secondary)
  }

  // overlaid variant는 콘텐츠 위 겹침 용도라 회색 콘텐츠 배경을 깔아 사용 맥락을 재현한다.
  @ViewBuilder
  private func demoSurface<Content: View>(
    variant: BezierProgressBarVariant,
    @ViewBuilder content: () -> Content
  ) -> some View {
    if variant == .overlaid {
      content()
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(.systemGray3)))
    } else {
      content()
        .padding(.vertical, 4)
    }
  }
}

// UIKitWrap은 systemLayoutSizeFitting(.fittingSizeLevel)로 너비를 계산하는데,
// BezierProgressBar는 intrinsic width가 없어 너비가 0으로 접힌다. 프리뷰에서 바가
// 보이도록 sizeThatFits가 제안 너비를 그대로 반환하는 전용 래퍼를 사용한다.
private struct ProgressBarUIKitRepresentable: UIViewRepresentable {
  let value: Double
  let variant: BezierProgressBarVariant
  let size: BezierProgressBarSize

  func makeUIView(context: Context) -> BezierProgressBar {
    BezierProgressBar(value: CGFloat(self.value), variant: self.variant, size: self.size)
  }

  func updateUIView(_ uiView: BezierProgressBar, context: Context) {
    uiView.variant = self.variant
    uiView.size = self.size
    uiView.setValue(CGFloat(self.value), animated: true)
  }

  func sizeThatFits(_ proposal: ProposedViewSize, uiView: BezierProgressBar, context: Context) -> CGSize? {
    CGSize(width: proposal.width ?? 320, height: self.size.height)
  }
}
