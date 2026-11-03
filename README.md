# Bezier-swift
Swift components from Bezier Design System.

## Install

## Examples

`Examples/BezierExamples/BezierExamples.xcodeproj`를 Xcode에서 열어 실행하세요. (라이브러리 본체만 작업할 때는 루트의 `Package.swift`를 열면 됩니다.) 사이드바는 다음 세 그룹으로 나뉩니다:

- **V3 · Foundation**: Color Token · Typography · Icon · Dimension
- **V3 · Components**: Button · IconButton · Badge · Tag · Avatar · AvatarGroup (각 화면은 SwiftUI 섹션 위, UIKit 섹션 아래로 배치)
- **Legacy · Components**: Legacy Button (SwiftUI only)

우측 상단 toolbar로 Light/Dark · 배경색 · Dynamic Type을 토글할 수 있습니다.

## UIKit Modal 콘텐츠 여백

`BezierModal()`은 기본 여백(상단 20·하단 16·좌우 16pt)을 유지합니다. 기존 Modal·ConfirmModal·SwiftUI 호출부는 옵션을 지정할 필요가 없습니다.

```swift
let modal = BezierModal()
```

웹처럼 자체 padding을 관리하는 콘텐츠가 카드 전체 영역을 사용해야 할 때만 `contentInsets: .zero`를 명시합니다. 콘텐츠를 `contentView` 네 가장자리에 고정하고, 콘텐츠에 필요한 높이 제약을 지정합니다.

```swift
let modal = BezierModal(contentInsets: .zero)
content.translatesAutoresizingMaskIntoConstraints = false
modal.contentView.addSubview(content)
NSLayoutConstraint.activate([
  content.topAnchor.constraint(equalTo: modal.contentView.topAnchor),
  content.bottomAnchor.constraint(equalTo: modal.contentView.bottomAnchor),
  content.leadingAnchor.constraint(equalTo: modal.contentView.leadingAnchor),
  content.trailingAnchor.constraint(equalTo: modal.contentView.trailingAnchor),
  content.heightAnchor.constraint(equalToConstant: 240),
])
let controller = BezierModalViewController(modalView: modal)
present(controller, animated: true)
```

기본 여백에서는 최소 카드 높이가 37pt이며, `.zero`에서는 콘텐츠 최소 높이 1pt가 카드 최소 높이입니다. 모서리 클리핑·그림자와 기존 dim·safe area·crossDissolve 프레젠테이션은 유지됩니다. `BezierModalViewController(contentView:)` 편의 생성자는 계속 기본 여백을 사용합니다.

## Contribute
See [contribution guide](CONTRIBUTING.md).

## Maintainers
This package is mainly contributed by Channel Corp. Although feel free to contribution, or raise concerns!
