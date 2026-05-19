//
//  BezierIconButtonTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierIconButtonTestView: View {
  private enum IconOption: String, CaseIterable, Identifiable {
    case xmark
    case plus
    case trash
    case ellipsis
    case arrowRight = "arrow.right"

    var id: String { self.rawValue }
    var systemName: String { self.rawValue }
    var label: String { self.rawValue }
  }

  @State private var size: BezierIconButtonSize = .medium
  @State private var variant: BezierIconButtonVariant = .ghost
  @State private var iconOption: IconOption = .xmark
  @State private var isLoading: Bool = false
  @State private var isEnabled: Bool = true
  @State private var isActive: Bool = false
  @State private var tapCount: Int = 0

  var body: some View {
    Form {
      Section("Preview") {
        VStack(spacing: 12) {
          SUBezierIconButton(
            size: self.size,
            variant: self.variant,
            icon: Image(systemName: self.iconOption.systemName),
            isActive: self.isActive,
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
          ForEach(BezierIconButtonSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Variant") {
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierIconButtonVariant.allCases, id: \.self) { variant in
            Text(variant.rawValue).tag(variant)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Icon") {
        Picker("Icon", selection: self.$iconOption) {
          ForEach(IconOption.allCases) { option in
            Text(option.label).tag(option)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("State") {
        Toggle("Active", isOn: self.$isActive)
        Toggle("Enabled", isOn: self.$isEnabled)
        Toggle("Loading", isOn: self.$isLoading)
      }

      Section("Catalog") {
        ScrollView(.vertical) {
          VStack(alignment: .leading, spacing: 16) {
            ForEach(BezierIconButtonSize.allCases, id: \.self) { size in
              VStack(alignment: .leading, spacing: 8) {
                Text(size.rawValue)
                  .font(.caption.weight(.semibold))
                  .foregroundColor(.secondary)
                HStack(spacing: 8) {
                  ForEach(BezierIconButtonVariant.allCases, id: \.self) { variant in
                    SUBezierIconButton(
                      size: size,
                      variant: variant,
                      icon: Image(systemName: "xmark"),
                      action: {}
                    )
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
    .navigationTitle("IconButton (SwiftUI)")
  }
}

struct BezierIconButtonTestView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierIconButtonTestView()
    }
  }
}
