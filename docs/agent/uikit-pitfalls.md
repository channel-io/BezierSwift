# UIKit 구현 함정

UIKit 컴포넌트(`MasterComponent/{Component}/{Name}.swift`)를 작성·수정할 때만 읽으면 된다.
공통 규칙은 [`CLAUDE.md`](../../CLAUDE.md)에 있다.

## 다크모드 토큰 재주입

Semantic 토큰을 해석한 색은 **정적으로 굳는 경로**와 **시스템이 자동 재해석하는 경로**가
갈린다. 굳는 경로만 `traitCollectionDidChange(_:)`에서 다시 주입하면 된다.

| 경로 | trait 변경 시 | 조치 |
|---|---|---|
| `UIView.backgroundColor`·`tintColor`에 dynamic `UIColor`(`token.palette(self)`) 직접 대입 | 자동 재해석 | 불요 |
| `CALayer.backgroundColor`·`borderColor`·`shadowColor`·`fillColor` (`CGColor`) | 대입 시점에 1회 해석 후 고정 | **재주입 필요** |
| 서브컴포넌트의 override 프로퍼티에 해석된 색을 주입 (예: `spinner.fillColorOverride`) | 부모가 해석했으므로 고정 | **재주입 필요** |

```swift
override func traitCollectionDidChange(_ previous: UITraitCollection?) {
  super.traitCollectionDidChange(previous)
  self.refreshAppearance()   // 색 재계산·재주입을 한 곳에 모아둔다
}
```

- 저장소 내 28개 파일이 이 패턴을 구현 중이다. `BezierButton.swift`가 대표 예시
- SwiftUI는 `@Environment(\.colorScheme)`가 자동 전파되므로 이 루프가 없다 — 두 구현의
  패리티를 볼 때 이 비대칭을 먼저 의심할 것
- `componentTheme`(normal/inverted)은 trait이 아니라 자동 재해석 대상이 아니다. 변경 시 직접 재적용
- 색이 상수인 컴포넌트(항상 dark 등)는 재주입이 불필요하다(무해하긴 함)

## CALayer border는 sublayer보다 위에 그려진다

`CALayer` 렌더 순서는 `backgroundColor → contents → sublayers → border`다. 즉
`view.layer.borderWidth/borderColor`로 그린 테두리는 그 뷰의 **모든 자식보다 항상 위**다.
자식의 `layer.zPosition`을 올려도 형제 sublayer 간 순서만 바뀔 뿐 부모의 border는 못 이긴다.

border 위로 올라와야 하는 자식(badge·status indicator·overlay)이 있으면 `layer.border` 대신
**별도 `borderView: UIView`** 를 만든다.

- 서브뷰 순서를 `contentView → borderView → overlayView`로 둔다
- `borderView`는 부모와 동일 크기로 pin하고 `isUserInteractionEnabled = false`
- 실례: `BezierAvatar.swift`의 `borderView` (showBorder + status 동시 사용 시 회귀로 발견)

## UICollectionView registration은 `init`에서 만든다

`CellRegistration`/`SupplementaryRegistration`이 dequeue 콜백 실행 중에 생성되면
`NSInternalInconsistencyException`이 난다. `lazy var`로 두면 첫 dequeue 시점에 초기화되므로
정확히 이 조건에 걸린다 (MOB-6455 `SectionCatalog` 헤더에서 실제 크래시).

- `[weak self]` 캡처가 필요해 stored `let` 기본값으로 못 만들면 implicitly unwrapped `var` +
  `init()`에서 생성
- 캡처가 없으면 stored `let` 기본값으로 두어도 안전
- 크래시 스택이 `dequeueConfiguredReusableSupplementaryViewWithRegistration:`에서 터져
  원인 파악이 어렵다 — 이 증상이 보이면 registration 생성 시점부터 확인할 것

## press 피드백은 `BezierPressFeedback`을 재사용한다

`Sources/BezierSwift/Util/BezierPressFeedback.swift` (internal)에 UIKit·SwiftUI 양쪽 헬퍼가 있다.
새로 만들지 말 것.

```swift
BezierPressFeedback.apply(isPressed: true, to: self)   // UIKit
BezierPressFeedback.reset(self)
```

사용 예시는 `BezierSectionItem.swift`. public 승격과 `BezierBaseItem` 마이그레이션은 MOB-6471에서 다룬다.

## 레이아웃 테스트

UIKit 뷰의 압축·크기 거동은 `UIWindow`에 붙여야 측정이 유효하다. 상세는
[`testing.md`](testing.md) 참조.
