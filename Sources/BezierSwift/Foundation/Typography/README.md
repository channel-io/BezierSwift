# Bezier Typography

## Namespace

- V3 구성요소는 Bezier Typography의 앞글자를 따서 `BT` Prefix를 붙입니다
- V1에서 정의된 `BezierFont`은 기존 이름을 유지합니다

## V3 Typography Token의 위계

Bezier Typography V3는 2단계 위계의 Token으로 나뉘어집니다

- Global Token(`BTGlobalToken`) — **internal**
  - FontSize, LineHeight, LetterSpacing, FontWeight, FontFamily 원시 값을 정의합니다
  - Semantic token 내부에서만 참조합니다 (외부 노출 없음)
- Semantic Token(`BTSemanticToken`) — **public**
  - Global Token을 조합하여 22개 시멘틱 토큰을 구성합니다
  - 6개 카테고리: Display, Heading, Text, Label, Caption, Code

## Weight 정책

iOS는 **400(Regular)과 700(Bold) 이진 체계**를 사용합니다.

| 카테고리 | Weight | `weight` prop |
|---------|--------|---------------|
| Display | 700 고정 | 무시 |
| Heading | 700 고정 | 무시 |
| Text    | 기본 400, bold 700 | 적용 |
| Label   | 700 고정 | 무시 |
| Caption | 기본 400, bold 700 | 적용 |
| Code    | 400 고정 | 무시 |

---

## V1 → V3 마이그레이션 가이드

### 패턴별 대응 방법

#### 1. SwiftUI Text 스타일 적용 (가장 많은 사용처)

V1:
```swift
Text("Hello").applyBezierFontStyle(.normal14, semanticColorToken: .textNeutral)
Text("Title").applyBezierFontStyle(.bold18, semanticColorToken: .textNeutral)
```

V3:
```swift
Text("Hello").applyBezierFontStyle(.textMedium(), semanticColorToken: .textNeutral)
Text("Title").applyBezierFontStyle(.headingMedium, semanticColorToken: .textNeutral)
```

> V3에서는 `.normal14`처럼 크기+무게로 선택하는 대신, **UI 역할**(본문인지, 제목인지, 라벨인지)에 따라 토큰을 선택합니다.

---

#### 2. UIKit attributedString 생성

V1:
```swift
Desk_BezierFont.bold14.attributedString(component, text: text, semanticColor: .textNeutral)
```

V3:
```swift
BTSemanticToken.labelLarge.attributedString(component, text: text, semanticColorToken: .textNeutral)
```

> 시그니처가 동일합니다. 토큰 타입만 교체하면 됩니다.

---

#### 3. hasTagProperty (태그 폰트 — `<b>bold</b>` 처리)

V1:
```swift
Desk_BezierFont.normal14.attributedString(
  component, text: "Hello <b>World</b>",
  semanticColor: .textNeutral,
  hasTagProperty: true  // 내부에서 getPairedBoldFont으로 bold 자동 매핑
)
```

V3:
```swift
"Hello <b>World</b>".applyBezierTagFont(
  component,
  normalToken: .textMedium(),
  normalColor: .textNeutral,
  boldToken: .textMedium(weight: .bold),
  boldColor: .textNeutral
)
```

> V3에서는 `hasTagProperty` 파라미터가 없습니다. 태그 폰트는 `String.applyBezierTagFont`을 직접 호출하며, normal/bold 토큰을 명시적으로 지정합니다. V1의 `getPairedBoldFont` 자동 매핑 대신 호출처에서 bold 토큰을 직접 결정합니다.

---

#### 4. UILabel/UITextView에 font 직접 설정

V1:
```swift
label.font = Desk_BezierFont.normal14.font
```

V3:
```swift
label.font = BTSemanticToken.textMedium().uiFont
```

> `.font` → `.uiFont`로 프로퍼티명이 다릅니다. V3의 `.font`는 SwiftUI `Font`를 반환합니다.

---

#### 5. lineHeight를 이용한 레이아웃 계산

V1:
```swift
let height = Desk_BezierFont.bold14.lineHeight + padding
label.snp.makeConstraints { $0.height.equalTo(Desk_BezierFont.bold13.lineHeight) }
```

