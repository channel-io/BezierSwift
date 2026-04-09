//
//  ColorUtilsPerformanceTests.swift
//  BezierSwiftTests
//
//  Created by 구본욱 on 12/29/25.
//

import XCTest
@testable import BezierSwift

final class ColorUtilsPerformanceTests: XCTestCase {

    private let testColors: [ColorComponentsWithAlpha] = [
        ColorComponentsWithAlpha(red: 59, green: 130, blue: 246, alpha: 1.0),   // blue
        ColorComponentsWithAlpha(red: 239, green: 68, blue: 68, alpha: 1.0),    // red
        ColorComponentsWithAlpha(red: 34, green: 197, blue: 94, alpha: 1.0),    // green
        ColorComponentsWithAlpha(red: 0, green: 0, blue: 0, alpha: 0.85),       // black 85%
        ColorComponentsWithAlpha(red: 255, green: 255, blue: 255, alpha: 0.1),  // white 10%
        ColorComponentsWithAlpha(red: 128, green: 128, blue: 128, alpha: 0.0),  // grey 0%
    ]

    // iOS UI Rendering Cycle 기준
    private let frame60fps: Double = 16.67   // ms (60fps)
    private let frame120fps: Double = 8.33   // ms (120fps ProMotion)

    // 최소 요구 사항: 1프레임 내 최소 처리 가능 횟수
    private let minimumCallsPerFrame = 10

    func testGetPressedColorPerformance() throws {
        // 워밍업 (JIT 컴파일, 캐시 등)
        for _ in 0..<1000 {
            for color in testColors {
                _ = ColorUtils.getPressedColor(originalColor: color, colorTheme: .light)
            }
        }

        // 단일 호출 평균 시간 측정
        let iterations = 100_000
        let start = CFAbsoluteTimeGetCurrent()
        for _ in 0..<iterations {
            for color in testColors {
                _ = ColorUtils.getPressedColor(originalColor: color, colorTheme: .light)
            }
        }
        let end = CFAbsoluteTimeGetCurrent()

        let totalCalls = iterations * testColors.count
        let totalTimeMs = (end - start) * 1000
        let perCallMs = totalTimeMs / Double(totalCalls)

        // 프레임당 처리 가능 횟수
        let callsPer60fpsFrame = Int(frame60fps / perCallMs)
        let callsPer120fpsFrame = Int(frame120fps / perCallMs)

        // 프레임 예산 대비 사용 비율
        let usagePercent60fps = (perCallMs * Double(minimumCallsPerFrame) / frame60fps) * 100
        let usagePercent120fps = (perCallMs * Double(minimumCallsPerFrame) / frame120fps) * 100

        printPerformanceReport(
            perCallMs: perCallMs,
            callsPer60fpsFrame: callsPer60fpsFrame,
            callsPer120fpsFrame: callsPer120fpsFrame,
            usagePercent60fps: usagePercent60fps,
            usagePercent120fps: usagePercent120fps
        )

        // 테스트 통과 조건: 120fps 기준 1프레임 내 최소 10개 이상 처리 가능해야 함
        XCTAssertGreaterThanOrEqual(
            callsPer120fpsFrame,
            minimumCallsPerFrame,
            "getPressedColor 성능 부족: 120fps 기준 1프레임 내 \(callsPer120fpsFrame)개만 처리 가능 (최소 \(minimumCallsPerFrame)개 필요)"
        )
    }

    private func printPerformanceReport(
        perCallMs: Double,
        callsPer60fpsFrame: Int,
        callsPer120fpsFrame: Int,
        usagePercent60fps: Double,
        usagePercent120fps: Double
    ) {
        print("")
        print("╔══════════════════════════════════════════════════════════════╗")
        print("║       getPressedColor - UI Rendering Cycle 성능 분석         ║")
        print("╠══════════════════════════════════════════════════════════════╣")
        print("║ 측정 기준                                                    ║")
        print("╟──────────────────────────────────────────────────────────────╢")
        print(String(format: "║  1회 호출 소요 시간: %.6f ms (%.0f 나노초)              ║", perCallMs, perCallMs * 1_000_000))
        print("╠══════════════════════════════════════════════════════════════╣")
        print("║ 60fps (16.67ms/frame) 기준                                   ║")
        print("╟──────────────────────────────────────────────────────────────╢")
        print(String(format: "║  1프레임 내 처리 가능 횟수: %d 회                          ║", callsPer60fpsFrame))
        print(String(format: "║  버튼 %d개 처리 시 프레임 예산 사용: %.4f%%               ║", minimumCallsPerFrame, usagePercent60fps))
        print("╠══════════════════════════════════════════════════════════════╣")
        print("║ 120fps ProMotion (8.33ms/frame) 기준                         ║")
        print("╟──────────────────────────────────────────────────────────────╢")
        print(String(format: "║  1프레임 내 처리 가능 횟수: %d 회                          ║", callsPer120fpsFrame))
        print(String(format: "║  버튼 %d개 처리 시 프레임 예산 사용: %.4f%%               ║", minimumCallsPerFrame, usagePercent120fps))
        print("╠══════════════════════════════════════════════════════════════╣")
        print("║ 테스트 조건                                                  ║")
        print("╟──────────────────────────────────────────────────────────────╢")
        print(String(format: "║  120fps 기준 1프레임 내 최소 %d개 처리 가능해야 통과       ║", minimumCallsPerFrame))
        print("╠══════════════════════════════════════════════════════════════╣")
        print("║ 결과                                                         ║")
        print("╟──────────────────────────────────────────────────────────────╢")
        if callsPer120fpsFrame >= minimumCallsPerFrame {
            print(String(format: "║  ✅ 통과 (%d개 처리 가능 >= %d개 필요)                      ║", callsPer120fpsFrame, minimumCallsPerFrame))
        } else {
            print(String(format: "║  ❌ 실패 (%d개 처리 가능 < %d개 필요)                       ║", callsPer120fpsFrame, minimumCallsPerFrame))
        }
        print("╚══════════════════════════════════════════════════════════════╝")
        print("")
    }
}
