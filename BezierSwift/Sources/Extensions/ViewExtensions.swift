//
//  File.swift
//
//
//  Created by Tom on 7/31/24.
//

import SwiftUI

// MARK: - Conditional View Modifiers
extension View {
  @ViewBuilder
  func `if`<Content: View>(
    _ condition: @autoclosure () -> Bool,
    transform: (Self) -> Content
  ) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }
  
  @ViewBuilder
  func `if`<TrueContent: View, FalseContent: View>(
    _ condition: @autoclosure () -> Bool,
    then: (Self) -> TrueContent,
    else: (Self) -> FalseContent
  ) -> some View {
    if condition() {
      then(self)
    } else {
      `else`(self)
    }
  }
}

// MARK: - Frame View Modifier
extension View {
  @ViewBuilder
  func frame(length: CGFloat) -> some View {
    self.frame(width: length, height: length)
  }
  
  @ViewBuilder
  func scaleToFit(size: CGSize, scaleBy: ScaleDimension = .width) -> some View {
    ScaleToFitView(size: size, scaleBy: scaleBy) {
      self
    }
  }
}

// MARK: - Scale To Fit Dimension
enum ScaleDimension {
  case width
  case height
  
  func getScale(targetSize: CGSize, currentSize: CGSize) -> CGFloat {
    switch self {
    case .width: targetSize.width / currentSize.width
    case .height: targetSize.height / currentSize.height
    }
  }
}

// MARK: - Scale To Fit Container View
private struct ScaleToFitView<Content: View>: View {
  private let targetSize: CGSize
  private let scaleDimension: ScaleDimension
  private let content: () -> Content
  
  @State private var currentSize: CGSize = .zero
  
  init(size targetSize: CGSize, scaleBy scaleDimension: ScaleDimension, @ViewBuilder content: @escaping () -> Content) {
    self.targetSize = targetSize
    self.scaleDimension = scaleDimension
    self.content = content
  }
  
  var body: some View {
    self.content()
      .frameSize { size in
        self.currentSize = size
      }
      .frame(width: self.targetSize.width, height: self.targetSize.height)
      .scaleEffect(self.scaleDimension.getScale(targetSize: self.targetSize, currentSize: self.currentSize))
  }
}

// MARK: - Size Preference Key
private struct SizeKey: PreferenceKey {
  static var defaultValue: CGSize = .zero

  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

// MARK: - View Modifier to Get Frame Size
extension View {
  @ViewBuilder
  func frameSize(completion: @escaping (CGSize) -> Void) -> some View {
    self.overlay(
      GeometryReader { proxy in
        Color.clear
          .preference(key: SizeKey.self, value: proxy.size)
          .onPreferenceChange(SizeKey.self) { value in
            completion(value)
          }
      }
    )
  }
}

// MARK: - Rect Preference Key
private struct RectKey: PreferenceKey {
  static var defaultValue: CGRect = .zero

  static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
    value = nextValue()
  }
}

// MARK: - View Modifier to Track Frame in Coordinate Space
extension View {
  @ViewBuilder
  func trackFrame(in coordinateSpace: CoordinateSpace, completion: @escaping (CGRect) -> Void) -> some View {
    self.overlay(
      GeometryReader { proxy in
        Color.clear
          .preference(key: RectKey.self, value: proxy.frame(in: coordinateSpace))
          .onPreferenceChange(RectKey.self) { value in
            completion(value)
          }
      }
    )
  }
}

// MARK: - Offset Preference Key
private struct OffsetKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero

  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

// MARK: - View Modifier to Get Offset
extension View {
  @ViewBuilder
  func offsetX(completion: @escaping (CGFloat) -> Void) -> some View {
    self.overlay(
      GeometryReader { proxy in
        let minX = proxy.frame(in: .global).minX
        Color.clear
          .preference(key: OffsetKey.self, value: minX)
          .onPreferenceChange(OffsetKey.self) { value in
            completion(value)
          }
      }
    )
  }
  
  @ViewBuilder
  func offsetY(completion: @escaping (CGFloat) -> Void) -> some View {
    self.overlay(
      GeometryReader { proxy in
        let minY = proxy.frame(in: .global).minY
        Color.clear
          .preference(key: OffsetKey.self, value: minY)
          .onPreferenceChange(OffsetKey.self) { value in
            completion(value)
          }
      }
    )
  }
}