V3:
```swift
let height = BTSemanticToken.labelLarge.lineHeight + padding
label.snp.makeConstraints { $0.height.equalTo(BTSemanticToken.labelMedium.lineHeight) }
```

> 동일한 `.lineHeight` 프로퍼티를 제공합니다.

---

#### 6. attribute 딕셔너리 (UITextView, 수동 구성)

V1:
```swift
let attrs = Desk_BezierFont.normal14.attributes(component, semanticColor: .textNeutral)
```

V3:
```swift
let attrs = BTSemanticToken.textMedium().attributes(component, semanticColorToken: .textNeutral)
```

> V1에서는 `FontSemanticColor`를 사용하지만 V3에서는 `BCSemanticToken`을 직접 사용합니다.

---

#### 7. 텍스트 사이즈 계산 (boundingRect)

V1:
```swift
let size = text.boundingRect(
  with: maxSize,
  attributes: Desk_BezierFont.normal16.sizeAttributes()
).size
```

V3:
```swift
let size = text.boundingRect(
  with: maxSize,
  attributes: BTSemanticToken.textXlarge().sizeAttributes()
).size
```

> 동일한 `.sizeAttributes()` 메서드를 제공합니다.

---

#### 8. letterSpacing 직접 접근

V1:
```swift
attributes[.kern] = Desk_BezierFont.normal16.letterSpacing
```

V3:
```swift
attributes[.kern] = BTSemanticToken.textXlarge().letterSpacing
```

> 동일한 `.letterSpacing` 프로퍼티를 제공합니다.

---

#### 9. 하이라이트 텍스트 (addFontColorOn)

V1:
```swift
attributedString.addFontColorOn(
  highlightText: keyword,
  font: Desk_BezierFont.bold13.font,
  color: color
)
```

V3:
```swift
attributedString.addFontColorOn(
  highlightText: keyword,
  font: BTSemanticToken.labelMedium.uiFont,
  color: color
)
```

> `addFontColorOn`은 `UIFont`을 받으므로 `.font` → `.uiFont`만 변경합니다.

---

#### 10. SwiftUI Text에 font만 적용 (bezierFont)

V1:
```swift
Text("Hello").bezierFont(.bold14)
```

V3:
```swift
Text("Hello").font(BTSemanticToken.labelLarge.font)
```

> V3에서는 별도 `.bezierFont()` modifier 없이 SwiftUI 표준 `.font()`를 사용합니다.

---

### V3 API 전체 목록

| API | 반환 타입 | 용도 |
|-----|----------|------|
| `.fontSize` | `CGFloat` | 폰트 크기 (pt) |
| `.lineHeight` | `CGFloat` | 줄 높이 (pt) |
| `.letterSpacing` | `CGFloat` | 자간 (pt) |
| `.resolvedWeight` | `BTFontWeight` | 해석된 weight (.regular/.bold) |
| `.isMonospace` | `Bool` | monospace 여부 |
| `.font` | `Font` | SwiftUI Font |
| `.uiFont` | `UIFont` | UIKit UIFont |
| `.lineSpacing` | `CGFloat` | SwiftUI lineSpacing modifier용 |
| `.verticalPadding` | `CGFloat` | lineSpacing/2, 상하 패딩 |
| `.attributedString(_:text:semanticColorToken:...)` | `NSAttributedString` | 완성된 attributed string |
| `.attributedString(_:text:semanticColor:...)` | `NSAttributedString` | SemanticColor 버전 |
| `.attributes(_:semanticColorToken:...)` | `[Key: Any]` | attribute 딕셔너리 |
| `.sizeAttributes(...)` | `[Key: Any]` | 색상 없는 사이즈 계산용 |
| `.makeParagraphStyle(...)` | `NSMutableParagraphStyle` | paragraph style 헬퍼 |
| `String.applyBezierTagFont(_:normalToken:...)` | `NSAttributedString` | 태그 폰트 처리 |
| `View.applyBezierFontStyle(_:semanticColorToken:)` | `some View` | SwiftUI modifier |
| `View.applyBezierFontStyle(_:semanticColor:)` | `some View` | SemanticColor 버전 |

### 대응 불가 항목

현재 V3에서 직접 대응하지 않는 패턴은 **없습니다**. 위 10가지 패턴으로 ch-desk-ios의 모든 Typography 사용처를 커버할 수 있습니다.
