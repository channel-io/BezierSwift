import SwiftUI
import UIKit
import BezierSwift

struct EmojiCatalog: View {
  @State private var name: String = "grinning"
  @State private var size: BezierEmojiSize = .size48

  private let sampleNames = ["grinning", "smiley", "thumbsup", "heart", "tada"]

  var body: some View {
    CatalogScreen(title: "Emoji") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Size Row")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUISizeRow }
      CatalogSection(.uiKit) { self.uiKitSizeRow }
      Text("Names")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUINameRow }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 8) {
        Text("Name").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Name", selection: self.$name) {
          ForEach(self.sampleNames, id: \.self) { name in
            Text(name).tag(name)
          }
        }
        .pickerStyle(.menu)
      }
      HStack(spacing: 8) {
        Text("Size").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Size", selection: self.$size) {
          ForEach(BezierEmojiSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
        .pickerStyle(.menu)
      }
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierEmoji(name: self.name, size: self.size)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierEmoji(name: self.name, size: self.size) },
        update: { emoji in
          emoji.name = self.name
          emoji.size = self.size
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUISizeRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .bottom, spacing: 12) {
        ForEach(BezierEmojiSize.allCases, id: \.self) { size in
          VStack(spacing: 4) {
            SUBezierEmoji(name: self.name, size: size)
            Text(size.rawValue).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }

  private var uiKitSizeRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .bottom, spacing: 12) {
        ForEach(BezierEmojiSize.allCases, id: \.self) { size in
          VStack(spacing: 4) {
            UIKitWrap(
              { BezierEmoji(name: self.name, size: size) },
              update: { emoji in
                emoji.name = self.name
              }
            )
            .fixedSize()
            Text(size.rawValue).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }

  private var swiftUINameRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 12) {
        ForEach(self.sampleNames, id: \.self) { name in
          VStack(spacing: 4) {
            SUBezierEmoji(name: name, size: .size48)
            Text(name).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }
}
