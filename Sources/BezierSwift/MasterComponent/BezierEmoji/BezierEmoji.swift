//
//  BezierEmoji.swift
//  BezierSwift
//

import UIKit

/// 채널톡 이모지 에셋을 지정된 크기로 표시하는 이미지 컴포넌트 (UIKit).
/// `name`만으로 CDN URL과 에셋 해상도가 자동 결정된다. SwiftUI에서는 `SUBezierEmoji`를 사용한다.
public final class BezierEmoji: UIView {
  // MARK: - Public Properties

  /// 채널톡 이모지 이름 (예: `grinning`, `smiley`). 유니코드 이모지 문자가 아니라 에셋 이름을 전달한다.
  /// 유효하지 않은 이름이면 빈 영역으로 렌더된다.
  public var name: String {
    didSet {
      guard oldValue != self.name else { return }
      self.accessibilityLabel = self.name
      self.reloadImage()
    }
  }

  /// 이모지 크기. 기본값은 `.size24`다.
  public var size: BezierEmojiSize = .size24 {
    didSet {
      guard oldValue != self.size else { return }
      self.refreshLayout()
      self.reloadImage()
    }
  }

  // MARK: - Subviews

  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()

  // MARK: - Private Properties

  private var widthConstraint: NSLayoutConstraint?
  private var heightConstraint: NSLayoutConstraint?

  private var currentURL: URL?
  private var loadTask: Task<Void, Never>?

  // MARK: - Init

  /// 이모지 이름과 크기를 지정해 이모지를 만든다.
  public init(name: String, size: BezierEmojiSize = .size24) {
    self.name = name
    self.size = size
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    self.name = ""
    super.init(coder: coder)
    self.setUp()
  }

  deinit {
    self.loadTask?.cancel()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false
    self.isAccessibilityElement = true
    self.accessibilityTraits = .image
    self.accessibilityLabel = self.name

    self.addSubview(self.imageView)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: self.size.length)
    let heightConstraint = self.heightAnchor.constraint(equalToConstant: self.size.length)

    NSLayoutConstraint.activate([
      widthConstraint,
      heightConstraint,
      self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
      self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.widthConstraint = widthConstraint
    self.heightConstraint = heightConstraint

    self.reloadImage()
  }

  // MARK: - Refresh

  private func refreshLayout() {
    self.widthConstraint?.constant = self.size.length
    self.heightConstraint?.constant = self.size.length
    self.invalidateIntrinsicContentSize()
    self.setNeedsLayout()
  }

  private func reloadImage() {
    self.loadTask?.cancel()
    self.loadTask = nil

    guard let url = BezierEmojiCDN.imageURL(name: self.name, size: self.size) else {
      self.currentURL = nil
      self.imageView.image = nil
      return
    }

    self.currentURL = url

    if let cached = BezierEmojiImageLoader.shared.cachedImage(for: url) {
      self.imageView.image = cached
      return
    }

    self.imageView.image = nil
    self.loadTask = Task { @MainActor [weak self] in
      guard let image = await BezierEmojiImageLoader.shared.image(for: url) else { return }
      guard let self, !Task.isCancelled, self.currentURL == url else { return }
      self.imageView.image = image
    }
  }
}
