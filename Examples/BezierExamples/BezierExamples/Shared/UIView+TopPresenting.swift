import UIKit

extension UIView {
  var topPresentingViewController: UIViewController? {
    guard var controller = self.window?.rootViewController else { return nil }
    while let presented = controller.presentedViewController {
      controller = presented
    }
    return controller
  }
}
