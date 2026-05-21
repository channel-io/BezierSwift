import UIKit
import BezierSwift

final class BezierExamplesComponent: NSObject, BezierComponentable {
  static let shared = BezierExamplesComponent()

  var colorTheme: BezierColorTheme { .systemBezierColorTheme() }
  var componentTheme: BezierComponentTheme = .normal
}
