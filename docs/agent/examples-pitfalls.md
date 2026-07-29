# Examples 카탈로그 함정

`Examples/BezierExamples/BezierExamples/Components/{Name}Catalog.swift`를 작성할 때만 읽으면
된다. 등록 절차와 화면 구조는 [`CONTRIBUTING.md`](../../CONTRIBUTING.md), 공통 규칙은
[`CLAUDE.md`](../../CLAUDE.md)에 있다.

## UIKit 브리지

### `UIControl.isEnabled`는 직접 설정해도 되돌려진다

SwiftUI는 `UIViewRepresentable` 안의 `UIControl.isEnabled`를 environment `\.isEnabled`로
**강제 동기화**한다. factory/update 클로저에서 `isEnabled = false`를 넣어도 즉시 true로
돌아온다. 데모의 disabled 제어는 representable 바깥에 `.disabled(...)`를 건다.

```swift
UIKitWrap({ BezierCheckbox() }, update: { ... })
  .disabled(!self.isEnabled)
```

순수 UIKit 소비자는 영향이 없다 — representable 경로만 해당한다.

### 폭이 무너지는 두 반대 케이스

`UIKitWrap`은 `systemLayoutSizeFitting(..., withHorizontalFittingPriority: .fittingSizeLevel)`로
크기를 낸다. 여기서 컴포넌트의 intrinsic width 유무에 따라 정반대 증상이 나온다.

| 증상 | 원인 | 조치 | 실례 |
|---|---|---|---|
| 아예 안 보임(width 0) | intrinsic width 없는 full-width 뷰(`BezierDivider`) | 전용 representable에서 `sizeThatFits`가 `proposal.width`를 반환 | `DividerCatalog.swift` |
| full-width로 안 늘어남 | content를 hug하는 intrinsic width 보유(`BezierBanner`) | `makeUIView`가 빈 `UIView` wrapper를 반환하고 컴포넌트를 leading·trailing·top·bottom pin | `BannerCatalog.swift` |

`.frame(maxWidth: .infinity)`로는 둘 다 해결되지 않는다 — representable의 렌더 크기는
`sizeThatFits` 반환값이 지배하고 frame modifier는 UIView의 실제 bounds를 강제하지 못한다.
wrapper 방식에서 컴포넌트 내부 content가 남는 폭을 채우게 하려면 content의 가로
`setContentHuggingPriority`를 최저(`UILayoutPriority(1)`)로 둔다 — `.defaultLow`로는 부족하다.

`updateUIView`는 wrapper를 받으므로 `wrapper.subviews.compactMap { $0 as? T }.first`로
컴포넌트를 찾아 갱신한다.

### 매트릭스에서 바뀌는 `@State`는 `update`에서 재주입한다

`makeUIView`는 1회만 호출된다. factory 클로저에만 값을 넘기면 초기값에 고정되어, SwiftUI
매트릭스는 반영되는데 UIKit 매트릭스만 안 바뀌는 증상이 나온다.

```swift
UIKitWrap({ BezierIconButton(...) }, update: { (button: BezierIconButton) in
  button.semantic = self.semantic     // @State는 반드시 여기서 다시 주입
})
```

`ForEach`로 고정되는 축(variant/size)은 factory에 둬도 된다. multi-statement factory와 함께
쓰면 제네릭 `V`가 `UIView`로 폴백되어 프로퍼티를 못 찾는 컴파일 에러가 나므로, update
클로저의 파라미터 타입을 위처럼 명시한다.

## 레이아웃

### 화면 폭을 넘는 row는 가로 `ScrollView`로 감싼다

`CatalogScreen`은 세로 `ScrollView`만 제공한다. 폭을 초과하는 row가 하나라도 있으면 VStack
전체가 좌측으로 밀려 **상단 컨트롤까지 화면 밖으로 나가 탭이 안 된다**.

```swift
ScrollView(.horizontal, showsIndicators: false) { HStack { ... } }
```

세로·가로 ScrollView는 방향이 달라 공존한다. size가 많아 세그먼트가 폭을 넘으면
`LabeledSegmented` 대신 `Picker(.menu)`를 쓴다. 실례: `AvatarGroupCatalog.swift`.

## 빌드

- **`import Combine` 명시 필요** — Examples 타겟은 Xcode 26 기본값
  `SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY = YES`라 `import SwiftUI`만으로는
  `ObservableObject`/`@Published`가 보이지 않는다 (`CatalogEnvironment.swift` 참조).
  라이브러리 본체는 이 설정이 꺼져 있어 영향이 없다
- **파일 추가에 pbxproj 편집이 필요 없다** — `PBXFileSystemSynchronizedRootGroup`이라
  디렉토리에 `.swift`를 넣으면 타겟에 자동 포함된다. 반대로 **디렉토리를 통째로 지우면**
  빈 sync group이 남아 빌드가 엉뚱한 에러로 깨지므로, 삭제 시엔 pbxproj의 타겟도 함께 정리한다
