//
//  BezierBorder.swift
//
//
//  Created by Tom on 10/15/24.
//

import SwiftUI

public enum BorderAlignment {
  case inner
  case outer
  case center
}

extension View {
  // - MARK: BezierBorder
  /// - Parameters:
  ///   - shape: 테두리의 외곽을 정의하는 Shape 입니다.
  ///   - style: 테두리를 그릴 때 사용할 ShapeStyle 입니다.
  ///   - lineWidth: 테두리 선의 두께를 지정합니다.
  ///   - alignment: `inner`, `outer`, `center` 테두리 정렬이 가능합니다
  @ViewBuilder
  public func applyBezierBorder<BorderShape: Shape, BorderStyle: ShapeStyle>(
    shape: BorderShape,
    style: BorderStyle,
    lineWidth: CGFloat,
    alignment: BorderAlignment
  ) -> some View {
    BezierBorder(content: self, shape: shape, style: style, lineWidth: lineWidth, alignment: alignment)
  }
}

private struct BezierBorder<Content: View, BorderShape: Shape, BorderStyle: ShapeStyle>: View {
  private let content: Content
  private let shape: BorderShape
  private let style: BorderStyle
  private let lineWidth: CGFloat
  private let alignment: BorderAlignment
  
  init(content: Content, shape: BorderShape, style: BorderStyle, lineWidth: CGFloat, alignment: BorderAlignment) {
    self.content = content
    self.shape = shape
    self.style = style
    self.lineWidth = lineWidth
    self.alignment = alignment
  }
  
  var body: some View {
    self.content
      .overlay {
        switch self.alignment {
        case .inner:
          self.shape
            .stroke(self.style, lineWidth: self.lineWidth * 2)
            .mask { self.shape }
          
        case .outer:
          self.shape
            .stroke(self.style, lineWidth: self.lineWidth * 2)
            .mask {
              Rectangle()
                .inset(by: -self.lineWidth)
                .overlay {
                  self.shape
                    .blendMode(.destinationOut)
                }
            }
          
        case .center:
          self.shape
            .stroke(self.style, lineWidth: self.lineWidth)
        }
      }
  }
}

#Preview("Inner") {
  RoundedRectangle(cornerRadius: 20)
    .fill(BezierColor.bgYellowNormal.color)
    .applyBezierBorder(
      shape: RoundedRectangle(cornerRadius: 20),
      style: BezierColor.bgRedNormal.color.opacity(0.4),
      lineWidth: 6,
      alignment: .inner
    )
    .frame(width: 100, height: 100)
}

#Preview("Outer") {
  RoundedRectangle(cornerRadius: 20)
    .fill(BezierColor.bgYellowNormal.color)
    .applyBezierBorder(
      shape: RoundedRectangle(cornerRadius: 20),
      style: BezierColor.bgRedNormal.color.opacity(0.4),
      lineWidth: 6,
      alignment: .outer
    )
    .frame(width: 100, height: 100)
}

#Preview("Center") {
  RoundedRectangle(cornerRadius: 20)
    .fill(BezierColor.bgYellowNormal.color)
    .applyBezierBorder(
      shape: RoundedRectangle(cornerRadius: 20),
      style: BezierColor.bgRedNormal.color.opacity(0.4),
      lineWidth: 6,
      alignment: .center
    )
    .frame(width: 100, height: 100)
}
