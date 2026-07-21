//
//  BezierToastManager.swift
//  BezierSwift
//

import UIKit

public protocol BezierToastManageable: AnyObject {
  /// keyWindow에 Toast 컨테이너를 부착한다. window 교체(로그인/로그아웃 등) 후 재호출 필요.
  func prepare()
  func show(preset: BezierToastPreset, title: String)
}

public extension BezierToastManageable {
  func show(title: String) {
    self.show(preset: .info, title: title)
  }
}

/// UIKit 전용 전역 Toast 매니저. SwiftUI `BezierSwift.showToast(...)`(BezierWindow 파이프라인)와 독립적으로,
/// keyWindow에 부착한 pass-through 컨테이너에 `BezierToast` UIView를 표시한다.
public final class BezierToastManager: BezierToastManageable {
  public static let shared = BezierToastManager()

  private enum Constant {
    static let maxToastCount = 1
    static let autoDismissTime: TimeInterval = 3.0
    static let containerTopInset: CGFloat = 4
    static let horizontalInset: CGFloat = 10
    static let animationDuration: TimeInterval = 0.3
  }

  private weak var containerView: BezierToastPassthroughContainer?
  private var presentedToasts: [BezierToast] = []

  private init() {}

  // MARK: - Prepare

  public func prepare() {
    guard let keyWindow = Self.keyWindow() else { return }
    if let containerView = self.containerView, containerView.superview === keyWindow { return }

    self.containerView?.removeFromSuperview()

    let container = BezierToastPassthroughContainer()
    container.backgroundColor = .clear
    container.translatesAutoresizingMaskIntoConstraints = false
    keyWindow.addSubview(container)
    container.layer.zPosition = 1

    NSLayoutConstraint.activate([
      container.topAnchor.constraint(
        equalTo: keyWindow.safeAreaLayoutGuide.topAnchor,
        constant: Constant.containerTopInset
      ),
      container.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
      container.bottomAnchor.constraint(lessThanOrEqualTo: keyWindow.bottomAnchor),
    ])

    self.containerView = container
  }

  // MARK: - Show

  public func show(preset: BezierToastPreset = .info, title: String) {
    self.prepare()
    guard let container = self.containerView else { return }

    while self.presentedToasts.count >= Constant.maxToastCount {
      let toast = self.presentedToasts.removeFirst()
      self.dismiss(toast)
    }

    let position = BezierToastPosition.top
    let toast = BezierToast(preset: preset, title: title)
    toast.alpha = 0
    toast.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(toast)

    let topConstraint = toast.topAnchor.constraint(
      equalTo: container.topAnchor,
      constant: position.startOffsetY
    )
    NSLayoutConstraint.activate([
      topConstraint,
      toast.centerXAnchor.constraint(equalTo: container.centerXAnchor),
      toast.leadingAnchor.constraint(
        greaterThanOrEqualTo: container.leadingAnchor,
        constant: Constant.horizontalInset
      ),
      toast.trailingAnchor.constraint(
        lessThanOrEqualTo: container.trailingAnchor,
        constant: -Constant.horizontalInset
      ),
    ])

    self.presentedToasts.append(toast)

    // enter: 상단에서 슬라이드 다운 + 페이드 인
    container.layoutIfNeeded()
    UIView.animate(withDuration: Constant.animationDuration, delay: 0, options: .curveEaseInOut) {
      topConstraint.constant = position.endOffsetY
      toast.alpha = 1
      container.layoutIfNeeded()
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + Constant.autoDismissTime) { [weak self, weak toast] in
      guard let self, let toast, let index = self.presentedToasts.firstIndex(where: { $0 === toast }) else { return }

      self.presentedToasts.remove(at: index)
      self.dismiss(toast)
    }
  }

  // MARK: - Dismiss

  private func dismiss(_ toast: BezierToast) {
    UIView.animate(
      withDuration: Constant.animationDuration,
      delay: 0,
      options: .curveEaseInOut,
      animations: { toast.alpha = 0 },
      completion: { _ in toast.removeFromSuperview() }
    )
  }

  // MARK: - Helper

  private static func keyWindow() -> UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .flatMap { $0.windows }
      .first { $0.isKeyWindow }
  }
}

/// 컨테이너 자기 자신(빈 영역)에 닿은 터치는 하위 뷰로 통과시키고, Toast 셀 위 터치만 흡수하는 pass-through 컨테이너.
private final class BezierToastPassthroughContainer: UIView {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let hitView = super.hitTest(point, with: event)
    return hitView === self ? nil : hitView
  }
}
