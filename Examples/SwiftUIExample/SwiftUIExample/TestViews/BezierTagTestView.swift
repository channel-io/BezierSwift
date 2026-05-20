//
//  BezierTagTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierTagTestView: View {
  @State private var size: BezierTagSize = .small
  @State private var variant: BezierTagVariant = .default
  @State private var labelText: String = "Tag"
  @State private var hasOnDelete: Bool = false
  @State private var deleteCount: Int = 0

  var body: some View {
    Form {
      Section("Preview") {
        SUBezierTag(
          size: self.size,
          variant: self.variant,
          label: self.labelText.isEmpty ? nil : self.labelText,
          onDelete: self.hasOnDelete ? { self.deleteCount += 1 } : nil
        )
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
      }

      Section("Size") {
        Picker("Size", selection: self.$size) {
          ForEach(BezierTagSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Variant") {
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierTagVariant.allCases, id: \.self) { variant in
            Text(variant.rawValue).tag(variant)
          }
        }
      }

      Section("Label") {
        TextField("Label", text: self.$labelText)
      }

      Section("Content") {
        Toggle("onDelete enabled", isOn: self.$hasOnDelete)
        if self.hasOnDelete {
          Text("Delete tapped: \(self.deleteCount) times")
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }

      Section("Catalog") {
        ScrollView(.vertical) {
          VStack(alignment: .leading, spacing: 16) {
            ForEach(BezierTagSize.allCases, id: \.self) { size in
              VStack(alignment: .leading, spacing: 8) {
                Text(size.rawValue)
                  .font(.caption.weight(.semibold))
                  .foregroundColor(.secondary)
                self.row(size: size, hasOnDelete: false)
                self.row(size: size, hasOnDelete: true)
              }
            }
          }
          .padding(.vertical, 8)
        }
        .frame(height: 400)
      }
    }
    .navigationTitle("Tag (SwiftUI)")
  }

  private func row(size: BezierTagSize, hasOnDelete: Bool) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        ForEach(BezierTagVariant.allCases, id: \.self) { variant in
          SUBezierTag(
            size: size,
            variant: variant,
            label: "Tag",
            onDelete: hasOnDelete ? {} : nil
          )
        }
      }
    }
  }
}

struct BezierTagTestView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierTagTestView()
    }
  }
}
