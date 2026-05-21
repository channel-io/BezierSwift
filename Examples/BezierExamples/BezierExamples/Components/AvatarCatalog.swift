import SwiftUI
import UIKit
import BezierSwift

struct AvatarCatalog: View {
  @State private var size: BezierAvatarSize = .size48
  @State private var showBorder: Bool = false
  @State private var statusType: BezierAvatarStatusType? = nil

  private let sampleImage = Image(systemName: "person.crop.circle.fill")
  private let sampleUIImage = UIImage(systemName: "person.crop.circle.fill")

  var body: some View {
    CatalogScreen(title: "Avatar") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Size Row")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUISizeRow }
      CatalogSection(.uiKit) { self.uiKitSizeRow }
      Text("Avatar Status (type × size)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIStatusMatrix }
      CatalogSection(.uiKit) { self.uiKitStatusMatrix }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(spacing: 8) {
        Text("Size").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Size", selection: self.$size) {
          ForEach(BezierAvatarSize.allCases, id: \.self) { s in
            Text(s.rawValue).tag(s)
          }
        }
        .pickerStyle(.menu)
      }
      Toggle("Show Border", isOn: self.$showBorder).font(.callout)
      HStack(spacing: 8) {
        Text("Status").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Status", selection: self.$statusType) {
          Text("None").tag(BezierAvatarStatusType?.none)
          ForEach(BezierAvatarStatusType.allCases, id: \.self) { type in
            Text(type.rawValue).tag(BezierAvatarStatusType?.some(type))
          }
        }
        .pickerStyle(.menu)
      }
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierAvatar(image: self.sampleImage, size: self.size, showBorder: self.showBorder, statusType: self.statusType)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierAvatar(image: self.sampleUIImage, size: self.size, showBorder: self.showBorder, statusType: self.statusType) },
        update: { avatar in
          avatar.image = self.sampleUIImage
          avatar.size = self.size
          avatar.showBorder = self.showBorder
          avatar.statusType = self.statusType
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUISizeRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 12) {
        ForEach(BezierAvatarSize.allCases, id: \.self) { size in
          VStack(spacing: 4) {
            SUBezierAvatar(image: self.sampleImage, size: size)
            Text(size.rawValue).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }

  private var uiKitSizeRow: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(alignment: .top, spacing: 12) {
        ForEach(BezierAvatarSize.allCases, id: \.self) { size in
          VStack(spacing: 4) {
            UIKitWrap { BezierAvatar(image: self.sampleUIImage, size: size) }.fixedSize()
            Text(size.rawValue).font(.caption2).foregroundStyle(.secondary)
          }
        }
      }
    }
  }

  private var swiftUIStatusMatrix: some View {
    VStack(alignment: .leading, spacing: 10) {
      ForEach(BezierAvatarStatusType.allCases, id: \.self) { type in
        VStack(alignment: .leading, spacing: 4) {
          Text(type.rawValue).font(.caption2).foregroundStyle(.secondary)
          HStack(spacing: 12) {
            ForEach(BezierAvatarStatusSize.allCases, id: \.self) { size in
              SUBezierAvatarStatus(type: type, size: size)
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  private var uiKitStatusMatrix: some View {
    VStack(alignment: .leading, spacing: 10) {
      ForEach(BezierAvatarStatusType.allCases, id: \.self) { type in
        VStack(alignment: .leading, spacing: 4) {
          Text(type.rawValue).font(.caption2).foregroundStyle(.secondary)
          HStack(spacing: 12) {
            ForEach(BezierAvatarStatusSize.allCases, id: \.self) { size in
              UIKitWrap { BezierAvatarStatus(type: type, size: size) }.fixedSize()
            }
            Spacer(minLength: 0)
          }
        }
      }
    }
  }
}
