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
