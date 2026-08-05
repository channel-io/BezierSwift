# SwiftUI 구현 함정

SwiftUI 컴포넌트(`MasterComponent/{Component}/SU{Name}.swift`)를 작성·수정할 때만 읽으면
된다. 공통 규칙은 [`CLAUDE.md`](../../CLAUDE.md)에 있다.

## `Path.addArc`의 `clockwise`는 UIKit과 정반대다

SwiftUI `Path.addArc(center:radius:startAngle:endAngle:clockwise:)`의 `clockwise`는 수학
좌표계(y-up) 기준이다. 화면은 y-down이므로 `clockwise: true`를 주면 **화면에서는 반시계**로
그려진다. UIKit `UIBezierPath.addArc`는 화면 좌표 그대로라 `clockwise: true`가 화면상 시계다.

```swift
// 화면상 시계 방향 호 (135° → 45°, 270°)
path.addArc(..., clockwise: false)   // SwiftUI
path.addArc(..., clockwise: true)    // UIKit — 같은 그림, 반대 인자
```

두 구현을 나란히 놓고 대조할 것. 실례: `SUBezierSpinner.swift` ↔ `BezierSpinner.swift`.

## 그룹 단위 흐림에는 `.compositingGroup()`을 선행한다

`.opacity()`는 **per-view 곱**이라 겹쳐 놓은 서브뷰가 서로 비쳐 보인다. disabled 흐림처럼
"합성된 결과 전체에 알파를 먹이는" 처리(UIKit의 root `alpha`, Figma의 그룹 flatten과 동치)를
하려면 `.compositingGroup()`을 `.opacity()` **앞에** 둔다.

```swift
content
  .compositingGroup()
  .opacity(self.isEnabled ? 1 : BezierSwitchConstant.disabledOpacity)
```

빼먹으면 예를 들어 Switch의 thumb 아래로 트랙이 비친다. 실례: `SUBezierSwitch.swift`,
`SUBezierCheckbox.swift`, `SUBezierTextInput.swift`.

## 항상 dark인 컴포넌트는 두 채널을 모두 pin한다

라이트/다크와 무관하게 dark 표면을 유지해야 하는 컴포넌트(Toast 등)는 **둘 다** 필요하다.

```swift
public var colorScheme: ColorScheme { .dark }   // ① @Environment가 아닌 상수 — Themeable.palette()용
// body:
content.environment(\.colorScheme, .dark)       // ② applyBezierFontStyle의 자체 @Environment용
```

`applyBezierFontStyle(_:semanticColorToken:)` 내부의 `BezierTypographyStyle`이 자기
`@Environment(\.colorScheme)`로 텍스트 색을 해석하기 때문에, ①만 있으면 배경·아이콘은
dark인데 **텍스트만 주변 스킴을 따라간다**. `.preferredColorScheme`은 window 레벨이라
스코프가 틀리다 — 쓰지 말 것. 실례: `SUBezierToast.swift`.

UIKit 대응은 `var colorTheme: BezierColorTheme { .dark }` 상수 + `setUp()`에서
`overrideUserInterfaceStyle = .dark`.

## `EmptyView`는 modifier 체인 전체를 소거한다

슬롯 컨테이너에서 `content`를 그대로 받아 `.background(...)`·`.padding(...)`을 걸면,
호출부가 `EmptyView`를 넘겼을 때 **컨테이너 자체가 렌더되지 않는다**. 실체가 있는
컨테이너로 한 번 감싼다.

```swift
VStack(alignment: .leading, spacing: 0) { self.content }
  .padding(...)
  .background(...)
```

실례: `SUBezierOverlay.swift`.

슬롯이 비었을 때 **여백만 빼고 싶은** 경우는 반대로 타입으로 분기한다 —
`if Leading.self != EmptyView.self { ... }` (`SUBezierTextInput.swift`).

## `TextField`의 높이 상한은 `lineLimit`이 아니라 `frame`으로 건다

`TextField(axis: .vertical)`에서 `lineLimit(2...6)`의 **상한**은 폰트 고유 행높이로 높이를 예산
잡는다. `applyBezierFontStyle`이 싣는 `lineSpacing` 때문에 실제 렌더 피치는 토큰 lineHeight(24pt)라
둘이 어긋나, 6행을 줘도 `6 × 22.67 + 패딩 ≈ 135pt`(기대 160pt)에서 **5행만 보인다**.

