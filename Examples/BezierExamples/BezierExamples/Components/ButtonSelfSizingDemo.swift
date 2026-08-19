import SwiftUI
import UIKit
import BezierSwift

// MOB-6882 재현 화면.
//
// UIKitWrap의 systemLayoutSizeFitting 경로에서는 이 버그가 재현되지 않는다. 실제
// UICollectionView(compositional list) self-sizing 셀에 태워야만 드러나므로 전용
// representable로 컬렉션뷰를 통째로 얹는다.
//
// 재현 조건이 까다롭다. 폭이 모호한 상태(intrinsic 부재)에서는 엔진이 어느 해를 고를지가
// 주변 제약에 좌우되므로, 아래 두 가지를 어기면 버그가 그냥 hug으로 풀려 가려진다.
//
//   1. 버튼 셀에는 버튼만 넣는다 — 같은 셀에 라벨을 함께 두면 hug 쪽으로 풀린다.
//      그래서 설명·측정값은 별도의 헤더 셀이 들고 있다.
//   2. 버튼과 제약은 셀 `init`에서 만든다 — `cellForItemAt`에서 뒤늦게 붙이면 self-sizing
//      첫 측정에 제약이 없어, 역시 hug으로 풀린다.

/// 버튼을 셀에 붙이는 세 가지 배치 레시피. 셀 폭은 같고 제약만 다르다.
enum ButtonPlacementRecipe: CaseIterable {
  /// `centerX` + `leading >=` / `trailing <=` — 콘텐츠 폭으로 hug 되기를 기대하는 배치.
  case hugInequality
  /// `leading =` / `trailing =` — 컨테이너가 폭을 지정하는 배치.
  case fillEqual
  /// 세로 스택 `alignment = .center` — intrinsic이 없던 시절의 소비자 우회.
  case hugCenterStack

  var title: String {
    switch self {
    case .hugInequality: return "centerX + leading ≥ / trailing ≤"
    case .fillEqual: return "leading = / trailing ="
    case .hugCenterStack: return "세로 스택 alignment .center"
    }
  }

  var expectation: String {
    switch self {
    case .hugInequality, .hugCenterStack: return "hug 기대 — 콘텐츠 폭"
    case .fillEqual: return "fill 기대 — 셀 폭"
    }
  }

  var reuseIdentifier: String {
    switch self {
    case .hugInequality: return "ButtonSelfSizingHugInequalityCell"
    case .fillEqual: return "ButtonSelfSizingFillEqualCell"
    case .hugCenterStack: return "ButtonSelfSizingHugStackCell"
    }
  }

  var expectsHug: Bool {
    switch self {
    case .hugInequality, .hugCenterStack: return true
    case .fillEqual: return false
    }
  }
}

struct ButtonSelfSizingDemo: UIViewRepresentable {
  let size: BezierButtonSize
  let variant: BezierButtonVariant
  let semantic: BezierButtonSemantic
  let title: String

  func makeUIView(context: Context) -> ButtonSelfSizingDemoView {
    ButtonSelfSizingDemoView()
  }

  func updateUIView(_ uiView: ButtonSelfSizingDemoView, context: Context) {
    uiView.configure(size: self.size, variant: self.variant, semantic: self.semantic, title: self.title)
  }

  func sizeThatFits(
    _ proposal: ProposedViewSize,
    uiView: ButtonSelfSizingDemoView,
    context: Context
  ) -> CGSize? {
    let width = proposal.width ?? UIScreen.main.bounds.width
    return CGSize(width: width, height: uiView.contentHeight(fittingWidth: width))
  }
}

// MARK: - Demo View

final class ButtonSelfSizingDemoView: UIView {
  private static let probeHeight: CGFloat = 2000

  private let collectionView: UICollectionView
  private let dataSource = RecipeDataSource()
  private var cachedMeasurement: (key: MeasurementKey, height: CGFloat)?

  fileprivate struct MeasurementKey: Equatable {
    let width: CGFloat
    let style: RecipeDataSource.Style
  }

