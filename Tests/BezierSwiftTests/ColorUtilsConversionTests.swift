//
//  ColorUtilsConversionTests.swift
//  BezierSwiftTests
//
//  Created by 구본욱 on 12/29/25.
//

import XCTest
@testable import BezierSwift

final class ColorUtilsConversionTests: XCTestCase {

  // MARK: - RGB → HSL → RGB 라운드트립 테스트

  func testRoundTrip_PrimaryColors() {
    let testCases: [(r: Double, g: Double, b: Double, name: String)] = [
      (255, 0, 0, "Red"),
      (0, 255, 0, "Green"),
      (0, 0, 255, "Blue"),
      (255, 255, 0, "Yellow"),
      (0, 255, 255, "Cyan"),
      (255, 0, 255, "Magenta"),
    ]

    for testCase in testCases {
      assertRoundTrip(r: testCase.r, g: testCase.g, b: testCase.b, name: testCase.name)
    }
  }

  func testRoundTrip_Grayscale() {
    let grayLevels: [Double] = [0, 64, 128, 192, 255]

    for gray in grayLevels {
      assertRoundTrip(r: gray, g: gray, b: gray, name: "Gray(\(Int(gray)))")
    }
  }

  func testRoundTrip_CommonColors() {
    let testColors: [(r: Double, g: Double, b: Double, name: String)] = [
      (59, 130, 246, "Blue-500"),
      (239, 68, 68, "Red-500"),
      (34, 197, 94, "Green-500"),
      (168, 85, 247, "Purple-500"),
      (251, 146, 60, "Orange-400"),
      (14, 165, 233, "Sky-500"),
      (236, 72, 153, "Pink-500"),
      (132, 204, 22, "Lime-500"),
    ]

    for testCase in testColors {
      assertRoundTrip(r: testCase.r, g: testCase.g, b: testCase.b, name: testCase.name)
    }
  }

  func testRoundTrip_EdgeCases() {
    let edgeCases: [(r: Double, g: Double, b: Double, name: String)] = [
      (0, 0, 0, "Black"),
      (255, 255, 255, "White"),
      (128, 128, 128, "Mid Gray"),
      (1, 1, 1, "Near Black"),
      (254, 254, 254, "Near White"),
    ]

    for testCase in edgeCases {
      assertRoundTrip(r: testCase.r, g: testCase.g, b: testCase.b, name: testCase.name)
    }
  }

  // MARK: - Helper

  private func assertRoundTrip(r: Double, g: Double, b: Double, name: String) {
    // RGB → HSL
    let hsl = ColorUtils.rgbToHSL(red: r, green: g, blue: b)

    // HSL → RGB
    let rgb = ColorUtils.hslToRGB(
      hue: hsl.hue,
      saturation: hsl.saturation,
      lightness: hsl.lightness
    )

    // ±1 오차 허용
    XCTAssertEqual(rgb.red, r, accuracy: 1.0, "\(name) - Red mismatch")
    XCTAssertEqual(rgb.green, g, accuracy: 1.0, "\(name) - Green mismatch")
    XCTAssertEqual(rgb.blue, b, accuracy: 1.0, "\(name) - Blue mismatch")
  }
}
