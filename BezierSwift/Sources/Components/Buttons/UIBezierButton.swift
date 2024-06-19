//
//  File.swift
//  
//
//  Created by 구본욱 on 6/18/24.
//

import UIKit

public class UIBezierButton: BaseControl {
  // MARK: - View Components
  private let contentStackView = UIStackView()
  private let prefixContentView = UIView()
  private let textLabel = UILabel()
  private let suffixContentView = UIView()

  private var configuration: BezierButtonConfiguration

  public init(configuration: BezierButtonConfiguration) {
    self.configuration = configuration

    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func initialize() {
    super.initialize()

    // MARK: - View Hierarchy
    self.addSubview(self.contentStackView)
    self.contentStackView.addArrangedSubview(self.prefixContentView)
    self.contentStackView.addArrangedSubview(self.textLabel)
    self.contentStackView.addArrangedSubview(self.suffixContentView)

    // MARK: - View Configuration
    self.backgroundColor = self.configuration.backgroundColor.uiColor(for: self.theme)
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.configuration.cornerRadius

    self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
    self.contentStackView.axis = .horizontal
    self.contentStackView.distribution = .fillProportionally
    self.contentStackView.alignment = .center
    self.contentStackView.spacing = self.configuration.horizontalSpacing
    self.contentStackView.isUserInteractionEnabled = false

    self.textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.textLabel.font = self.configuration.textFont.uiFont
    self.textLabel.textColor = self.configuration.textColor.uiColor(for: self.theme)
    self.textLabel.text = self.configuration.text
    self.textLabel.textAlignment = .center

    self.prefixContentView.translatesAutoresizingMaskIntoConstraints = false
    self.update(prefixContent: self.configuration.prefixContent)

    self.suffixContentView.translatesAutoresizingMaskIntoConstraints = false
    self.update(suffixContent: self.configuration.suffixContent)

    self.activityIndicatorContainerView.isHidden = true
    self.activityIndicatorView.hidesWhenStopped = true
    self.activityIndicatorView.style = .medium
    switch self.configuration.variant {
    case .tertiary:
      self.activityIndicatorView.color = BezierColor.bgBlackDark.uiColor(for: self.theme)
    default:
      self.activityIndicatorView.color = BezierColor.bgWhiteNormal.uiColor(for: self.theme)
    }
  }

  override func setLayouts() {
    super.setLayouts()

    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: self.configuration.height),
      self.contentStackView.leadingAnchor.constraint(
        equalTo: self.leadingAnchor,
        constant: self.configuration.horizontalPadding
      ),
      self.contentStackView.trailingAnchor.constraint(
        equalTo: self.trailingAnchor,
        constant: -self.configuration.horizontalPadding
      ),
      self.contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      self.prefixContentView.widthAnchor.constraint(equalToConstant: self.configuration.affixContentSize.width),
      self.prefixContentView.heightAnchor.constraint(equalToConstant: self.configuration.affixContentSize.height),
      self.suffixContentView.widthAnchor.constraint(equalToConstant: self.configuration.affixContentSize.width),
      self.suffixContentView.heightAnchor.constraint(equalToConstant: self.configuration.affixContentSize.height)
    ])
  }
}

// MARK: - Update Methods
extension UIBezierButton {
  public func update(text: String) {
    self.configuration.text = text
    self.textLabel.text = self.configuration.text
  }

  public func update(prefixContent: BezierButtonConfiguration.PrefixContent?) {
    let subviews = self.prefixContentView.subviews
    subviews.forEach { subview in
      subview.removeConstraints(subview.constraints)
      subview.removeFromSuperview()
    }

    switch prefixContent {
    case .icon(let icon):
      self.prefixContentView.isHidden = false
      let imageView = self.createSubview(for: icon)
      imageView.tintColor = self.configuration.affixContentForegroundColor.uiColor(for: self.theme)
      self.prefixContentView.addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.leadingAnchor.constraint(equalTo: self.prefixContentView.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: self.prefixContentView.trailingAnchor),
        imageView.topAnchor.constraint(equalTo: self.prefixContentView.topAnchor),
        imageView.bottomAnchor.constraint(equalTo: self.prefixContentView.bottomAnchor)
      ])

    case .none:
      self.prefixContentView.isHidden = true
    }
  }

  public func update(suffixContent: BezierButtonConfiguration.SuffixContent?) {
    let subviews = self.suffixContentView.subviews
    subviews.forEach { subview in
      subview.removeConstraints(subview.constraints)
      subview.removeFromSuperview()
    }

    switch suffixContent {
    case .icon(let icon):
      self.suffixContentView.isHidden = false
      let imageView = self.createSubview(for: icon)
      imageView.tintColor = self.configuration.affixContentForegroundColor.uiColor(for: self.theme)
      self.suffixContentView.addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.leadingAnchor.constraint(equalTo: self.suffixContentView.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: self.suffixContentView.trailingAnchor),
        imageView.topAnchor.constraint(equalTo: self.suffixContentView.topAnchor),
        imageView.bottomAnchor.constraint(equalTo: self.suffixContentView.bottomAnchor)
      ])

    case .none:
      self.suffixContentView.isHidden = true
    }
  }
}

// MARK: - Private Methods
extension UIBezierButton {
  private func createSubview(for bezierIcon: BezierIcon) -> UIImageView {
    let imageView = UIImageView()
    imageView.tintColor = self.configuration.affixContentForegroundColor.uiColor(for: self.theme)
    imageView.image = bezierIcon.uiImage
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }

  private func updateLoadingView() {
    if self.isLoading {
      self.isUserInteractionEnabled = false
      self.contentStackView.isHidden = true
      self.activityIndicatorContainerView.isHidden = false
      self.activityIndicatorView.startAnimating()
    } else {
      self.isUserInteractionEnabled = true
      self.contentStackView.isHidden = false
      self.activityIndicatorContainerView.isHidden = true
      self.activityIndicatorView.stopAnimating()
    }
  }
}

// MARK: - View Changes for Touch Event
extension UIBezierButton {
  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)

    guard self.isEnabled else { return }

    // TODO: 배경에 하이라이트 색상 적용
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    guard self.isEnabled else { return }

    // TODO: 배경에 일반 색상 적용
  }

  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)

    guard self.isEnabled else { return }

    // TODO: 배경에 일반 색상 적용
  }
}