  override init(frame: CGRect) {
    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    configuration.showsSeparators = false
    configuration.backgroundColor = .clear
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

    super.init(frame: frame)

    self.collectionView.backgroundColor = .clear
    self.collectionView.isScrollEnabled = false
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false
    self.collectionView.register(RecipeHeaderCell.self, forCellWithReuseIdentifier: RecipeDataSource.headerReuseIdentifier)
    self.collectionView.register(HugInequalityButtonCell.self, forCellWithReuseIdentifier: ButtonPlacementRecipe.hugInequality.reuseIdentifier)
    self.collectionView.register(FillEqualButtonCell.self, forCellWithReuseIdentifier: ButtonPlacementRecipe.fillEqual.reuseIdentifier)
    self.collectionView.register(HugStackButtonCell.self, forCellWithReuseIdentifier: ButtonPlacementRecipe.hugCenterStack.reuseIdentifier)
    self.collectionView.dataSource = self.dataSource

    self.addSubview(self.collectionView)
    NSLayoutConstraint.activate([
      self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
    ])
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  func configure(
    size: BezierButtonSize,
    variant: BezierButtonVariant,
    semantic: BezierButtonSemantic,
    title: String
  ) {
    let style = RecipeDataSource.Style(size: size, variant: variant, semantic: semantic, title: title)
    guard style != self.dataSource.style else { return }

    self.dataSource.style = style
    self.cachedMeasurement = nil
    self.collectionView.reloadData()
  }

  /// 컬렉션뷰가 스크롤하지 않으므로 콘텐츠 전체 높이를 representable에 알려준다.
  ///
  /// 높이 0짜리 프레임으로는 compositional layout이 self-sizing 셀을 준비하지 않아
  /// `collectionViewContentSize`가 0으로 나온다. 충분히 큰 프레임을 한 번 태워 전 행을
  /// 준비시킨 뒤 읽는다. 캐시하지 않으면 매 측정마다 레이아웃이 돌아 SwiftUI가 다시
  /// 측정하는 루프가 생기고, 바깥 `ScrollView`의 오프셋이 계속 초기화된다.
  func contentHeight(fittingWidth width: CGFloat) -> CGFloat {
    let key = MeasurementKey(width: width, style: self.dataSource.style)
    if let cached = self.cachedMeasurement, cached.key == key { return cached.height }

    self.collectionView.frame = CGRect(x: 0, y: 0, width: width, height: Self.probeHeight)
    self.collectionView.layoutIfNeeded()
    let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
    self.cachedMeasurement = (key, height)
    return height
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.collectionView.layoutIfNeeded()
    self.publishMeasurements()
  }

  /// 버튼 셀은 라벨을 갖지 않으므로, 컬렉션뷰 레이아웃이 끝난 뒤 폭을 읽어 헤더 셀에 넘긴다.
  private func publishMeasurements() {
    for (index, recipe) in ButtonPlacementRecipe.allCases.enumerated() {
      let headerPath = IndexPath(item: index * 2, section: 0)
      let buttonPath = IndexPath(item: index * 2 + 1, section: 0)
      guard
        let header = self.collectionView.cellForItem(at: headerPath) as? RecipeHeaderCell,
        let buttonCell = self.collectionView.cellForItem(at: buttonPath) as? RecipeButtonCell,
        let width = buttonCell.measuredButtonWidth
      else { continue }

      header.showMeasurement(width, cellWidth: buttonCell.bounds.width, expectsHug: recipe.expectsHug)
    }
  }
}

// MARK: - Data Source

fileprivate final class RecipeDataSource: NSObject, UICollectionViewDataSource {
  struct Style: Equatable {
    var size: BezierButtonSize = .small
    var variant: BezierButtonVariant = .outlined
    var semantic: BezierButtonSemantic = .primary
    var title: String = "더 보기"
  }

  static let headerReuseIdentifier = "ButtonSelfSizingRecipeHeaderCell"

  var style = Style()

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    ButtonPlacementRecipe.allCases.count * 2
  }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let recipe = ButtonPlacementRecipe.allCases[indexPath.item / 2]
    let isHeader = indexPath.item.isMultiple(of: 2)

    if isHeader {
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: Self.headerReuseIdentifier,
        for: indexPath
      )
      (cell as? RecipeHeaderCell)?.apply(recipe: recipe)
      return cell
    }

    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: recipe.reuseIdentifier,
      for: indexPath
    )
    (cell as? RecipeButtonCell)?.configure(style: self.style)
    return cell
  }
}

// MARK: - Header Cell

