import SwiftUI
import UIKit
import BezierSwift

struct SpinnerCatalog: View {
  @State private var size: BezierSpinnerSize = .size24

  var body: some View {
    CatalogScreen(title: "Spinner") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Size Row")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUISizeRow }
      CatalogSection(.uiKit) { self.uiKitSizeRow }
    }
  }

  private var controls: some View {
    HStack(spacing: 8) {
      Text("Size").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
      Picker("Size", selection: self.$size) {
        ForEach(BezierSpinnerSize.allCases, id: \.self) { s in
          Text(s.rawValue).tag(s)
        }
      }
      .pickerStyle(.menu)
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierSpinner(size: self.size)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierSpinner(size: self.size) },
        update: { spinner in
          spinner.size = self.size
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUISizeRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 16) {
        ForEach(BezierSpinnerSize.allCases, id: \.self) { size in
          VStack(spacing: 4) {
            SUBezierSpinner(size: size)
            Text(size.rawValue).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }

  private var uiKitSizeRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .center, spacing: 16) {
        ForEach(BezierSpinnerSize.allCases, id: \.self) { size in
          VStack(spacing: 4) {
            UIKitWrap { BezierSpinner(size: size) }.fixedSize()
            Text(size.rawValue).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }
}
