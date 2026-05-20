//
//  BezierBadgeTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierBadgeTestView: View {
  @State private var size: BezierBadgeSize = .small
  @State private var variant: BezierBadgeVariant = .default
  @State private var labelText: String = ""
  @State private var hasLeadingIcon: Bool = false

  var body: some View {
    Form {
      Section("Preview") {
        SUBezierBadge(
          size: self.size,
          variant: self.variant,
          label: self.labelText.isEmpty ? nil : self.labelText,
          leadingIcon: self.hasLeadingIcon ? Image(systemName: "plus") : nil
        )
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

      Section("Label") {
        TextField("Label", text: self.$labelText)
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
                self.row(size: size, leadingIcon: nil)
                self.row(size: size, leadingIcon: Image(systemName: "plus"))
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

  private func row(size: BezierBadgeSize, leadingIcon: Image?) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
          SUBezierBadge(size: size, variant: variant, label: "Badge", leadingIcon: leadingIcon)
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
