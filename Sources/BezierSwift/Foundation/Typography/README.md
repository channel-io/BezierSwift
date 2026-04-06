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

## 사용 예시

### SwiftUI

```swift
Text("Hello")
  .applyBezierFontStyle(.textMedium(), semanticColorToken: .textNeutral)

// Bold text
Text("Important")
  .applyBezierFontStyle(.textMedium(weight: .bold), semanticColorToken: .textNeutral)
```

### UIKit (NSAttributedString)

```swift
// 완성된 attributed string
let attributed = BTSemanticToken.textMedium()
  .attributedString(component, text: "Hello", semanticColorToken: .textNeutral)

// attribute 딕셔너리 (UITextView 등)
let attrs = BTSemanticToken.textMedium()
  .attributes(component, semanticColorToken: .textNeutral)

// 사이즈 계산용 (색상 없음)
let sizeAttrs = BTSemanticToken.textMedium().sizeAttributes()

// 태그 폰트 (<b>bold</b> 지원)
let tagged = "Hello <b>World</b>".applyBezierTagFont(
  component,
  normalToken: .textMedium(),
  normalColor: .textNeutral,
  boldToken: .textMedium(weight: .bold),
  boldColor: .textNeutral
)
```
