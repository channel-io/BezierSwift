# BezierTextInput SPEC

> **SSOT**: [Figma · Mobile-Components / TextInput (3612:2)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=3612-2) · [Internal/TextInputAffix (4453:12044)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9A%A7-Mobile-Components?node-id=4453-12044)
> **Design spec doc**: [team-design / bezier-v3 / components / TextInput-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/TextInput-spec.md) · [BaseInput.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseInput.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

단일 행 텍스트 입력 필드 (Figma component description 1행).

- **배치**: width 기본 fill(부모 폭 채움). 최소 너비 40pt. ⚠️ secondary + error 조합 금지 (Figma description)

## 1. Component Properties

### TextInput (CS `3612:2`)

| Property | 값 | 비고 |
|---|---|---|
| **variant** | `primary` / `secondary` | 배경·보더 결정 |
| **size** | `small` / `medium` | 높이·radius·leadingContent 크기 결정 |
| **state** | `default` / `focused` / `error` / `readOnly` / `disabled` | 배경·보더·텍스트 색 결정 |
| **hasValue** | `false` / `true` | `false`: `placeholder` 레이어만 표시, `true`: `value` 레이어만 표시 |
| **placeholder** / **value** | TEXT | 각 텍스트 레이어의 내용 |
| **hasLeadingContent** | BOOLEAN, 기본 `false` | leadingContent 슬롯 표시 여부 |
| **leadingContent** | SLOT | 좌측 슬롯 (아이콘 또는 Internal/TextInputAffix) |
| **hasTrailingContent** | BOOLEAN, 기본 `false` | trailingContent 슬롯 표시 여부 |
| **trailingContent** | SLOT | 우측 슬롯 (아이콘 또는 Internal/TextInputAffix) |
| **allowClear** | BOOLEAN, 기본 `false` | 시스템 자동 요소 — cancel-circle-filled 아이콘 20pt |
| **passwordToggle** | BOOLEAN, 기본 `false` | 시스템 자동 요소 — view 형상 아이콘 20pt (SVG 실측 — slash 없는 뜬 눈) |

총 instance: variant 2 × size 2 × state 5 × hasValue 2 = **40개**

자식 배치 순서: `leadingContent → 입력 텍스트 → trailingContent → allowClear → passwordToggle`

### Internal/TextInputAffix (CS `4453:12044`)

| Property | 값 | 비고 |
|---|---|---|
| **size** | `medium` / `large` | 두 size 모두 동일 typography (Figma description: "모두 Typography/text/large 15px") |
| **text** | TEXT | 표시할 접사 텍스트 |

총 instance: size 2개 (`medium` = `4453:77`, `large` = `4453:12042`)

## 2. Size 별 Layout Spec

| Part | small | medium |
|---|---|---|
| 높이 (FIXED) | `40pt` | `48pt` |
| corner radius | `12pt` (`radius/12`) | `14pt` (`radius/14`) |
| 좌우 패딩 | `10pt` | `10pt` |
| 영역 간 gap | `6pt` | `6pt` |
| leadingContent 슬롯 높이 | `20pt` | `24pt` |
| trailingContent 슬롯 | `20×20pt` | `20×20pt` |
| allowClear / passwordToggle | `20×20pt` | `20×20pt` |
| 최소 너비 | `40pt` | `40pt` |
| 보더(INNER_SHADOW) 두께 | `1.5pt` (spread) | `1.5pt` |

- 너비: 기본 fill — 부모 폭을 채움 (Figma description). 높이는 콘텐츠와 무관하게 고정.
- 입력 텍스트는 1줄, 초과분 ellipsis (`textTruncation=ENDING`, `maxLines=1`).
- 보더는 Effect `State/*` — `INNER_SHADOW, offset (0,0), radius 0, spread 1.5` (안쪽 1.5pt 라인).

## 3. Variant × State 컬러 토큰

### Background

| State | primary | secondary |
|---|---|---|
| `default` | `fillGrey` (`color/fill/grey` `#FBFBFB`) | `fillNeutralLight` (`color/fill/neutral/light` `#0000000D`) |
| `focused` | `fillGreyLight` (`color/fill/grey/light` `#FDFDFD`) | `fillNeutralLight` |
| `error` | `fillGreyLight` | `fillNeutralLight` |
| `readOnly` | `fillGreyHeavy` (`color/fill/grey/heavy` `#F7F7F8`) | `fillNeutralLight` |
| `disabled` | `fillGrey` | `fillNeutralLight` |

### Border (INNER_SHADOW 1.5pt)

| State | primary | secondary |
|---|---|---|
| `default` | `State/default` — `stateDefault` (`color/state/default` `#00000026`) | — *(없음)* |
| `focused` | `State/active` — `stateActive` (`color/state/active` `#000000D9`) | `State/active` |
| `error` | `State/error` — `stateWarning` (`color/state/warning` `#E67F2B`) | `State/error` |
| `readOnly` | `State/default` | — *(없음)* |
| `disabled` | `State/default` | — *(없음)* |

### Text / Icon

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| placeholder (`hasValue=false`) | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| value (`hasValue=true`) | `textNeutral` | `color/text/neutral` | `#000000D9` |
| value (`state=readOnly`) | `textNeutralLight` | `color/text/neutral/light` | `#00000099` |
| allowClear / passwordToggle 아이콘 | `iconNeutral` | — (SVG 실측 `fill black 40%`) | `#00000066` 상당 |
| TextInputAffix 텍스트 | `textNeutralLight` | `color/text/neutral/light` | `#00000099` |

### Opacity

| State | 값 |
|---|---|
| `disabled` | `opacity/disabled` = 40% (전체) |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| placeholder / value (size 공통) | `BTSemanticToken.textXLarge(weight: .regular)` | `Typography/text/xlarge` (16 / 400 / lh 24 / ls -0.1) |
| Internal/TextInputAffix (size 공통) | `BTSemanticToken.textLarge(weight: .regular)` | `Typography/text/large` (15 / 400 / lh 20 / ls -0.1) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

| State | primary 변경점 | secondary 변경점 | 인터랙션 |
|---|---|---|---|
| `default` | 기본 | 기본 (보더 없음) | 활성 |
| `focused` | 배경 `fillGreyLight` + 보더 `State/active` | 보더 `State/active` (배경 불변) | 편집 중 |
| `error` | 배경 `fillGreyLight` + 보더 `State/error` | 보더 `State/error` (배경 불변) | 활성 |
| `readOnly` | 배경 `fillGreyHeavy`, value 텍스트 `textNeutralLight` | 배경 불변 (보더 없음) | 편집 차단, 선택·복사 가능 |
| `disabled` | 전체 opacity 40% | 전체 opacity 40% | 비활성 |

### 시스템 자동 요소

- **allowClear**: `allowClear=true` + focused + 값 있을 때 cancel-circle-filled(20pt, `iconNeutral`) 표시. 탭 시 값 초기화 후 포커스 유지.
- **passwordToggle**: `passwordToggle=true` 시 view 형상 아이콘(20pt, `iconNeutral`) 표시. allowClear보다 바깥쪽(더 오른쪽)에 배치.

## 6. 디자이너 가이드라인 (Figma component description 인용)

### TextInput

- 단일 행 텍스트 입력 필드. variant: primary / secondary • size: small / medium • state: default / focused / error / readOnly / disabled
- hasLeadingContent / hasTrailingContent: 슬롯 ON/OFF (아이콘 또는 TextInputAffix 배치)
- allowClear / passwordToggle: 시스템 자동 요소
- width: 기본 fill(부모 폭 채움). 비율 지정도 가능하나 Figma는 auto-layout 기능 한계로 표현 불가(FILL/FIXED/HUG만 지원). 최소 너비 40px.
- ⚠️ secondary + error 조합 금지

### Internal/TextInputAffix

- Used within TextInput only. Do not place standalone. TextInput의 leadingContent / trailingContent에 넣는 포맷 힌트 텍스트 (예: https://, %, .channel.io)
- text: 표시할 접사 텍스트 (기본값: https://) • size: medium / large (모두 Typography/text/large 15px)

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierTextInput.swift` |
| SwiftUI 구현 | `SUBezierTextInput.swift` |
| variant / size / constant | `BezierTextInputSpec.swift` |
| 공유 Input 레이어 (internal) | `../BezierBaseInput/BezierBaseInputSpec.swift` |
| Affix UIKit | `BezierTextInputAffix.swift` |
| Affix SwiftUI | `SUBezierTextInputAffix.swift` |

## 8. Figma 외 · 협의 사항 (구현 결정 — SSOT 값 아님)

1. **internal BaseInput 레이어**: 후속 TextArea(MOB-6348)·Search(MOB-6347)·Select(MOB-6353)가 BaseInput.md의 공통 시각 언어(배경·보더·radius·패딩·gap·state 해석)를 공유하므로, variant/state/appearance/metric을 `MasterComponent/BezierBaseInput/`의 **internal** 타입으로 분리한다. public 컴포넌트로 노출하지 않는다 (BaseInput.md: "이 문서는 독립 컴포넌트 스펙이 아니다").
2. **passwordToggle iOS 미구현**: Figma CS에 BOOLEAN으로 존재하나 design spec doc(§3 Anatomy G, §11 Platform)이 **Android 전용**으로 명시 — iOS v1 스코프에서 제외. secure text entry 자체도 미제공 (후속 티켓에서 필요 시 추가).
3. **state 우선순위**: Figma state 축은 배타적 단일 축. 코드 상태 조합의 해석 순서는 `disabled > readOnly > error > focused > default` (readOnly 중 focus되어도 readOnly 시각 유지, error 중 focus되어도 error 시각 유지).
4. **INNER_SHADOW → 보더 구현**: spread 1.5 / blur 0 / offset (0,0)의 INNER_SHADOW는 안쪽 1.5pt 라인과 동일 — UIKit `layer.borderWidth = 1.5` (bounds 안쪽 렌더), SwiftUI `strokeBorder(lineWidth: 1.5)` (inset stroke)로 구현.
5. **UITextField line-height 미적용**: 단일 행 UITextField에 `minimumLineHeight`(24pt) paragraph style을 적용하면 caret·세로 정렬 이상이 생긴다. 컨테이너 높이가 40/48pt로 고정돼 세로 중앙 정렬로 동일한 시각 결과가 나오므로 font(16pt) + kern(-0.1)만 적용한다. SwiftUI도 동일하게 고정 높이 컨테이너 중앙 정렬.
6. **readOnly 동작**: UIKit은 delegate에서 문자 변경 차단(선택·복사 유지), SwiftUI는 `TextField` 대신 `.textSelection(.enabled)` `Text`로 렌더 (SwiftUI TextField에 readOnly가 없음).
7. **allowClear 아이콘**: `BezierIcon.cancelCircleFilled` 기존 에셋 사용 (Figma 인스턴스 SVG와 동일 형상 확인). 표시 조건 `allowClear && focused && !text.isEmpty` — readOnly/disabled에서는 미표시.
8. **allowClear/입력 콜백 API**: UIKit은 `onTextChanged` / `onEditingChanged` / `onSubmit` 클로저, 포커스 제어는 `becomeFirstResponder()`/`resignFirstResponder()` 포워딩 (design spec doc §7 Ref API의 focus/blur 대응). SwiftUI는 `Binding<String>` + 표준 environment 상속(`.keyboardType` 등).
9. **UIKit 키보드 옵션**: 내부 UITextField가 캡슐화되어 접근 불가하므로 `keyboardType` / `returnKeyType` passthrough만 최소 제공.
10. **TextInputAffix**: Figma의 size 축(medium/large)은 두 값의 typography가 동일해 코드에서는 축 없이 단일 뷰로 제공. 슬롯 콘텐츠는 소비자가 생성해 주입하므로 public 타입으로 노출한다 (`Internal/SectionLabel` → public `BezierSectionLabel`과 동일 패턴). Figma description "Do not place standalone"은 doc comment의 단독 배치 금지 안내로 전달한다.
11. **웹 전용 요소 스코프 제외**: copyButton(웹 전용, Mobile CS에 레이어 없음)·type/selectAllOn*/Ref API 등 bezier-react 전용 props는 미구현.
12. **readOnly 캐럿 숨김 (UIKit)**: 6의 delegate 차단은 편집만 막고 포커스는 그대로 허용해, 텍스트를 직접 탭하면 캐럿이 깜빡여 편집 가능한 것처럼 보였다. private `UITextField` 서브클래스에서 `caretRect(for:)`를 오버라이드해 readOnly일 때 크기 0 rect를 반환한다 — iOS 26 실측 결과 이 rect가 캐럿 뷰(`UIStandardTextCursorView`)의 frame으로 그대로 전달되므로 캐럿만 사라지고 선택 하이라이트·드래그 핸들은 남는다. 대안 배제 근거: `isEnabled = false`는 선택·복사까지 죽이고, `tintColor = .clear`는 캐럿뿐 아니라 선택 하이라이트·핸들까지 투명하게 만든다. **6과의 관계** — 6은 "편집 차단"(값 불변), 12는 "편집 가능해 보이는 시각 신호 제거"로 역할이 나뉘며 12는 6을 대체하지 않는다. 선택 시 뜨는 context menu는 유지한다(디자인 협의): Cut/Paste 항목이 보여도 6의 delegate 차단이 값 변경을 막아 텍스트가 불변임을 시뮬레이터에서 확인했다.

## 9. Variant 매트릭스

총 instance: variant 2 × size 2 × state 5 × hasValue 2 = **40개**

```text
variant=primary,   size=small,  state=default,  hasValue=false = 1105:3
variant=primary,   size=small,  state=default,  hasValue=true  = 2451:146
variant=primary,   size=small,  state=focused,  hasValue=false = 1105:5
variant=primary,   size=small,  state=focused,  hasValue=true  = 2451:154
variant=primary,   size=small,  state=error,    hasValue=false = 1105:7
variant=primary,   size=small,  state=error,    hasValue=true  = 2451:162
variant=primary,   size=small,  state=readOnly, hasValue=false = 4548:925
variant=primary,   size=small,  state=readOnly, hasValue=true  = 4548:931
variant=primary,   size=small,  state=disabled, hasValue=false = 1105:9
variant=primary,   size=small,  state=disabled, hasValue=true  = 2451:170
variant=primary,   size=medium, state=default,  hasValue=false = 1105:11
variant=primary,   size=medium, state=default,  hasValue=true  = 2451:178
variant=primary,   size=medium, state=focused,  hasValue=false = 1105:13
variant=primary,   size=medium, state=focused,  hasValue=true  = 2451:186
variant=primary,   size=medium, state=error,    hasValue=false = 1105:15
variant=primary,   size=medium, state=error,    hasValue=true  = 2451:194
variant=primary,   size=medium, state=readOnly, hasValue=false = 4548:937
variant=primary,   size=medium, state=readOnly, hasValue=true  = 4548:943
variant=primary,   size=medium, state=disabled, hasValue=false = 1105:17
variant=primary,   size=medium, state=disabled, hasValue=true  = 2451:202
variant=secondary, size=small,  state=default,  hasValue=false = 1105:27
variant=secondary, size=small,  state=default,  hasValue=true  = 2451:242
variant=secondary, size=small,  state=focused,  hasValue=false = 1105:29
variant=secondary, size=small,  state=focused,  hasValue=true  = 2451:250
variant=secondary, size=small,  state=error,    hasValue=false = 1105:31
variant=secondary, size=small,  state=error,    hasValue=true  = 2451:258
variant=secondary, size=small,  state=readOnly, hasValue=false = 4548:949
variant=secondary, size=small,  state=readOnly, hasValue=true  = 4548:955
variant=secondary, size=small,  state=disabled, hasValue=false = 1105:33
variant=secondary, size=small,  state=disabled, hasValue=true  = 2451:266
variant=secondary, size=medium, state=default,  hasValue=false = 1105:35
variant=secondary, size=medium, state=default,  hasValue=true  = 2451:274
variant=secondary, size=medium, state=focused,  hasValue=false = 1105:37
variant=secondary, size=medium, state=focused,  hasValue=true  = 2451:282
variant=secondary, size=medium, state=error,    hasValue=false = 1105:39
variant=secondary, size=medium, state=error,    hasValue=true  = 2451:290
variant=secondary, size=medium, state=readOnly, hasValue=false = 4548:961
variant=secondary, size=medium, state=readOnly, hasValue=true  = 4548:967
variant=secondary, size=medium, state=disabled, hasValue=false = 1105:41
variant=secondary, size=medium, state=disabled, hasValue=true  = 2451:298

Internal/TextInputAffix: size=medium = 4453:77, size=large = 4453:12042  (총 2)
```
