//
//  BezierSwitchControl.swift
//  BezierSwift
//
//  Created by 구본욱 on 10/23/24.
//

import SwiftUI

public struct BezierSwitchControl: View {
  @Binding public var isOn: Bool

  public init(isOn: Binding<Bool>) {
    self._isOn = isOn
  }

  public var body: some View {
    ZStack(alignment: self.alignment) {
      RoundedRectangle(cornerRadius: 100.0, style: .circular)
        .foregroundColor(self.backgroundColor)
        .frame(width: 44, height: 28)

      Circle()
        .foregroundColor(BezierColor.fgAbsoluteWhiteDark.color)
        .frame(width: 22, height: 22)
        .applyBezierShadow(.shadow2)
        .padding(3)
    }
    .onTapGesture {
      self.isOn.toggle()
    }
    .animation(.easeInOut(duration: 0.3), value: self.isOn)
    .padding(2)
    .compositingGroup()
  }
}

extension BezierSwitchControl {
  private var alignment: Alignment {
    self.isOn ? .leading : .trailing
  }

  private var backgroundColor: Color {
    self.isOn ? BezierColor.bgGreenNormal.color : BezierColor.bgBlackDark.color
  }
}

@available(iOS 18.0, *)
#Preview {
  @Previewable @State var isOn: Bool = false
  BezierSwitchControl(isOn: $isOn)
}
