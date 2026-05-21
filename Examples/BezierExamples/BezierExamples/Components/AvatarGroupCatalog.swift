import SwiftUI
import UIKit
import BezierSwift

struct AvatarGroupCatalog: View {
  @State private var avatarCount: Int = 5
  @State private var size: BezierAvatarGroupSize = .size20
  @State private var ellipsisType: BezierAvatarGroupEllipsisType = .icon

  private let sampleImage = Image(systemName: "person.crop.circle.fill")
  private let sampleUIImage = UIImage(systemName: "person.crop.circle.fill")

  private var swiftUIAvatars: [Image?] {
    Array(repeating: self.sampleImage as Image?, count: self.avatarCount)
  }

  private var uiKitAvatars: [UIImage?] {
    Array(repeating: self.sampleUIImage, count: self.avatarCount)
  }

  var body: some View {
    CatalogScreen(title: "AvatarGroup") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Both Sizes × Both Ellipsis (count: 5)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIMatrix }
      CatalogSection(.uiKit) { self.uiKitMatrix }
    }
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      LabeledSegmented(label: "Size", selection: self.$size, options: BezierAvatarGroupSize.allCases)
      LabeledSegmented(label: "Ellipsis", selection: self.$ellipsisType, options: BezierAvatarGroupEllipsisType.allCases)
      HStack(spacing: 8) {
        Text("Count").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Stepper("\(self.avatarCount)", value: self.$avatarCount, in: 0...15)
      }
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierAvatarGroup(avatars: self.swiftUIAvatars, size: self.size, ellipsisType: self.ellipsisType)
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierAvatarGroup(avatars: self.uiKitAvatars, size: self.size, ellipsisType: self.ellipsisType) },
        update: { group in
          group.avatars = self.uiKitAvatars
          group.size = self.size
          group.ellipsisType = self.ellipsisType
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUIMatrix: some View {
    let images = Array(repeating: self.sampleImage as Image?, count: 5)
    return VStack(alignment: .leading, spacing: 10) {
      ForEach(BezierAvatarGroupSize.allCases, id: \.self) { size in
        ForEach(BezierAvatarGroupEllipsisType.allCases, id: \.self) { ellipsisType in
          HStack(spacing: 12) {
            Text("\(size.rawValue) · \(ellipsisType.rawValue)")
              .font(.caption2)
              .foregroundStyle(.secondary)
              .frame(width: 110, alignment: .leading)
            SUBezierAvatarGroup(avatars: images, size: size, ellipsisType: ellipsisType)
            Spacer(minLength: 0)
          }
        }
      }
    }
  }

  private var uiKitMatrix: some View {
    let images = Array(repeating: self.sampleUIImage, count: 5)
    return VStack(alignment: .leading, spacing: 10) {
      ForEach(BezierAvatarGroupSize.allCases, id: \.self) { size in
        ForEach(BezierAvatarGroupEllipsisType.allCases, id: \.self) { ellipsisType in
          HStack(spacing: 12) {
            Text("\(size.rawValue) · \(ellipsisType.rawValue)")
              .font(.caption2)
              .foregroundStyle(.secondary)
              .frame(width: 110, alignment: .leading)
            UIKitWrap { BezierAvatarGroup(avatars: images, size: size, ellipsisType: ellipsisType) }.fixedSize()
            Spacer(minLength: 0)
          }
        }
      }
    }
  }
}