상한은 컨테이너의 pt 높이로 걸고 `lineLimit`은 하한 전용으로 남긴다.

```swift
TextField("", text: self.$text, axis: .vertical)
  .applyBezierFontStyle(...)
  .lineLimit(2...)                        // 하한만
  .frame(minHeight: 48, maxHeight: 144)   // 상한은 pt로 (상하 패딩 제외분)
```

`maxHeight`가 빈 상태를 상한까지 부풀리지 않을까 싶지만, 콘텐츠 기반 ideal 높이를 제안하는
컨테이너에서는 발생하지 않는다(빈 상태 64.0pt 유지 실측). 실례: `SUBezierTextArea.swift`.

## `TextField(prompt:)`에는 line height를 실을 수 없다

`prompt:`는 `Text`만 받는데 `lineSpacing`은 View modifier라 태울 수 없다. 한 줄 placeholder는
차이가 안 보이지만, 여러 줄로 감기는 placeholder는 행 간격이 토큰값보다 좁아진다. `prompt`를
버리고 `.overlay`로 직접 그려야 `applyBezierFontStyle`을 그대로 적용할 수 있다.

```swift
TextField("", text: self.$text, axis: .vertical)
  .overlay(alignment: .topLeading) {
    if self.text.isEmpty {
      Text(self.placeholder)
        .applyBezierFontStyle(token, semanticColorToken: .textNeutralLighter)
        .allowsHitTesting(false)
    }
  }
```

UIKit의 별도 `placeholderLabel`과 동형이 되어 두 구현의 정렬·행 높이가 맞는다.
실례: `SUBezierTextArea.swift`.

## `.overlay`는 primary view 크기를 제안받을 뿐, 클리핑하지 않는다

오버레이 콘텐츠는 **primary view의 크기를 제안**받는다. 그보다 큰 콘텐츠는 두 방향으로 어긋난다.

- **세로로 모자라면 잘린다.** `TextField`가 빈 상태에서 제안하는 높이(약 38.3pt)보다 styled 2행의
  실제 높이(`2 × fontLineHeight + lineSpacing + 상하패딩` = 48pt)가 커서, `.lineLimit(2)`를 걸어도
  **1행만 렌더된다.** `.fixedSize(horizontal: false, vertical: true)`로 자기 ideal 높이를 쓰게 한다.
- **가로/세로로 넘쳐도 클리핑되지 않는다.** `.frame()`·`.background()`·`.compositingGroup()` 중
  어느 것도 클립하지 않으므로, 상한 없는 오버레이 텍스트는 라운드 박스 **밖으로 그대로 그려진다.**
  `.clipped()`로 막지 말고 `lineLimit` + `truncationMode(.tail)`로 상한과 말줄임을 함께 건다
  (클립만 하면 말줄임 없이 잘리는 UIKit `masksToBounds`와 같은 증상이 된다).

```swift
.overlay(alignment: .topLeading) {
  if self.text.isEmpty {
    Text(self.placeholder)
      .applyBezierFontStyle(token, semanticColorToken: .textNeutralLighter)
      .lineLimit(2)
      .truncationMode(.tail)
      .fixedSize(horizontal: false, vertical: true)   // 없으면 1행으로 접힌다
      .allowsHitTesting(false)
  }
}
```

여기서 `lineLimit`은 **오버레이가 그려지는 범위만** 정한다. 오버레이는 레이아웃에 기여하지 않으므로
이 값을 바꿔도 컨테이너 높이는 변하지 않는다 — 높이는 primary view(`TextField`)와 바깥 `.frame`이
정한다.

**높이를 정하는 쪽은 따로 있다.** 같은 컴포넌트라도 `Text`를 직접 그리는 분기(readOnly 등)에서는
그 `Text`가 레이아웃을 만들기 때문에 `lineLimit` 상한이 곧 컨테이너 높이가 된다. 값이 비어 placeholder만
보이는 상태에 값 있을 때의 확장 상한(6행)을 그대로 쓰면 컨테이너가 64 → 88.3pt로 자란다. **값 유무로
상한을 나눠라.** 실례: `SUBezierTextArea.swift`의 `placeholderOverlay`(오버레이·고정 2행)와
`readOnlyMaxLineCount`(레이아웃·값 유무로 분기).
