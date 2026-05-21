//
//  BezierAvatarTestView.swift
//  SwiftUIExample
//

import SwiftUI
import BezierSwift

struct BezierAvatarTestView: View {
  @State private var size: BezierAvatarSize = .size48
  @State private var showBorder: Bool = false
  @State private var hasStatus: Bool = false
  @State private var statusType: BezierAvatarStatusType = .online
  @State private var isEnabled: Bool = true

  private let sampleImage = Image("AvatarSample")

  var body: some View {
    Form {
      Section("Preview") {
        HStack {
          Spacer()
          SUBezierAvatar(
            image: self.sampleImage,
            size: self.size,
            showBorder: self.showBorder,
            statusType: self.hasStatus ? self.statusType : nil
          )
          .disabled(!self.isEnabled)
          Spacer()
        }
        .padding(.vertical, 16)
      }

      Section("Size") {
        Picker("Size", selection: self.$size) {
          ForEach(BezierAvatarSize.allCases, id: \.self) { size in
            Text(size.rawValue).tag(size)
          }
        }
      }

      Section("Toggle") {
        Toggle("showBorder", isOn: self.$showBorder)
        Toggle("hasStatus", isOn: self.$hasStatus)
        Toggle("isEnabled", isOn: self.$isEnabled)
      }

      if self.hasStatus {
        Section("Status type") {
          Picker("Type", selection: self.$statusType) {
            ForEach(BezierAvatarStatusType.allCases, id: \.self) { type in
              Text(type.rawValue).tag(type)
            }
          }
        }
      }

      Section("Catalog (size별)") {
        ScrollView(.vertical) {
          VStack(alignment: .leading, spacing: 16) {
            self.catalogRow(label: "default", showBorder: false, statusType: nil)
            self.catalogRow(label: "showBorder", showBorder: true, statusType: nil)
            self.catalogRow(label: "status = online", showBorder: false, statusType: .online)
            self.catalogRow(label: "status = lock", showBorder: false, statusType: .lock)
            self.catalogRow(label: "status = onlineDnd", showBorder: false, statusType: .onlineDnd)
          }
          .padding(.vertical, 8)
        }
        .frame(height: 500)
      }
    }
    .navigationTitle("Avatar (SwiftUI)")
  }

  private func catalogRow(label: String, showBorder: Bool, statusType: BezierAvatarStatusType?) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(label)
        .font(.caption.weight(.semibold))
        .foregroundColor(.secondary)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 24) {
          ForEach(BezierAvatarSize.allCases, id: \.self) { size in
            SUBezierAvatar(
              image: self.sampleImage,
              size: size,
              showBorder: showBorder,
              statusType: statusType
            )
          }
        }
      }
    }
  }
}

struct BezierAvatarTestView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      BezierAvatarTestView()
    }
  }
}
