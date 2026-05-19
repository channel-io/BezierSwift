//
//  BezierButtonTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierButtonTestView: View {
  @State private var size: BezierButtonSize = .medium
  @State private var variant: BezierButtonVariant = .filled
  @State private var semantic: BezierButtonSemantic = .primary
  @State private var title: String = "Label"
  @State private var hasLeadingIcon: Bool = false
  @State private var hasTrailingIcon: Bool = false
  @State private var isLoading: Bool = false
  @State private var isEnabled: Bool = true
  @State private var tapCount: Int = 0

  var body: some View {
    Form {
      Section("Preview") {
        VStack(spacing: 12) {
          SUBezierButton(
            size: self.size,
            variant: self.variant,
            semantic: self.semantic,
            title: self.title.isEmpty ? nil : self.title,
            leadingIcon: self.hasLeadingIcon ? Image(systemName: "star.fill") : nil,
            trailingIcon: self.hasTrailingIcon ? Image(systemName: "arrow.right") : nil,
            isLoading: self.isLoading,
            action: { self.tapCount += 1 }
          )
          .disabled(!self.isEnabled)

          Text("Tapped: \(self.tapCount)")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
      }

      Section("Size") {
        Picker("Size", selection: self.$size) {
          ForEach(BezierButtonSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Variant") {
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierButtonVariant.allCases, id: \.self) { variant in
            Text(variant.rawValue).tag(variant)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Semantic") {
        Picker("Semantic", selection: self.$semantic) {
          ForEach(BezierButtonSemantic.allCases, id: \.self) { semantic in
            Text(semantic.rawValue).tag(semantic)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Content") {
        TextField("Title", text: self.$title)
        Toggle("Leading Icon", isOn: self.$hasLeadingIcon)
        Toggle("Trailing Icon", isOn: self.$hasTrailingIcon)
      }

      Section("State") {
        Toggle("Enabled", isOn: self.$isEnabled)
        Toggle("Loading", isOn: self.$isLoading)
      }

      Section("Catalog") {
        ScrollView(.vertical) {
          VStack(alignment: .leading, spacing: 16) {
            ForEach(BezierButtonSize.allCases, id: \.self) { size in
              VStack(alignment: .leading, spacing: 8) {
                Text(size.rawValue)
                  .font(.caption.weight(.semibold))
                  .foregroundColor(.secondary)
                ForEach(BezierButtonVariant.allCases, id: \.self) { variant in
                  HStack(spacing: 8) {
                    ForEach(BezierButtonSemantic.allCases, id: \.self) { semantic in
                      SUBezierButton(
                        size: size,
                        variant: variant,
                        semantic: semantic,
                        title: "Label",
                        action: {}
                      )
                    }
                  }
                }
              }
            }
          }
          .padding(.vertical, 8)
        }
        .frame(height: 400)
      }
    }
    .navigationTitle("Button (SwiftUI)")
  }
}

struct BezierButtonTestView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierButtonTestView()
    }
  }
}
