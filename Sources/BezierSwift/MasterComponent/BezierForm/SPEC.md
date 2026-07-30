# BezierForm SPEC

> **SSOT**: [Figma · Mobile-Components / Form (2925:52)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=2925-52) · [Internal/FormField (2920:46)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=2920-46) · [Internal/FormFieldErrorMessage (5042:3035)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=5042-3035)
> **Design spec doc**: [team-design / bezier-v3 / components / Form-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Form-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

한 번에 함께 검증·제출되어야 하는 FormField들의 컨테이너 (Figma component description 1행).

## 1. Component Properties

### Form (COMPONENT `2925:52`)

| Property | 값 | 비고 |
|---|---|---|
| (variant/property 없음) | — | FormField 인스턴스들의 세로 스택 단일 COMPONENT. 마스터에 FormField 3개 배치 |

### Internal/FormField (CS `2920:46`)

| Property | 값 | 비고 |
|---|---|---|
| **labelPosition** | `top`(기본) / `left` | 라벨-컨트롤 배치. top=stacked, left=inline |
| **label** | TEXT, 기본 `"Label"` | 라벨 텍스트 |
| **hasLabel** | BOOLEAN, 기본 `true` | LabelArea 표시 여부 — `top` variant에만 배선 (`left`는 LabelArea 상시 표시) |
| **hasDescription** | BOOLEAN, 기본 `true` | Description(라벨 부제) 표시 여부 |
| **description** | TEXT, 기본 `"Description text"` | 라벨 부제 텍스트 |
| **required** | BOOLEAN, 기본 `false` | 라벨 끝 `*` 마커 표시 |
| **hasError** | BOOLEAN, 기본 `false` | Internal/FormFieldErrorMessage 행 표시 |
| **hasCustomContent** | BOOLEAN, 기본 `false` | customContentWrapper 표시 |
| **stackedControl** | SLOT (FILL width, 마스터 placeholder 높이 36) | `top` variant의 컨트롤 슬롯 |
| **inlineControl** | SLOT (마스터 placeholder 120×36) | `left` variant의 컨트롤 슬롯 |
| **customContent** | SLOT (FILL width, 마스터 placeholder 높이 100) | 필드 직속 복합 콘텐츠 슬롯 |

### Internal/FormFieldErrorMessage (COMPONENT `5042:3035`)

| Property | 값 | 비고 |
|---|---|---|
| **errorTtext** | TEXT, 기본 `"Error message"` | 에러 메시지 텍스트 (Figma 원문 property 이름 그대로 — 오탈자 포함) |

## 2. Layout Spec

### Form 루트 (`2925:52`)

| Part | 값 |
|---|---|
| 배치 | 세로 스택, FormField들 FILL width |
| FormField 간 간격 | `0pt` (필드 간 간격은 FormField 자체의 하단 패딩 24pt가 담당) |
| 루트 패딩 | 없음 |
| 마스터 폭 | 303 (사용처 FILL — 예시 프레임 `5042:2490`에서 343) |

### FormField 루트 (variant 공통)

> **파일 내 구조 divergence 실측** — Form 마스터(`2925:52`) 내부의 FormField 인스턴스 3개는 CS(`2920:46`)가 아니라 별도 노드 `2920:34`("FormField/top")를 main component로 참조하며, 아래 표와 다른 stale 구조를 갖는다: ControlGroup에 gap `4pt`가 있고, 그 안에 `Internal/FormFieldErrorMessage` 인스턴스가 아닌 **hidden TEXT 레이어** `ErrorMessage`가 들어 있으며, `hasError` property 자체가 없어 그 텍스트를 표시할 수단이 없다. 반면 CS(`2920:46`)와 예시 프레임(`5042:2490`)의 Form 인스턴스는 아래 표대로 ErrorMessage를 FormField 루트에 배치한다. 아래 값과 §1 FormField 표는 **CS + 예시 프레임 기준**이며 구현도 이를 따른다.

| Part | 값 |
|---|---|
| 배치 | 세로 스택: Content → customContentWrapper(있으면) → ErrorMessage(있으면) |
| 루트 gap | `6pt` |
| 하단 패딩 | `24pt` |
| 좌우/상단 패딩 | 없음 |

### Content (labelPosition=top, `2920:45`)

| Part | 값 |
|---|---|
| 배치 | 세로 스택 gap `8pt`: LabelArea(hasLabel=true 시) → ControlGroup |
| ControlGroup | 세로, FILL width. stackedControl 슬롯 FILL width (마스터 placeholder 높이 36 — 실사용 높이는 컨트롤 고유값: 예시에서 TextArea 64, TextInput 40) |

### Content (labelPosition=left, `2920:23`)

| Part | 값 |
|---|---|
| 배치 | 가로, 양끝 배치(space-between), 상단 정렬 |
| LabelArea | 남는 폭 채움 (flex-1, min-width 1) |
| ControlGroup | min-width `120pt` / max-width `200pt`, 내부 컨트롤 우측 정렬. inlineControl 슬롯 마스터 placeholder 120×36 (실사용 크기는 컨트롤 고유값: 예시에서 Button 81×24) |

### LabelArea (variant 공통)

| Part | 값 |
|---|---|
| 배치 | 세로 gap `2pt`: LabelRow → Description(hasDescription=true 시) |
| 좌측 패딩 | `2pt` |
| LabelRow | 가로 gap `2pt`: FormLabel → RequiredMarker(`*`, required=true 시) |

### customContentWrapper

| Part | 값 |
|---|---|
| 배치 | FILL width, customContent 슬롯 FILL width (마스터 placeholder 높이 100) |

### Internal/FormFieldErrorMessage

| Part | 값 | Figma Variable |
|---|---|---|
| 배치 | 가로 gap `4pt`: iconBox → 텍스트(flex-1, break-word), 상단 정렬 | — |
| radius | `8pt` | `radius/8` |
| FormField 내 배치 시 좌측 패딩 | `2pt` (인스턴스 오버라이드 — LabelArea 좌측 패딩과 정렬) | — |
| iconBox | 높이 `16pt`, 아이콘 수직·수평 센터 | — |
| 아이콘 | `icon/error-diamond-filled` `10×10pt` | `sourceSize/10` |

## 3. 컬러 토큰

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| FormLabel 텍스트 | `textNeutral` | `color/text/neutral` | `#000000D9` |
| RequiredMarker `*` | `textAccentOrange` | `color/text/accent/orange` | `#E67F2B` |
| Description 텍스트 | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| ErrorMessage 텍스트 | `textAccentOrange` | `color/text/accent/orange` | `#E67F2B` |
| ErrorMessage 아이콘 | `iconAccentOrange` | `color/icon/accent/orange` | `#E67F2B` |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| FormLabel · RequiredMarker | `BTSemanticToken.labelLarge` | `Typography/label/large` (15 / 700 / lh 20 / ls 0) |
| Description | `BTSemanticToken.textXSmall(weight: .regular)` | `Typography/text/xsmall` (12 / 400 / lh 16 / ls 0) |
| ErrorMessage 텍스트 | `BTSemanticToken.captionMedium(weight: .regular)` | `Typography/caption/medium` (12 / 400 / lh 16 / ls 0) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

| State | 시각 동작 |
|---|---|
| default | ErrorMessage 미표시 |
| hasError=true | FormField 하단(customContent 다음)에 Internal/FormFieldErrorMessage 행 표시 |

- 컨트롤 자체의 에러 보더(예시 프레임 `5042:2490`의 TextArea에 걸린 `State/error` = INNER_SHADOW `color/state/warning` spread 1.5)는 슬롯에 주입되는 컨트롤 컴포넌트(TextInput 등)의 `hasError` state 소관이다. FormField CS의 hasError는 ErrorMessage 행 표시만 배선한다.
- Form 자체에는 state variant 축 없음.

## 6. 디자이너 가이드라인 (Figma component description 인용)

### Form

- 한 번에 함께 검증·제출되어야 하는 FormField들의 컨테이너. 일괄 제출 방식. hasChanges=false(기본): FormActions 숨김 (pristine 상태) / hasChanges=true: FormActions 출현 → Save 버튼 활성화 (dirty 상태). 즉시 저장이 필요하면 Form이 아닌 Settings 사용. 마지막 FormField의 Divider는 visible=false로 오버라이드됨.
  - (구조 실측: Mobile COMPONENT `2925:52`에는 hasChanges property·FormActions·Divider 레이어가 존재하지 않음 — FormField 세로 스택만 존재. 예시 프레임 `5042:2490`의 저장 버튼은 Navbar 우측 텍스트 버튼으로 페이지 레벨에 배치됨)

### Internal/FormField

- Used within Form only. Do not place standalone. 레이블·컨트롤·보조텍스트·에러 메시지를 하나의 행으로 묶는 필드 래퍼. Form(일괄 제출) 안에서 사용하며, submit 전 검증 피드백을 인라인으로 표시.
- layout: inline(Switch·Select 등 compact 컨트롤) / stacked(TextInput 등 넓은 컨트롤)
- state: default / error (error 시 ErrorMessage 자동 표시 + Control orange stroke)
- required: true 시 라벨 끝에 `*` 마커 표시 (nullable 필수 입력 필드용)
- showDescription: 라벨 부제 표시 여부 (CS property 실명은 `hasDescription`)
- hasCustomContent: true 시 customContent SLOT 표시
- customContent(SLOT): 해당 필드와 직접 관련된 복합 값 표시·입력용. FILL width.
- errorMessages(SLOT): ErrorMessage 인스턴스만 배치 가능

### Internal/FormFieldErrorMessage

- Used within FormField only. Do not place standalone. Pill-shaped 에러 알림 박스. FormField의 state=error에서 자동 표시. 다중 에러 시 ErrorMessageStack 안에 수직 스택.
- errorText: 에러 메시지 텍스트 (TEXT property)
- Settings에서는 미사용 — 즉시 저장 에러는 롤백+Toast로 처리 (DL-032).
  - (구조 실측: Mobile FormField CS에는 ErrorMessageStack 레이어 없음 — 단일 ErrorMessage 인스턴스만 배선)

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit Form 컨테이너 | `BezierForm.swift` |
| SwiftUI Form 컨테이너 | `SUBezierForm.swift` |
| UIKit FormField | `BezierFormField.swift` |
| SwiftUI FormField | `SUBezierFormField.swift` |
| UIKit ErrorMessage 행 (internal) | `BezierFormFieldErrorMessage.swift` |
| SwiftUI ErrorMessage 행 (internal) | `SUBezierFormFieldErrorMessage.swift` |
| labelPosition / constant | `BezierFormSpec.swift` |
| 에러 아이콘 | `BezierIcon.errorDiamondFilled` (`icon-error-diamond-filled`) |

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **boolean+TEXT 쌍의 optional String 축약**: `hasLabel`+`label` → `labelText: String?`, `hasDescription`+`description` → `description: String?`, `hasError`+`errorTtext` → `errorText: String?` (nil = 미표시). BezierSection의 `labelText: String?` 선례를 따른다.
   - init 파라미터 레이블은 UIKit·SwiftUI 모두 `description:`이지만, UIKit 저장 프로퍼티명만 `fieldDescription`이다 — `UIView`가 상속하는 `NSObject.description`과 충돌하기 때문이다. SwiftUI는 충돌이 없어 `description` 그대로 쓴다.
2. **`required` → `isRequired`**: Swift에서 `required`는 선언 수식어 키워드라 프로퍼티명으로 사용하지 않는다.
3. **FormActions / FormHeader / FormError / FormDivider 스코프 제외**: team-design Form-spec.md §3의 웹 구조 파트들로, Mobile Figma에는 존재하지 않는다. 예시 프레임의 저장 버튼은 Navbar 배치(페이지 소관)다.
4. **컨트롤 에러 보더는 컨트롤 소관**: FormField는 임의 뷰를 슬롯으로 받으므로 컨트롤의 에러 표시(BezierTextInput `hasError` 등)는 소비자가 별도 지정한다.
5. **Card 조합은 소비자 책임**: team-design spec상 Form은 Card 안에 배치되지만, `BezierCard`는 chrome만 제공하고 Title·Description은 Card 스코프 밖이므로 조합은 소비자가 구성한다.
6. **다중 에러 미지원**: Mobile FormField CS가 단일 ErrorMessage만 배선하므로 `errorText`는 단일 문자열이다.
7. **Form 컨테이너 코드 표면**: UIKit `BezierForm`은 `setFields(_:)`/`addField(_:)`(BezierSection `setItems`/`addItem` 선례), SwiftUI `SUBezierForm`은 `@ViewBuilder` content(bezier-react `<Form>{children}</Form>` 동형)로 받는다.
8. **ErrorMessage radius 8의 구현 표현**: Figma ErrorMessage 노드는 radius 8만 있고 clip content가 꺼져 있어 배경 없는 행에서 시각 결과가 없다. UIKit은 `layer.cornerRadius`(masksToBounds 없음)로 보존하고, SwiftUI는 배경 없는 radius를 클리핑 없이 표현할 수단이 없어 미적용한다 — 두 경로 모두 렌더 결과는 Figma와 동일.
9. **`labelPosition == .left` + `labelText == nil`의 처리**: Figma는 `left` variant에서 LabelArea를 상시 표시하며(§1 `hasLabel` 비고) 라벨 없는 `left`를 정의하지 않는다. `labelText`를 두 배치에서 동일하게 optional로 받되, **`left`에서는 nil이어도 LabelArea 컨테이너를 유지**해 남는 폭을 흡수시킨다(라벨 텍스트만 비움) — 컨테이너까지 걷어내면 남는 폭을 흡수할 주체가 사라져 컨트롤이 가운데로 쏠리고 §2의 space-between 구조가 무너지기 때문이다(실측: 필드 폭 200pt에서 컨테이너 부재 시 컨트롤 x=90~110, 유지 시 x=180~200). `top`에서만 nil이 LabelArea 전체를 숨긴다. 별도 이니셜라이저로 타입 강제하는 대신 이 방식을 택한 이유는 배치 축 하나 때문에 public 표면이 두 배가 되기 때문이다.

## 9. Variant 매트릭스

```text
Form:                  단일 COMPONENT = 2925:52  (variant 축 없음)
FormField:             labelPosition=top = 2920:45, labelPosition=left = 2920:23  (총 2)
FormFieldErrorMessage: 단일 COMPONENT = 5042:3035  (variant 축 없음)
```