fileprivate final class RecipeHeaderCell: UICollectionViewCell {
  private let titleLabel = UILabel()
  private let measurementLabel = UILabel()

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.titleLabel.font = .monospacedSystemFont(ofSize: 11, weight: .medium)
    self.titleLabel.textColor = .secondaryLabel
    self.titleLabel.numberOfLines = 2
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

    self.measurementLabel.font = .monospacedDigitSystemFont(ofSize: 12, weight: .semibold)
    self.measurementLabel.textAlignment = .right
    self.measurementLabel.translatesAutoresizingMaskIntoConstraints = false

    self.contentView.addSubview(self.titleLabel)
    self.contentView.addSubview(self.measurementLabel)

    NSLayoutConstraint.activate([
      self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
      self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4),
      self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
      self.measurementLabel.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 8),
      self.measurementLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
      self.measurementLabel.widthAnchor.constraint(equalToConstant: 64),
      self.measurementLabel.firstBaselineAnchor.constraint(equalTo: self.titleLabel.firstBaselineAnchor),
    ])
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  func apply(recipe: ButtonPlacementRecipe) {
    self.titleLabel.text = "\(recipe.title)\n\(recipe.expectation)"
    self.measurementLabel.text = nil
  }

  func showMeasurement(_ width: CGFloat, cellWidth: CGFloat, expectsHug: Bool) {
    let text = "\(Int(width.rounded())) pt"
    guard self.measurementLabel.text != text else { return }

    self.measurementLabel.text = text
    let hugged = width < cellWidth - RecipeButtonCell.horizontalInset * 2
    self.measurementLabel.textColor = (hugged == expectsHug) ? .systemGreen : .systemRed
  }
}

// MARK: - Button Cell
//
// 버튼과 제약을 `init`에서 만든다. `cellForItemAt`에서 뒤늦게 붙이면 self-sizing 첫 측정
// 시점에 제약이 없어 모호성이 hug 쪽으로 풀리고, 재현하려던 버그가 가려진다.

fileprivate class RecipeButtonCell: UICollectionViewCell {
  static let horizontalInset: CGFloat = 16

  let button = BezierButton(size: .small, variant: .outlined, semantic: .primary)

  /// 컨테이너가 레이아웃 뒤에 읽는다. 아직 배치 전이면 `nil`.
  var measuredButtonWidth: CGFloat? {
    self.button.bounds.width > 0 ? self.button.bounds.width : nil
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.installButton()
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  /// 서브클래스가 레시피별 가로 제약을 건다.
  func installButton() {
    fatalError("서브클래스가 구현한다")
  }

  func configure(style: RecipeDataSource.Style) {
    self.button.size = style.size
    self.button.variant = style.variant
    self.button.semantic = style.semantic
    self.button.title = style.title.isEmpty ? nil : style.title
  }

  func pinVertically(_ view: UIView) {
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 2),
      view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -14),
    ])
  }
}

/// `centerX` + 부등호. 폭을 확정하는 제약이 없어 MOB-6882가 드러나는 배치.
fileprivate final class HugInequalityButtonCell: RecipeButtonCell {
  override func installButton() {
    let inset = Self.horizontalInset
    self.contentView.addSubview(self.button)
    NSLayoutConstraint.activate([
      self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
      self.button.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: inset),
      self.button.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -inset),
    ])
    self.pinVertically(self.button)
  }
}

/// `leading =` / `trailing =`. 컨테이너가 폭을 확정하므로 항상 셀 폭이다.
fileprivate final class FillEqualButtonCell: RecipeButtonCell {
  override func installButton() {
    let inset = Self.horizontalInset
    self.contentView.addSubview(self.button)
    NSLayoutConstraint.activate([
      self.button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
      self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
    ])
    self.pinVertically(self.button)
  }
}

/// 세로 스택 `alignment = .center`. intrinsic이 없던 시절의 소비자 우회.
fileprivate final class HugStackButtonCell: RecipeButtonCell {
  private let centerStackView = UIStackView()

  override func installButton() {
    let inset = Self.horizontalInset
    self.centerStackView.axis = .vertical
    self.centerStackView.alignment = .center
    self.centerStackView.translatesAutoresizingMaskIntoConstraints = false
    self.centerStackView.addArrangedSubview(self.button)
    self.contentView.addSubview(self.centerStackView)
    NSLayoutConstraint.activate([
      self.centerStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
      self.centerStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
    ])
    self.pinVertically(self.centerStackView)
  }
}
