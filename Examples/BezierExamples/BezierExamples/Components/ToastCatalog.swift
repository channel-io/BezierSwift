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
      UIKitWrap(
        { BezierToast(preset: self.preset, title: self.displayTitle) },
        update: { toast in
          toast.preset = self.preset
          toast.title = self.displayTitle
        }
      )
      .fixedSize()

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
