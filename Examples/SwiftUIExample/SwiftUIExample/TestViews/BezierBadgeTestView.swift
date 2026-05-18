//
//  BezierBadgeTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierBadgeTestView: View {
  private enum ShapeKind: String, CaseIterable {
    case dot
    case numeric
    case text
  }

  @State private var size: BezierBadgeSize = .small
  @State private var variant: BezierBadgeVariant = .default
  @State private var shapeKind: ShapeKind = .text
  @State private var textValue: String = "Badge"
  @State private var numericValue: Double = 7
  @State private var hasLeadingIcon: Bool = false

  private var resolvedShape: BezierBadgeShape {
    switch self.shapeKind {
    case .dot:
      return .dot
    case .numeric:
      return .numeric(Int(self.numericValue))
    case .text:
      return .text(self.textValue.isEmpty ? "Badge" : self.textValue)
    }
  }

  var body: some View {
    Form {
      Section("Preview") {
        VStack(spacing: 16) {
          SUBezierBadge(
            size: self.size,
            variant: self.variant,
            shape: self.resolvedShape,
            leadingIcon: self.hasLeadingIcon ? Image(systemName: "plus") : nil
          )

          Image(systemName: "bell.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 36, height: 36)
            .bezierBadge(
              self.resolvedShape,
              size: self.size,
              variant: self.variant,
              leadingIcon: self.hasLeadingIcon ? Image(systemName: "plus") : nil
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
      }

      Section("Size") {
        Picker("Size", selection: self.$size) {
          ForEach(BezierBadgeSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Variant") {
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
            Text(variant.rawValue).tag(variant)
          }
        }
      }

      Section("Shape") {
        Picker("Shape", selection: self.$shapeKind) {
          ForEach(ShapeKind.allCases, id: \.self) { kind in
            Text(kind.rawValue).tag(kind)
          }
        }
        .pickerStyle(.segmented)

        switch self.shapeKind {
        case .dot:
          EmptyView()
        case .numeric:
          HStack {
            Text("Value: \(Int(self.numericValue))")
              .frame(width: 100, alignment: .leading)
            Slider(value: self.$numericValue, in: 0...150, step: 1)
          }
        case .text:
          TextField("Text", text: self.$textValue)
        }
      }

      Section("Content") {
        Toggle("Leading Icon", isOn: self.$hasLeadingIcon)
      }

      Section("Catalog") {
        ScrollView(.vertical) {
          VStack(alignment: .leading, spacing: 16) {
            ForEach(BezierBadgeSize.allCases, id: \.self) { size in
              VStack(alignment: .leading, spacing: 8) {
                Text(size.rawValue)
                  .font(.caption.weight(.semibold))
                  .foregroundColor(.secondary)
                self.row(size: size, shape: .text("Badge"))
                self.row(size: size, shape: .numeric(7))
                self.row(size: size, shape: .numeric(150))
                self.row(size: size, shape: .dot)
              }
            }
          }
          .padding(.vertical, 8)
        }
        .frame(height: 400)
      }
    }
    .navigationTitle("Badge (SwiftUI)")
  }

  private func row(size: BezierBadgeSize, shape: BezierBadgeShape) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
          SUBezierBadge(size: size, variant: variant, shape: shape)
        }
      }
    }
  }
}

struct BezierBadgeTestView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierBadgeTestView()
    }
  }
}
