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
          SwiftUICornerRadiusGrid(specs: cornerRadiusSpecs)
        }
        CatalogSection(.uiKit) {
          UIKitCornerRadiusGrid(specs: cornerRadiusSpecs)
        }
      }
      VStack(alignment: .leading, spacing: 8) {
        Text("Corner Radius · length 기반")
          .font(.system(size: 13, weight: .semibold))
          .foregroundStyle(.secondary)
          .textCase(.uppercase)
        CatalogSection(.swiftUI) {
          SwiftUICornerRadiusGrid(specs: parameterizedRadiusSpecs)
        }
        CatalogSection(.uiKit) {
          UIKitCornerRadiusGrid(specs: parameterizedRadiusSpecs)
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
  var id: String { self.name }
}

private let cornerRadiusSpecs: [CornerRadiusSpec] = BezierCornerRadius.allCases
  .map { CornerRadiusSpec(type: $0, name: TokenName.caseName($0)) }

private let parameterizedRadiusLength: CGFloat = 80

private let parameterizedRadiusSpecs: [CornerRadiusSpec] = [
  BezierCornerRadius.roundHalf(length: parameterizedRadiusLength),
  BezierCornerRadius.roundAvatar(length: parameterizedRadiusLength),
].map { CornerRadiusSpec(type: $0, name: radiusLabel($0, length: parameterizedRadiusLength)) }

private func radiusLabel(_ type: BezierCornerRadius, length: CGFloat) -> String {
  let radius = type.pointValue
  let radiusText = radius == radius.rounded() ? "\(Int(radius))" : String(format: "%g", Double(radius))
  return "\(TokenName.caseName(type))(\(Int(length))) · \(radiusText)pt"
}

private struct SwiftUICornerRadiusGrid: View {
  let specs: [CornerRadiusSpec]

  private let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(self.specs) { spec in
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
  let specs: [CornerRadiusSpec]

  private let columns = [GridItem(.adaptive(minimum: 100), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(self.specs) { spec in
        VStack(spacing: 6) {
          UIKitWrap {
            let view = UIView()
            view.backgroundColor = UIColor.tintColor.withAlphaComponent(0.3)
            view.layer.cornerRadius = spec.type.pointValue
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
  var id: String { self.name }
}

private let elevationSpecs: [ElevationSpec] = BezierElevation.allCases
  .map { ElevationSpec(elevation: $0, name: TokenName.caseName($0)) }

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
  @Environment(\.colorScheme) private var colorScheme

  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 24)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 24) {
      ForEach(elevationSpecs) { spec in
        VStack(spacing: 8) {
          UIKitWrap({
            let shadow = spec.elevation.shadow
            let view = UIView()
            view.backgroundColor = .systemBackground
            view.layer.cornerRadius = 12
            view.layer.cornerCurve = .continuous
            view.layer.shadowOpacity = 1
            view.layer.shadowOffset = CGSize(width: shadow.offsetX, height: shadow.offsetY)
            view.layer.shadowRadius = shadow.blur
            view.layer.masksToBounds = false
            return view
          }, update: { (view: UIView) in
            // CGColor는 dynamic UIColor를 만든 시점의 trait로 굳는다. 스킴이 바뀌면 다시 넣어야 한다.
            let token = spec.elevation.shadow.color
            let components = self.colorScheme == .dark ? token.dark : token.light
            view.layer.shadowColor = components.uiColor.cgColor
          })
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
