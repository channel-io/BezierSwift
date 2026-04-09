//
//  ColorUtil.swift
//  BezierSwift
//
//  Created by 구본욱 on 12/27/25.
//

import Foundation

enum ColorUtils {
  /// Pressed 상태의 색상을 계산합니다.
  /// - Parameters:
  ///   - originalColor: 원본 색상
  ///   - colorTheme: 컬러 테마 (light/dark)
  /// - Returns: Pressed 상태의 색상
  static func getPressedColor(
    originalColor: ColorComponentsWithAlpha,
    colorTheme: BezierColorTheme
  ) -> ColorComponentsWithAlpha {
    let hsl = Self.rgbToHSL(red: originalColor.red, green: originalColor.green, blue: originalColor.blue)
    let isAchromatic = hsl.saturation == 0

    let hue = hsl.hue
    var saturation = hsl.saturation
    var lightness = hsl.lightness
    var alpha = originalColor.alpha
    
    let originalAlpha = originalColor.alpha
    
    // Alpha 처리: 0%일 때
    if originalAlpha == 0 {
      alpha = isAchromatic ? 0.05 : 0.10
      // 이 경우에는 명도와 채도를 조절하지 않음
      return ColorComponentsWithAlpha(red: originalColor.red, green: originalColor.green, blue: originalColor.blue, alpha: alpha)
    }
    
    // Alpha 처리: 20% 이하일 때 1.5배 증가
    if originalAlpha <= 0.20 {
      alpha = min(originalAlpha * 1.5, 1.0)
    }
    
    // 채도가 90% 이상 또는 10% 이하면 채도 조절 안함
    let shouldAdjustSaturation = saturation > 0.10 && saturation < 0.90
    
    switch colorTheme {
    case .light:
      if lightness <= 0.17 && originalAlpha > 0.20 {
        // Brighter
        if isAchromatic {
          lightness = (lightness + 0.1) * 1.1
        } else {
          lightness = (lightness + 0.07) * 1.1
        }
        if shouldAdjustSaturation {
          saturation = saturation + 0.05
        }
      } else {
        // Darker (lightness > 17% or alpha <= 20%)
        lightness = lightness * 0.93
        if shouldAdjustSaturation {
          saturation = saturation - 0.03
        }
      }
    case .dark:
      if lightness < 0.83 && originalAlpha > 0.20 {
        // Brighter
        lightness = (lightness + 0.04) * 1.005
        if shouldAdjustSaturation {
          saturation = saturation + 0.05
        }
      } else {
        // Darker (lightness >= 83% or alpha <= 20%)
        if isAchromatic {
          lightness = (lightness - 0.04) * 0.97
        } else {
          lightness = (lightness - 0.2) * 0.98
        }
        if shouldAdjustSaturation {
          saturation = saturation - 0.03
        }
      }
    }
    
    // 값 범위 제한
    saturation = max(0, min(1, saturation))
    lightness = max(0, min(1, lightness))
    
    let rgb = ColorUtils.hslToRGB(hue: hue, saturation: saturation, lightness: lightness)
    return ColorComponentsWithAlpha(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: alpha)
  }

  /// RGB 값을 HSL로 변환합니다.
  /// - Parameters:
  ///   - red: 빨강 (0-255)
  ///   - green: 초록 (0-255)
  ///   - blue: 파랑 (0-255)
  /// - Returns: (hue: 0-360, saturation: 0-1, lightness: 0-1)
  static func rgbToHSL(
    red: Double,
    green: Double,
    blue: Double
  ) -> (hue: Double, saturation: Double, lightness: Double) {
    let r = red / 255.0
    let g = green / 255.0
    let b = blue / 255.0

    let maxVal = max(r, g, b)
    let minVal = min(r, g, b)
    let delta = maxVal - minVal

    // Lightness (0-1)
    let lightness = (maxVal + minVal) / 2.0

    // Saturation (0-1)
    var saturation: Double = 0
    if delta != 0 {
      saturation = delta / (1.0 - abs(2.0 * lightness - 1.0))
    }

    // Hue (0-360)
    var hue: Double = 0
    if delta != 0 {
      if maxVal == r {
        hue = 60.0 * (((g - b) / delta).truncatingRemainder(dividingBy: 6.0))
      } else if maxVal == g {
        hue = 60.0 * (((b - r) / delta) + 2.0)
      } else {
        hue = 60.0 * (((r - g) / delta) + 4.0)
      }
      if hue < 0 {
        hue += 360.0
      }
    }

    return (hue: hue, saturation: saturation, lightness: lightness)
  }
  
  /// HSL 값을 RGB로 변환합니다.
  /// - Parameters:
  ///   - hue: 색상 (0-360)
  ///   - saturation: 채도 (0-1)
  ///   - lightness: 명도 (0-1)
  /// - Returns: (red: 0-255, green: 0-255, blue: 0-255)
  static func hslToRGB(
    hue: Double,
    saturation: Double,
    lightness: Double
  ) -> (red: Double, green: Double, blue: Double) {
    var red: Double, green: Double, blue: Double
    
    if saturation == 0 {
      red = lightness
      green = lightness
      blue = lightness
    } else {
      let maxChannelValue = lightness < 0.5 ? lightness * (1 + saturation) : lightness + saturation - lightness * saturation
      let minChannelValue = 2 * lightness - maxChannelValue
      let hueNormalized = hue / 360.0

      red = ColorUtils.hueToRGB(
        minChannelValue: minChannelValue,
        maxChannelValue: maxChannelValue,
        hueOffset: hueNormalized + 1.0 / 3.0
      )
      green = ColorUtils.hueToRGB(
        minChannelValue: minChannelValue,
        maxChannelValue: maxChannelValue,
        hueOffset: hueNormalized
      )
      blue = ColorUtils.hueToRGB(
        minChannelValue: minChannelValue,
        maxChannelValue: maxChannelValue,
        hueOffset: hueNormalized - 1.0 / 3.0
      )
    }
    
    return (red: red * 255, green: green * 255, blue: blue * 255)
  }
}

extension ColorUtils {
  /// HSL→RGB 변환 시 사용되는 보조 함수
  /// - Parameters:
  ///   - minChannelValue: 색상 채널의 최솟값
  ///   - maxChannelValue: 색상 채널의 최댓값
  ///   - hueOffset: 정규화된 색상 오프셋 (0-1 범위)
  private static func hueToRGB(
    minChannelValue: Double,
    maxChannelValue: Double,
    hueOffset: Double
  ) -> Double {
    var adjustedHueOffset = hueOffset

    if adjustedHueOffset < 0 { adjustedHueOffset += 1 }
    if adjustedHueOffset > 1 { adjustedHueOffset -= 1 }

    let channelRange = maxChannelValue - minChannelValue

    if adjustedHueOffset < 1.0 / 6.0 {
      return minChannelValue + channelRange * 6 * adjustedHueOffset
    }
    if adjustedHueOffset < 1.0 / 2.0 {
      return maxChannelValue
    }
    if adjustedHueOffset < 2.0 / 3.0 {
      return minChannelValue + channelRange * (2.0 / 3.0 - adjustedHueOffset) * 6
    }
    return minChannelValue
  }
}
