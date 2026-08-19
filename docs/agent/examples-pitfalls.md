# Examples 카탈로그 함정

`Examples/BezierExamples/BezierExamples/Components/{Name}Catalog.swift`를 작성할 때만 읽으면
된다. 등록 절차와 화면 구조는 [`CONTRIBUTING.md`](../../CONTRIBUTING.md), 공통 규칙은
[`CLAUDE.md`](../../CLAUDE.md)에 있다.

## UIKit 브리지

### disabled를 넘기는 방향은 representable 루트 타입이 가른다

SwiftUI의 `\.isEnabled` 강제 동기화는 **representable이 반환하는 루트가 `UIControl`일 때만**
동작한다. 루트 타입에 따라 조치가 정반대이므로 무엇을 반환하는지부터 확인한다.

| representable 루트 | 증상 | 조치 | 실례 |
|---|---|---|---|
| `UIControl` 자신 | factory/update에서 `isEnabled = false`를 넣어도 즉시 true로 되돌려짐 | 바깥에 `.disabled(...)`를 건다 | `CheckboxCatalog.swift` |
| plain `UIView` wrapper (내부에 `UIControl` 중첩) | `.disabled(...)`가 **중첩된 `UIControl`까지 내려가지 않아** disabled가 아예 시연되지 않음 | 컴포넌트에 `isEnabled`를 직접 주입한다 | `DropdownMenuCatalog.swift` · `SelectCatalog.swift` |

```swift
// 루트가 UIControl — 바깥에서 건다
UIKitWrap({ BezierCheckbox() }, update: { ... })
  .disabled(!self.isEnabled)

// 루트가 wrapper — 안쪽 컴포넌트에 직접 주입한다 (updateUIView)
option.isEnabled = self.isEnabled
```

두 번째 케이스는 레이아웃이 멀쩡해 **색으로만 검출된다** — disabled인데 픽셀이 enabled와
같으면 의심한다. Select에서 슬롯 배지가 `(255,128,0)` 그대로였고, 주입 후 `(247,196,148)`
= opacity 0.4 합성값이 됐다.

순수 UIKit 소비자는 어느 쪽도 영향이 없다 — representable 경로만 해당한다.

### 폭이 무너지는 세 케이스

`UIKitWrap`은 `systemLayoutSizeFitting(..., withHorizontalFittingPriority: .fittingSizeLevel)`로
크기를 낸다. 여기서 컴포넌트의 intrinsic width 유무와 wrapper의 제약 방식에 따라 서로 다른
증상이 나온다.

| 증상 | 원인 | 조치 | 실례 |
|---|---|---|---|
| 아예 안 보임(width 0) | intrinsic width 없는 full-width 뷰(`BezierDivider`) | 전용 representable에서 `sizeThatFits`가 `proposal.width`를 반환 | `DividerCatalog.swift` |
| full-width로 안 늘어남 | content를 hug하는 intrinsic width 보유(`BezierBanner`) | `makeUIView`가 빈 `UIView` wrapper를 반환하고 컴포넌트를 leading·trailing·top·bottom pin | `BannerCatalog.swift` |
| 콘텐츠 폭으로 접혀 라벨이 잘림 | intrinsic width 없는 뷰를 wrapper에 `centerXAnchor` + `>=`/`<=`로만 고정 — 부등호는 폭을 **강제하지 못해** hug으로 붕괴한다 | 폭 거동이 다른 variant끼리 제약 세트를 나눠 `updateUIView`에서 교체 | `SelectCatalog.swift` |

세 번째는 폭이 variant마다 다를 때(`BezierSelect`의 `page` = FILL / `overlay` = 240pt 고정)
나온다. 고정 폭 variant를 center로 두려고 부등호 제약을 쓰면 FILL variant까지 같이 접히므로,
한 세트로 뭉치지 말고 variant별 제약을 만들어 두고 갈아끼운다. Select에서는 이 붕괴로 옵션
라벨이 `한국어` 전체 소실 · `En…`으로 잘렸는데, 빌드·코드 리뷰로는 드러나지 않았다.

`.frame(maxWidth: .infinity)`로는 어느 것도 해결되지 않는다 — representable의 렌더 크기는
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

### 레이아웃 버그 재현 화면은 셀 구성이 결과를 바꾼다

폭이 모호한 상태(intrinsic 부재)의 버그를 카탈로그에서 재현할 때, 컬렉션뷰를 태우는 것만으로는
부족하다. 엔진이 어느 해를 고를지는 주변 제약에 좌우되므로 아래 둘 중 하나만 어겨도 hug으로
풀려 **버그가 가려진다**.

| 지켜야 할 것 | 어기면 |
|---|---|
| 버튼 셀에는 검증 대상만 넣는다 | 같은 셀에 설명 라벨을 함께 두면 hug으로 풀림 → 설명·측정값은 별도 헤더 셀로 분리 |
| 대상과 제약을 셀 `init`에서 만든다 | `cellForItemAt`에서 뒤늦게 붙이면 self-sizing 첫 측정에 제약이 없어 hug으로 풀림 → 레시피별 셀 서브클래스로 나눈다 |

실례: `ButtonSelfSizingDemo.swift`(MOB-6882). 이 두 조건을 맞추기 전까지는 수정 전 코드에서도
정상(hug)으로 보였다.

### 측정값을 셀 `layoutSubviews`에서 재면 중간값이 잡힌다

셀의 `layoutSubviews`는 `contentView` 내부 배치보다 먼저 돌아, 대상 뷰의 폭이 0이거나 직전
패스의 값이다. 컨테이너 뷰의 `layoutSubviews`에서 `collectionView.layoutIfNeeded()` 뒤에
visible cell을 훑어 갱신한다.

### 컬렉션뷰를 `UIViewRepresentable`로 얹을 때 높이 측정은 캐시한다

`sizeThatFits`에서 매번 레이아웃을 돌리면 SwiftUI가 다시 측정하는 루프가 생겨 **바깥
`ScrollView`의 오프셋이 계속 초기화된다**(스크롤이 튕겨 돌아오는 증상). (width, 콘텐츠) 키로
캐시하고 콘텐츠가 바뀔 때만 무효화한다. 높이 0짜리 프레임으로 재면 compositional layout이
self-sizing 셀을 준비하지 않아 `collectionViewContentSize`가 0으로 나오므로, 충분히 큰
프레임을 한 번 태운 뒤 읽는다.

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
