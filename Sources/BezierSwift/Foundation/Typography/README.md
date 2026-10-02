# Bezier Typography V3

## 폰트 패밀리

일반 텍스트의 V3·V1 토큰과 Bezier 컴포넌트는 패키지에 포함된 Channel Sans 0.1.2를 사용합니다. `codeMedium`·`codeSmall`은 고정폭 글자 정렬을 위해 시스템 monospace를 사용합니다.

라이브러리를 사용하는 앱도 `import BezierSwift` 후 같은 폰트를 사용할 수 있습니다.

```swift
let titleFont = ChannelSans.uiFont(ofSize: 18, weight: .bold)
let bodyFont = ChannelSans.font(size: 14)
let fontFileURL = ChannelSans.fontURL
```

`ChannelSans.uiFont`와 `ChannelSans.font`는 필요한 시점에 폰트를 자동 등록합니다. 폰트 파일을 직접 다룰 때는 `ChannelSans.register()`로 등록 결과를 확인할 수 있습니다. 제공되는 굵기는 Thin부터 Black까지 9개 인스턴스입니다. 폰트 라이선스는 패키지 리소스의 `ChannelSans-OFL.txt`에 포함되어 있습니다.

## 개요

Bezier Typography V3는 크로스 플랫폼 공통 명세 기반의 시멘틱 토큰 체계입니다. 22개 토큰이 6개 카테고리로 구성되며, UI 역할에 따라 토큰을 선택합니다.

## 토큰 구조

### 2-tier 위계

- **Global Token** (`BTGlobalToken`) — internal
  - FontSize, LineHeight, LetterSpacing, FontFamily 원시 값
  - 외부 노출 없음, Semantic Token 내부에서만 참조
- **Semantic Token** (`BTSemanticToken`) — public
  - Global Token을 조합한 22개 시멘틱 토큰

### 카테고리별 토큰

| 카테고리 | 토큰 | 용도 | Weight |
|---------|------|------|--------|
| **Display** | `displayLarge`, `displayMedium` | 대시보드 숫자, KPI | 700 고정 |
| **Heading** | `headingXLarge` ~ `headingXXSmall` (6개) | 페이지/섹션 제목 | 700 고정 |
| **Text** | `textXXLarge` ~ `textXXSmall` (7개) | 본문, 설명, 메시지 | 기본 400, bold 700 |
| **Label** | `labelLarge` ~ `labelSmall` (3개) | 버튼, 탭, 필드 라벨 | 700 고정 |
| **Caption** | `captionMedium`, `captionSmall` | 타임스탬프, 헬퍼 텍스트 | 기본 400, bold 700 |
| **Code** | `codeMedium`, `codeSmall` | 코드 블록, 인라인 코드 | 400 고정, monospace |

### Weight 정책

iOS는 **400(Regular) / 700(Bold) 이진 체계**를 사용합니다.

- **고정 weight** (Display, Heading, Label, Code): weight가 토큰에 내장되어 있어 별도 지정 불가
- **가변 weight** (Text, Caption): `weight` 파라미터로 `.regular`(기본) 또는 `.bold` 선택

```swift
.textMedium()              // Regular (400)
.textMedium(weight: .bold) // Bold (700)
```

---

## 사용 가이드

### SwiftUI — 텍스트 스타일 적용

```swift
// 기본
Text("메시지 본문")
  .applyBezierFontStyle(.textMedium(), semanticColorToken: .textNeutral)

// Bold 강조
Text("중요한 텍스트")
  .applyBezierFontStyle(.textMedium(weight: .bold), semanticColorToken: .textNeutral)

// 섹션 제목
Text("설정")
  .applyBezierFontStyle(.headingSmall, semanticColorToken: .textNeutral)

// 버튼 라벨
Text("전송")
  .applyBezierFontStyle(.labelLarge, semanticColorToken: .textNeutral)

// 타임스탬프
Text("오후 3:42")
  .applyBezierFontStyle(.captionMedium(), semanticColorToken: .textNeutralLighter)
```

### UIKit — NSAttributedString 생성

