import SwiftUI
import UIKit
import BezierSwift

struct IconCatalog: View {
  var body: some View {
    CatalogScreen(title: "Icon") {
      CatalogSection(.swiftUI) {
        IconGrid { icon in
          AnyView(
            icon.image
              .scaledToFit()
              .frame(width: 28, height: 28)
              .foregroundColor(.primary)
          )
        }
      }
      CatalogSection(.uiKit) {
        IconGrid { icon in
          AnyView(
            UIKitWrap {
              let imageView = UIImageView(image: icon.uiImage)
              imageView.contentMode = .scaleAspectFit
              imageView.tintColor = .label
              return imageView
            }
            .frame(width: 28, height: 28)
          )
        }
      }
    }
  }
}

private struct IconGrid: View {
  private static let allSortedIcons: [BezierIcon] = BezierIcon.allCases
    .sorted { $0.rawValue < $1.rawValue }

  let renderImage: (BezierIcon) -> AnyView

  private let columns = [GridItem(.adaptive(minimum: 84), spacing: 8)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 8) {
      ForEach(Self.allSortedIcons, id: \.self) { icon in
        VStack(spacing: 6) {
          self.renderImage(icon)
          Text(icon.rawValue.replacingOccurrences(of: "icon-", with: ""))
            .font(.system(size: 10))
            .lineLimit(1)
            .truncationMode(.middle)
            .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 76)
        .padding(8)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(Color.secondary.opacity(0.08))
        )
      }
    }
  }
}
