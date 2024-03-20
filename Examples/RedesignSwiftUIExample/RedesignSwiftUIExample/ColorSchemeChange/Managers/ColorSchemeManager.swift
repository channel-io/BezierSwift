//
//  ColorSchemeManager.swift
//  RedesignSwiftUIExample
//
//  Created by 구본욱 on 2/14/24.
//

import SwiftUI

final class ColorSchemeManager: ObservableObject {
  @Published var colorScheme: ColorScheme?

  func change(_ scheme: ColorScheme?) {
    self.colorScheme = scheme
  }
}
