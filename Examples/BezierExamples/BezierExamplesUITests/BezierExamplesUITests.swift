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
  func testLaunchPerformance() throws {
    measure(metrics: [XCTApplicationLaunchMetric()]) {
      XCUIApplication().launch()
    }
  }
}
