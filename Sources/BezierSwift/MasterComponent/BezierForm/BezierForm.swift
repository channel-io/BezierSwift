//
//  BezierForm.swift
//  BezierSwift
//

import UIKit

/// 한 번에 함께 검증·제출되어야 하는 FormField들의 컨테이너 (UIKit). `BezierFormField`를 세로로 쌓으며 필드 간 간격은 필드 자체의 하단 패딩이 담당한다. 즉시 저장이 필요한 화면에는 Form이 아닌 `BezierSection` 계열을 사용한다. submit 액션(예: 내비게이션 바 저장 버튼)과 카드 chrome 조합은 화면(소비자) 책임이다. SwiftUI에서는 `SUBezierForm`을 사용한다.
public final class BezierForm: UIView {
  // MARK: - Public Properties

  /// 현재 표시 중인 필드 뷰 배열. 읽기 전용이며 `setFields(_:)`/`addField(_:)`로 변경한다.
  public private(set) var fields: [UIView] = []

  // MARK: - Subviews

  private let rootStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = BezierFormConstant.fieldSpacing
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()

  // MARK: - Init

  /// 초기 필드 배열로 폼을 만든다. 필드는 이후 `setFields(_:)`/`addField(_:)`로 교체·추가할 수 있다.
  public init(fields: [UIView] = []) {
    self.fields = fields
    super.init(frame: .zero)
    self.setUp()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setUp()
  }

  // MARK: - Setup

  private func setUp() {
    self.translatesAutoresizingMaskIntoConstraints = false

    self.addSubview(self.rootStackView)
    NSLayoutConstraint.activate([
      self.rootStackView.topAnchor.constraint(equalTo: self.topAnchor),
      self.rootStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.rootStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.rootStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])

    self.rebuildFields()
  }

  // MARK: - Fields

  /// 필드 배열을 통째로 교체한다.
  public func setFields(_ fields: [UIView]) {
    self.fields = fields
    self.rebuildFields()
  }

  /// 필드를 끝에 하나 추가한다.
  public func addField(_ field: UIView) {
    self.fields.append(field)
    self.rebuildFields()
  }

  private func rebuildFields() {
    self.rootStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    self.fields.forEach { self.rootStackView.addArrangedSubview($0) }
  }
}
