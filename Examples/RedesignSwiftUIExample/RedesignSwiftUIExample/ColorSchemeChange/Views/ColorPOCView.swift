//
//  ColorPOCView.swift
//  RedesignSwiftUIExample
//
//  Created by 구본욱 on 1/2/24.
//

import SwiftUI

struct ColorPOCView: View {
  enum Path: Int, Hashable {
    case colorPocSubview
  }

  private enum Option: Int, CaseIterable {
    case system
    case light
    case dark

    init(with colorScheme: ColorScheme?) {
      switch colorScheme {
      case .light:
        self = .light
      case .dark:
        self = .dark
      default:
        self = .system
      }
    }

    var title: String {
      switch self {
      case .dark:
        return "다크 모드"
      case .light:
        return "라이트 모드"
      case .system:
        return "시스템 설정 따르기"
      }
    }

    var colorScheme: ColorScheme? {
      switch self {
      case .dark:
        return .dark
      case .light:
        return .light
      case .system:
        return nil
      }
    }
  }

  @EnvironmentObject var colorSchemeManager: ColorSchemeManager
  @State private var isPresented: Bool = false

  var body: some View {
    self.content
  }
}

extension ColorPOCView {
  private var selectedOption: Option {
    return Option(with: self.colorSchemeManager.colorScheme)
  }

  private var content: some View {
    List {
      NavigationLink(value: Path.colorPocSubview) {
        Text("테마 설정이 상속되는지 확인하기 위해 하위 뷰를 푸쉬하기")
      }
      
      Button {
        self.isPresented = true
      } label : {
        Text("테마 설정이 상속되는지 확인하기 위해 하위 뷰를 프리젠트하기")
      }

      ForEach(Option.allCases, id: \.self) { item in
        Button {
          self.colorSchemeManager.change(item.colorScheme)
        } label: {
          HStack {
            let isSelected = self.selectedOption == item
            Text("\(isSelected ? "✅ " : "")\(item.title)")

            Spacer()
          }
          .frame(height: 40)
        }
      }
    }
    .navigationTitle("ColorPOCView")
    .navigationBarTitleDisplayMode(.inline)
    .navigationDestination(for: Path.self) { path in
      switch path {
      case .colorPocSubview:
        ColorPOCView()
      }
    }
    .sheet(isPresented: self.$isPresented) {
      ColorPOCSubview()
    }
  }
}

#Preview {
  ColorPOCView()
}
