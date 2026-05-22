import SwiftUI
import BezierSwift

struct LegacyButtonCatalog: View {
  @State private var size: LegacyButtonSize = .medium
  @State private var typeFamily: LegacyTypeFamily = .primary
  @State private var color: LegacyButtonColor = .blue
  @State private var resizing: LegacyButtonResizing = .hug
  @State private var title: String = "Label"

  private var resolvedType: LegacyButtonType {
    switch self.typeFamily {
    case .primary:    return .primary(self.color)
    case .secondary:  return .secondary(self.color)
    case .tertiary:   return .tertiary(self.color)
    case .floating:   return .floating(self.color)
    }
  }

  var body: some View {
    CatalogScreen(title: "Legacy Button") {
      self.controls
      CatalogSection(.swiftUI) { self.preview }
      Text("Type Family × Color (size: medium, hug)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.matrix }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 8) {
        Text("Size").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Size", selection: self.$size) {
          ForEach(LegacyButtonSize.allCasesInOrder, id: \.self) { s in
            Text(s.displayName).tag(s)
          }
        }
        .pickerStyle(.segmented)
      }
      HStack(spacing: 8) {
        Text("Type").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Type", selection: self.$typeFamily) {
          ForEach(LegacyTypeFamily.allCases) { f in
            Text(f.rawValue).tag(f)
          }
        }
        .pickerStyle(.segmented)
      }
      HStack(spacing: 8) {
        Text("Color").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Color", selection: self.$color) {
          ForEach(LegacyButtonColor.allCasesInOrder, id: \.self) { c in
            Text(c.rawValue).tag(c)
          }
        }
        .pickerStyle(.menu)
      }
      HStack(spacing: 8) {
        Text("Resizing").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Resizing", selection: self.$resizing) {
          Text("hug").tag(LegacyButtonResizing.hug)
          Text("fill").tag(LegacyButtonResizing.fill)
        }
        .pickerStyle(.segmented)
      }
      HStack(spacing: 8) {
        Text("Title").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        TextField("Title", text: self.$title).textFieldStyle(.roundedBorder)
      }
    }
  }

  private var preview: some View {
    HStack {
      Spacer()
      LegacyBezierButton(
        size: self.size,
        type: self.resolvedType,
        resizing: self.resizing,
        title: self.title.isEmpty ? " " : self.title,
        action: {}
      )
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var matrix: some View {
    VStack(alignment: .leading, spacing: 12) {
      ForEach(LegacyTypeFamily.allCases) { family in
        VStack(alignment: .leading, spacing: 6) {
          Text(family.rawValue).font(.caption2).foregroundStyle(.secondary)
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(LegacyButtonColor.allCasesInOrder, id: \.self) { color in
                LegacyBezierButton(
                  size: .medium,
                  type: family.makeType(color: color),
                  resizing: .hug,
                  title: color.rawValue,
                  action: {}
                )
              }
            }
          }
        }
      }
    }
  }
}

enum LegacyTypeFamily: String, CaseIterable, Identifiable {
  case primary
  case secondary
  case tertiary
  case floating

  var id: String { self.rawValue }

  func makeType(color: LegacyButtonColor) -> LegacyButtonType {
    switch self {
    case .primary:    return .primary(color)
    case .secondary:  return .secondary(color)
    case .tertiary:   return .tertiary(color)
    case .floating:   return .floating(color)
    }
  }
}

extension LegacyButtonSize {
  static let allCasesInOrder: [LegacyButtonSize] = [.xsmall, .small, .medium, .large, .xlarge]

  var displayName: String {
    switch self {
    case .xsmall: return "xs"
    case .small:  return "s"
    case .medium: return "m"
    case .large:  return "l"
    case .xlarge: return "xl"
    }
  }
}

extension LegacyButtonColor {
  static let allCasesInOrder: [LegacyButtonColor] = [
    .blue, .cobalt, .green, .yellow, .orange, .red,
    .monochrome, .monochromeLight, .monochromeDark, .absoulteWhite,
  ]
}
