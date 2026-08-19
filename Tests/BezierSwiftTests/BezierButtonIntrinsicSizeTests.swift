import Testing
import UIKit
@testable import BezierSwift

// MARK: - BezierButton intrinsicContentSize / 컬렉션뷰 self-sizing 테스트 (MOB-6882)
//
// 재현 대상: BezierButton 이 intrinsicContentSize 를 노출하지 않아 폭이 미결정
// (hasAmbiguousLayout == true) 상태가 되고, UICollectionView self-sizing 셀 안에서
// 콘텐츠 폭(58pt) 대신 셀 폭 전체(317pt)로 늘어나던 버그.
// 제약으로 흉내낸 self-sizing 에서는 재현되지 않아 실제 컬렉션뷰를 태워야만 드러난다.

@Suite("BezierButton Intrinsic Content Size", .serialized)
@MainActor
struct BezierButtonIntrinsicSizeTests {
  private static let cellWidth: CGFloat = 349
  private static let cellHorizontalInset: CGFloat = 16

  private static func makeButton(
    size: BezierButtonSize = .small,
    title: String? = "더 보기"
  ) -> BezierButton {
    let button = BezierButton(size: size, variant: .outlined, semantic: .primary)
    button.title = title
    return button
  }

  // MARK: - intrinsicContentSize 자체

  @Test("intrinsicContentSize 가 noIntrinsicMetric 이 아니다")
  func exposesIntrinsicContentSize() {
    let button = Self.makeButton()
    #expect(button.intrinsicContentSize.width != UIView.noIntrinsicMetric)
    #expect(button.intrinsicContentSize.height == BezierButtonSize.small.height)
  }

  @Test("intrinsicContentSize.width 가 제약으로 계산한 자연폭과 일치한다")
  func intrinsicWidthMatchesFittingWidth() {
    let button = Self.makeButton()
    let fitted = button.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    #expect(button.intrinsicContentSize.width == fitted)
  }

  @Test("콘텐츠가 없으면 minWidth 를 하한으로 쓴다")
  func emptyContentFallsBackToMinWidth() {
    let button = Self.makeButton(title: nil)
    #expect(button.intrinsicContentSize.width == BezierButtonSize.small.minWidth)
  }

  @Test("아이콘을 추가하면 iconLength 와 contentSpacing 만큼 넓어진다")
  func iconsWidenIntrinsicWidth() {
    let size = BezierButtonSize.small
    let button = Self.makeButton(size: size)
    let titleOnly = button.intrinsicContentSize.width

    button.leadingIcon = UIImage()
    let withLeading = button.intrinsicContentSize.width
    #expect(withLeading == titleOnly + size.iconLength + size.contentSpacing)

    button.trailingIcon = UIImage()
    let withBoth = button.intrinsicContentSize.width
    #expect(withBoth == withLeading + size.iconLength + size.contentSpacing)
  }

  @Test("isLoading 을 켜도 폭이 변하지 않는다")
  func loadingDoesNotChangeIntrinsicWidth() {
    let button = Self.makeButton()
    let before = button.intrinsicContentSize.width
    button.isLoading = true
    #expect(button.intrinsicContentSize.width == before)
  }

  @Test("size 를 바꾸면 intrinsicContentSize 가 따라간다")
  func sizeChangeInvalidatesIntrinsicContentSize() {
    let button = Self.makeButton(size: .small)
    let small = button.intrinsicContentSize
    button.size = .large
    let large = button.intrinsicContentSize
    #expect(large.height == BezierButtonSize.large.height)
    #expect(large.width > small.width)
  }

  // MARK: - 컬렉션뷰 self-sizing 회귀 (MOB-6882 본체)

  @Test("컬렉션뷰 self-sizing 셀 안에서 콘텐츠 폭을 유지한다")
  func doesNotStretchInSelfSizingCollectionViewCell() {
    let (window, collectionView) = Self.makeListCollectionView()
    let dataSource = SingleButtonCellDataSource()
    collectionView.dataSource = dataSource
    collectionView.register(HuggingButtonCell.self, forCellWithReuseIdentifier: SingleButtonCellDataSource.reuseIdentifier)
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
    window.layoutIfNeeded()

    guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? HuggingButtonCell else {
      Issue.record("셀을 얻지 못했다")
      return
    }

    #expect(cell.bounds.width == Self.cellWidth)
    #expect(cell.button.bounds.width == cell.button.intrinsicContentSize.width)
    #expect(cell.button.hasAmbiguousLayout == false)
  }

  @Test("컨테이너가 equalTo 제약을 걸면 여전히 늘어난다")
  func containerConstraintsStillWin() {
    let (window, collectionView) = Self.makeListCollectionView()
    let dataSource = SingleButtonCellDataSource()
    collectionView.dataSource = dataSource
    collectionView.register(StretchingButtonCell.self, forCellWithReuseIdentifier: SingleButtonCellDataSource.reuseIdentifier)
    collectionView.reloadData()
    collectionView.layoutIfNeeded()
    window.layoutIfNeeded()

    guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? StretchingButtonCell else {
      Issue.record("셀을 얻지 못했다")
      return
    }

    #expect(cell.button.bounds.width == Self.cellWidth - Self.cellHorizontalInset * 2)
  }

  @Test("세로 스택 .fill 정렬이 intrinsic 을 이긴다")
  func fillAlignedStackStillStretches() {
    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: Self.cellWidth, height: 200))
    let button = Self.makeButton()
    let stackView = UIStackView(arrangedSubviews: [button])
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.translatesAutoresizingMaskIntoConstraints = false
    window.addSubview(stackView)
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: window.topAnchor),
    ])
    window.makeKeyAndVisible()
    window.layoutIfNeeded()

    #expect(button.bounds.width == Self.cellWidth)
  }

  // MARK: - Helpers

  private static func makeListCollectionView() -> (UIWindow, UICollectionView) {
    var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
    configuration.showsSeparators = false
    let layout = UICollectionViewCompositionalLayout.list(using: configuration)
    let frame = CGRect(x: 0, y: 0, width: Self.cellWidth, height: 600)
    let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
    let window = UIWindow(frame: frame)
    window.addSubview(collectionView)
    window.makeKeyAndVisible()
    return (window, collectionView)
  }

  final class HuggingButtonCell: UICollectionViewCell {
    let button = BezierButtonIntrinsicSizeTests.makeButton()

    override init(frame: CGRect) {
      super.init(frame: frame)
      let inset = BezierButtonIntrinsicSizeTests.cellHorizontalInset
      self.contentView.addSubview(self.button)
      NSLayoutConstraint.activate([
        self.button.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
        self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
        self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
        self.button.leadingAnchor.constraint(greaterThanOrEqualTo: self.contentView.leadingAnchor, constant: inset),
        self.button.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -inset),
      ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  }

  final class StretchingButtonCell: UICollectionViewCell {
    let button = BezierButtonIntrinsicSizeTests.makeButton()

    override init(frame: CGRect) {
      super.init(frame: frame)
      let inset = BezierButtonIntrinsicSizeTests.cellHorizontalInset
      self.contentView.addSubview(self.button)
      NSLayoutConstraint.activate([
        self.button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: inset),
        self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -inset),
        self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
        self.button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
      ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
  }
}

final class SingleButtonCellDataSource: NSObject, UICollectionViewDataSource {
  static let reuseIdentifier = "BezierButtonIntrinsicSizeTestsCell"

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 1 }

  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    collectionView.dequeueReusableCell(withReuseIdentifier: Self.reuseIdentifier, for: indexPath)
  }
}
