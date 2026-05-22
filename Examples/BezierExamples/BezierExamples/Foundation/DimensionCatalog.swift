import SwiftUI
import UIKit
import BezierSwift

struct DimensionCatalog: View {
  var body: some View {
    CatalogScreen(title: "Dimension") {
      VStack(alignment: .leading, spacing: 8) {
        Text("Corner Radius")
          .font(.system(size: 13, weight: .semibold))
          .foregroundStyle(.secondary)
          .textCase(.uppercase)
        CatalogSection(.swiftUI) {
          SwiftUICornerRadiusGrid()
        }
        CatalogSection(.uiKit) {
          UIKitCornerRadiusGrid()
        }
      }
      VStack(alignment: .leading, spacing: 8) {
        Text("Elevation")
          .font(.system(size: 13, weight: .semibold))
          .foregroundStyle(.secondary)
          .textCase(.uppercase)
        CatalogSection(.swiftUI) {
          SwiftUIElevationGrid()
        }
        CatalogSection(.uiKit) {
          UIKitElevationGrid()
        }
      }
    }
  }
}

// MARK: - Corner Radius

private struct CornerRadiusSpec: Identifiable {
  let type: BezierCornerRadius
  let name: String
  let value: CGFloat
  var id: String { self.name }
}

private let cornerRadiusSpecs: [CornerRadiusSpec] = [
  .init(type: .round2,  name: "round2",  value: 2),
  .init(type: .round3,  name: "round3",  value: 3),
  .init(type: .round4,  name: "round4",  value: 4),
  .init(type: .round6,  name: "round6",  value: 6),
  .init(type: .round8,  name: "round8",  value: 8),
  .init(type: .round12, name: "round12", value: 12),
  .init(type: .round16, name: "round16", value: 16),
  .init(type: .round20, name: "round20", value: 20),
  .init(type: .round22, name: "round22", value: 22),
  .init(type: .round32, name: "round32", value: 32),
  .init(type: .round44, name: "round44", value: 44),
]

private struct SwiftUICornerRadiusGrid: View {
  private let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(cornerRadiusSpecs) { spec in
        VStack(spacing: 6) {
          Rectangle()
            .fill(Color.accentColor.opacity(0.3))
            .frame(width: 80, height: 80)
            .applyBezierCornerRadius(type: spec.type)
          Text(spec.name)
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
        }
      }
    }
  }
}

private struct UIKitCornerRadiusGrid: View {
  private let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(cornerRadiusSpecs) { spec in
        VStack(spacing: 6) {
          UIKitWrap {
            let view = UIView()
            view.backgroundColor = UIColor.tintColor.withAlphaComponent(0.3)
            view.layer.cornerRadius = spec.value
            view.layer.cornerCurve = .continuous
            return view
          }
          .frame(width: 80, height: 80)
          Text(spec.name)
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
        }
      }
    }
  }
}

// MARK: - Elevation

private struct ElevationSpec: Identifiable {
  let elevation: BezierElevation
  let name: String
  let shadowColor: BCSemanticToken
  let offsetX: CGFloat
  let offsetY: CGFloat
  let blur: CGFloat
  var id: String { self.name }
}

private let elevationSpecs: [ElevationSpec] = [
  .init(elevation: .mEv1, name: "mEv1", shadowColor: .elevationMedium, offsetX: 0, offsetY: 1,  blur: 4),
  .init(elevation: .mEv2, name: "mEv2", shadowColor: .elevationMedium, offsetX: 0, offsetY: 2,  blur: 6),
  .init(elevation: .mEv3, name: "mEv3", shadowColor: .elevationLarge,  offsetX: 0, offsetY: 4,  blur: 20),
  .init(elevation: .mEv4, name: "mEv4", shadowColor: .elevationXlarge, offsetX: 0, offsetY: 4,  blur: 24),
  .init(elevation: .mEv5, name: "mEv5", shadowColor: .elevationXlarge, offsetX: 0, offsetY: 6,  blur: 40),
  .init(elevation: .mEv6, name: "mEv6", shadowColor: .elevationXlarge, offsetX: 0, offsetY: 12, blur: 60),
]

private struct SwiftUIElevationGrid: View {
  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 24)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 24) {
      ForEach(elevationSpecs) { spec in
        VStack(spacing: 8) {
          RoundedRectangle(cornerRadius: 12, style: .continuous)
            .fill(Color(.systemBackground))
            .frame(width: 100, height: 60)
            .applyBezierElevation(spec.elevation)
          Text(spec.name)
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
        }
        .padding(8)
      }
    }
    .padding(.vertical, 12)
  }
}

private struct UIKitElevationGrid: View {
  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 24)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 24) {
      ForEach(elevationSpecs) { spec in
        VStack(spacing: 8) {
          UIKitWrap {
            let view = UIView()
            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 12
            view.layer.cornerCurve = .continuous
            view.layer.shadowColor = spec.shadowColor.palette(BezierExamplesComponent.shared).cgColor
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: spec.offsetX, height: spec.offsetY)
            view.layer.shadowRadius = spec.blur
            view.layer.masksToBounds = false
            return view
          }
          .frame(width: 100, height: 60)
          Text(spec.name)
            .font(.system(size: 11))
            .foregroundStyle(.secondary)
        }
        .padding(8)
      }
    }
    .padding(.vertical, 12)
  }
}
