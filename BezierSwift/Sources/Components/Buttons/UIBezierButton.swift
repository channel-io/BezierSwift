//
//  File.swift
//  
//
//  Created by 구본욱 on 6/18/24.
//

import UIKit
import SnapKit

public class UIBezierButton: BaseControl {
  // MARK: - View Components
  private let contentStackView = UIStackView()
  private let prefixContentView = UIView()
  private let textLabel = UILabel()
  private let suffixContentView = UIView()
  private let activityIndicatorContainerView = UIView()
  // TODO: Spinner 구현전까지의 임의 구현으로, Spinner 구현 이후에 대체합니다. - by Finn 2024.06.21
  private let activityIndicatorView = UIActivityIndicatorView()

  private var configuration: BezierButtonConfiguration

  public override var isEnabled: Bool {
    didSet {
      self.alpha = self.isEnabled ? 1.0 : 0.4
    }
  }
  public var isLoading: Bool = false {
    didSet {
      self.updateLoadingView()
    }
  }

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
    self.addSubview(self.activityIndicatorContainerView)
    self.contentStackView.addArrangedSubview(self.prefixContentView)
    self.contentStackView.addArrangedSubview(self.textLabel)
    self.contentStackView.addArrangedSubview(self.suffixContentView)
    self.activityIndicatorContainerView.addSubview(self.activityIndicatorView)

    // MARK: - View Configuration
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.configuration.cornerRadius
    self.contentStackView.axis = .horizontal
    self.contentStackView.distribution = .fillProportionally
    self.contentStackView.alignment = .center
    self.contentStackView.spacing = self.configuration.horizontalSpacing
    self.contentStackView.isUserInteractionEnabled = false
    self.textLabel.textAlignment = .center
    self.textLabel.setContentHuggingPriority(.required, for: .horizontal)
    self.textLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.activityIndicatorContainerView.isHidden = true
    self.activityIndicatorView.hidesWhenStopped = true
    self.activityIndicatorView.style = .medium

    self.updateText()
    self.updatePrefixContent()
    self.updateSuffixContent()
    self.updateColor()
  }

  override func setLayouts() {
    super.setLayouts()

    self.snp.makeConstraints {
      $0.height.equalTo(self.configuration.height)
    }
    self.contentStackView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.directionalHorizontalEdges.equalToSuperview().inset(self.configuration.horizontalPadding)
    }
    self.prefixContentView.snp.makeConstraints {
      $0.size.equalTo(self.configuration.affixContentSize)
    }
    self.suffixContentView.snp.makeConstraints {
      $0.size.equalTo(self.configuration.affixContentSize)
    }
    self.activityIndicatorContainerView.snp.makeConstraints {
      $0.center.width.equalTo(self.contentStackView)
    }
    self.activityIndicatorView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(self.configuration.affixContentSize)
    }
  }

  public override func updateConstraints() {
    self.snp.updateConstraints {
      $0.height.equalTo(self.configuration.height)
    }
    self.contentStackView.snp.makeConstraints {
      $0.directionalHorizontalEdges.equalToSuperview().inset(self.configuration.horizontalPadding)
    }
    self.prefixContentView.snp.makeConstraints {
      $0.size.equalTo(self.configuration.affixContentSize)
    }
    self.suffixContentView.snp.makeConstraints {
      $0.size.equalTo(self.configuration.affixContentSize)
    }
    self.activityIndicatorView.snp.makeConstraints {
      $0.size.equalTo(self.configuration.affixContentSize)
    }

    super.updateConstraints()
  }
}

// MARK: - Public Methods
extension UIBezierButton {
  public func update(configuration: (inout BezierButtonConfiguration) -> Void) {
    let oldConfiguration = self.configuration
    configuration(&self.configuration)

    if oldConfiguration.size != self.configuration.size {
      self.updateSize()
    }
    if oldConfiguration.variant != self.configuration.variant || oldConfiguration.color != self.configuration.color {
      self.updateColor()
    }
    if oldConfiguration.text != self.configuration.text {
      self.updateText()
    }
    if oldConfiguration.prefixContent != self.configuration.prefixContent {
      self.updatePrefixContent()
    }
    if oldConfiguration.suffixContent != self.configuration.suffixContent {
      self.updateSuffixContent()
    }
  }
}

// MARK: - Private Methods
extension UIBezierButton {
  private func updateText() {
    self.textLabel.text = self.configuration.text
  }

  private func updatePrefixContent() {
    switch self.configuration.prefixContent {
    case .icon(let icon):
      self.prefixContentView.isHidden = false
      self.configureAffixContentView(for: icon, superView: self.prefixContentView)

    case .none:
      self.prefixContentView.isHidden = true
    }
  }

  private func updateSuffixContent() {
    switch self.configuration.suffixContent {
    case .icon(let icon):
      self.suffixContentView.isHidden = false
      self.configureAffixContentView(for: icon, superView: self.suffixContentView)

    case .none:
      self.suffixContentView.isHidden = true
    }
  }

  private func updateColor() {
    self.backgroundColor = self.configuration.backgroundColor.uiColor
    self.textLabel.font = self.configuration.textFont.uiFont
    self.textLabel.textColor = self.configuration.textColor.uiColor
    switch self.configuration.variant {
    case .tertiary:
      self.activityIndicatorView.color = BezierColor.bgBlackDark.uiColor
    default:
      self.activityIndicatorView.color = BezierColor.bgWhiteNormal.uiColor
    }
  }

  private func updateSize() {
    self.layer.cornerRadius = self.configuration.cornerRadius
    self.setNeedsUpdateConstraints()
  }
}

// MARK: - Private Methods
extension UIBezierButton {
  private func configureAffixContentView(for bezierIcon: BezierIcon, superView: UIView) {
    let subviews = superView.subviews
    subviews.forEach { subview in
      subview.removeFromSuperview()
    }

    let imageView = UIImageView()
    imageView.tintColor = self.configuration.affixContentForegroundColor.uiColor
    imageView.image = bezierIcon.uiImage
    imageView.contentMode = .scaleAspectFit

    superView.addSubview(imageView)

    imageView.snp.makeConstraints {
      $0.directionalEdges.equalToSuperview()
    }
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

    // TODO: 배경에 하이라이트 색상 적용할 것  - by Finn 2024.06.21
  }

  public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)

    guard self.isEnabled else { return }

    self.backgroundColor = self.configuration.backgroundColor.uiColor
  }

  public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)

    guard self.isEnabled else { return }

    self.backgroundColor = self.configuration.backgroundColor.uiColor
  }
}
