import XCTest

final class BezierExamplesUITests: XCTestCase {

  override func setUpWithError() throws {
    continueAfterFailure = false
  }

  @MainActor
  func testNavigationTitleAppears() throws {
    let app = XCUIApplication()
    app.launch()

    XCTAssertTrue(
      app.navigationBars["BezierExamples"].waitForExistence(timeout: 5),
      "BezierExamples navigation bar should appear after launch"
    )
  }

  @MainActor
  func testSettingsSwitchExternalUpdatesAndRollback() throws {
    let app = XCUIApplication()
    app.launchArguments = ["--switch-settings-demo"]
    app.launch()
    let uiKitSwitch = app.buttons["settings-uikit-switch"]
    let swiftUISwitch = app.buttons["settings-swiftui-switch"]
    XCTAssertTrue(swiftUISwitch.waitForExistence(timeout: 3))

    func expectValue(_ element: XCUIElement, _ value: String) {
      let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "value == %@", value), object: element)
      XCTAssertEqual(XCTWaiter.wait(for: [expectation], timeout: 3), .completed,
                     "\(element.identifier): expected \(value), actual \(String(describing: element.value))")
    }

    app.buttons["외부 ON"].tap()
    expectValue(uiKitSwitch, "ON")
    expectValue(swiftUISwitch, "ON")
    app.buttons["외부 OFF"].tap()
    expectValue(uiKitSwitch, "OFF")
    expectValue(swiftUISwitch, "OFF")

    for control in [uiKitSwitch, swiftUISwitch] {
      control.tap()
      expectValue(uiKitSwitch, "ON")
      expectValue(swiftUISwitch, "ON")
      app.buttons["외부 OFF"].tap()
      expectValue(control, "OFF")
    }

    app.switches["변경 거절 후 원복"].firstMatch.tap()
    for control in [uiKitSwitch, swiftUISwitch] {
      control.tap()
      XCTAssertTrue(app.staticTexts["변경 거절 · 기존 값 복원"].waitForExistence(timeout: 3))
      expectValue(control, "OFF")
      app.buttons["외부 OFF"].tap()
    }

    app.buttons["외부 ON"].tap()
    app.buttons["아이콘만 갱신"].tap()
    expectValue(uiKitSwitch, "ON")
    expectValue(swiftUISwitch, "ON")
  }

  @MainActor
  func testLaunchPerformance() throws {
    measure(metrics: [XCTApplicationLaunchMetric()]) {
      XCUIApplication().launch()
    }
  }
}