```swift
// 단일 스타일
let attributed = BTSemanticToken.textMedium()
  .attributedString(component, text: "안녕하세요", semanticColorToken: .textNeutral)

// 태그 폰트 (<b>, <u> 파싱)
let tagged = BTSemanticToken.textMedium()
  .attributedString(
    component,
    text: "<b>홍길동</b>님이 초대했습니다",
    semanticColorToken: .textNeutral,
    hasTagProperty: true  // <b> → boldPair 자동 적용
  )
```

### UIKit — UILabel/UITextView에 font 설정

```swift
label.font = BTSemanticToken.textMedium().uiFont
textView.font = BTSemanticToken.codeMedium.uiFont
```

### UIKit — Attribute 딕셔너리

UITextView, UITextField 등에서 attribute를 직접 설정할 때:

```swift
// 색상 포함
let attrs = BTSemanticToken.textMedium()
  .attributes(component, semanticColorToken: .textNeutral)
textView.typingAttributes = attrs

// 색상 없이 (사이즈 계산용)
let size = NSAttributedString(
  string: text,
  attributes: BTSemanticToken.textMedium().sizeAttributes()
).boundingRect(
  with: maxSize,
  options: [.usesLineFragmentOrigin, .usesFontLeading],
  context: nil
).size
```

### UIKit — 태그 폰트 직접 호출

`attributedString(hasTagProperty:)`로 충분하지만, normal/bold 토큰을 다르게 지정해야 하는 경우:

```swift
let attributed = "Hello <b>World</b>".applyBezierTagFont(
  component,
  normalToken: .textMedium(),
  normalColor: .textNeutral,
  boldToken: .textMedium(weight: .bold),
  boldColor: .textNeutral
)
```

### 레이아웃 계산

```swift
// 높이 계산
let cellHeight = BTSemanticToken.labelLarge.lineHeight + verticalPadding

// constraint 설정
label.snp.makeConstraints {
  $0.height.equalTo(BTSemanticToken.textSmall().lineHeight)
}
```

---

## 프로퍼티 목록

| 프로퍼티 | 타입 | 설명 |
|---------|------|------|
| `fontSize` | `CGFloat` | 폰트 크기 (pt) |
| `lineHeight` | `CGFloat` | 줄 높이 (pt) |
| `letterSpacing` | `CGFloat` | 자간 (pt) |
| `resolvedWeight` | `BTFontWeight` | 해석된 weight (.regular/.bold) |
| `boldPair` | `BTSemanticToken` | bold 버전 토큰 (Text/Caption은 weight 변경, 나머지는 self) |
| `isMonospace` | `Bool` | monospace 여부 |
| `font` | `Font` | SwiftUI Font |
| `uiFont` | `UIFont` | UIKit UIFont |
| `lineSpacing` | `CGFloat` | SwiftUI `.lineSpacing()` modifier용 |
| `verticalPadding` | `CGFloat` | lineSpacing/2, 상하 패딩 |

## 메서드 목록

| 메서드 | 반환 | 설명 |
|--------|------|------|
| `attributedString(_:text:semanticColorToken:alignment:lineBreakMode:hasTagProperty:)` | `NSAttributedString` | 완성된 attributed string |
| `attributedString(_:text:semanticColor:alignment:lineBreakMode:hasTagProperty:)` | `NSAttributedString` | SemanticColor 버전 |
| `attributes(_:semanticColorToken:alignment:lineBreakMode:)` | `[NSAttributedString.Key: Any]` | attribute 딕셔너리 |
| `sizeAttributes(alignment:lineBreakMode:)` | `[NSAttributedString.Key: Any]` | 색상 없는 사이즈 계산용 |
| `View.applyBezierFontStyle(_:semanticColorToken:)` | `some View` | SwiftUI modifier |
| `View.applyBezierFontStyle(_:semanticColor:)` | `some View` | SemanticColor 버전 |
| `String.applyBezierTagFont(_:normalToken:normalColor:boldToken:boldColor:alignment:lineBreakMode:)` | `NSAttributedString` | 태그 폰트 — BCSemanticToken 색상 버전 |
| `String.applyBezierTagFont(_:normalToken:normalColor:boldToken:boldColor:alignment:lineBreakMode:)` | `NSAttributedString` | 태그 폰트 — SemanticColor 색상 버전 |
