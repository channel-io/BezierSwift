//
//  BezierAvatarGroupTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierAvatarGroupTestView: View {
  @State private var size: BezierAvatarGroupSize = .size24
  @State private var ellipsisType: BezierAvatarGroupEllipsisType = .icon
  @State private var avatarCount: Double = 5

  private let sampleImage = Image("AvatarSample")

  private var avatars: [Image?] {
    Array(repeating: self.sampleImage, count: Int(self.avatarCount))
  }

  var body: some View {
    Form {
      Section("Preview") {
        HStack {
          Spacer()
          SUBezierAvatarGroup(
            avatars: self.avatars,
            size: self.size,
            ellipsisType: self.ellipsisType
          )
          Spacer()
        }
        .padding(.vertical, 16)
      }

      Section("Size") {
        Picker("Size", selection: self.$size) {
          ForEach(BezierAvatarGroupSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
      }

      Section("Ellipsis Type") {
        Picker("EllipsisType", selection: self.$ellipsisType) {
          ForEach(BezierAvatarGroupEllipsisType.allCases, id: \.self) { type in
            Text(type.rawValue).tag(type)
          }
        }
        .pickerStyle(.segmented)
      }

      Section("Avatar Count: \(Int(self.avatarCount))") {
        Slider(value: self.$avatarCount, in: 0...10, step: 1)
      }

      Section("Catalog (4 variant × count)") {
        ScrollView(.vertical) {
          VStack(alignment: .leading, spacing: 24) {
            ForEach(BezierAvatarGroupSize.allCases, id: \.self) { size in
              ForEach(BezierAvatarGroupEllipsisType.allCases, id: \.self) { type in
                self.catalogRow(size: size, type: type)
              }
            }
          }
          .padding(.vertical, 8)
        }
        .frame(height: 480)
      }
    }
    .navigationTitle("AvatarGroup (SwiftUI)")
  }

  private func catalogRow(size: BezierAvatarGroupSize, type: BezierAvatarGroupEllipsisType) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("size=\(size.rawValue), ellipsisType=\(type.rawValue)")
        .font(.caption.weight(.semibold))
        .foregroundColor(.secondary)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 24) {
          ForEach([1, 2, 3, 4, 5, 8, 12], id: \.self) { count in
            VStack(alignment: .leading, spacing: 4) {
              Text("\(count)")
                .font(.caption2)
                .foregroundColor(.secondary)
              SUBezierAvatarGroup(
                avatars: Array(repeating: self.sampleImage, count: count),
                size: size,
                ellipsisType: type
              )
            }
          }
        }
      }
    }
  }
}

struct BezierAvatarGroupTestView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierAvatarGroupTestView()
    }
  }
}
