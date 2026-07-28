# BezierTextArea SPEC

> **SSOT**: [Figma · Mobile-Components / TextArea (1850:13)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1850-13)
> **Design spec doc**: [team-design / bezier-v3 / components / TextArea-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/TextArea-spec.md) · [BaseInput.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseInput.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

여러 줄 텍스트를 작성하는 입력 영역. 설명, 메모, 답변 템플릿 등에 사용 (Figma component description 1행).

- **배치**: width 기본 fill(부모 폭 채움). 최소 너비 40pt.
- **높이**: 기본 64pt(2행)에서 시작해 내용에 따라 최대 160pt(6행)까지 자동 확장 (line-height 24pt 기준, Figma description)

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **state** | `default` / `focused` / `error` / `readOnly` / `disabled` | 배경·보더·텍스트 색 결정 |
| **hasValue** | `false` / `true` | `false`: `placeholder` 레이어만 표시, `true`: `value` 레이어만 표시 |
| **placeholder** / **value** | TEXT | 각 텍스트 레이어의 내용 |

> variant 축 없음 (단일 외형) · size 축 없음 (높이는 내용 기반 자동 확장).

총 instance: state 5 × hasValue 2 = **10개**

## 2. Layout Spec

| Part | 값 |
|---|---|
| 기본·최소 높이 | `64pt` (2행) |
| 최대 높이 | `160pt` (6행) |
| corner radius | `12pt` (`radius/12`) |
| 좌우 패딩 | `10pt` |
| 상하 패딩 | `8pt` |
| 최소 너비 | `40pt` |
| 보더(INNER_SHADOW) 두께 | `1.5pt` (spread) |

- 너비: 기본 fill — 부모 폭을 채움 (Figma description).
- 높이 모델: `64 = 24×2 + 8×2` / `160 = 24×6 + 8×2` (Figma variant frame `height=64` + `minHeight=64` + `maxHeight=160` + `minWidth=40`).
- 텍스트는 컨테이너 상단부터 배치 (top-leading), 줄바꿈으로 아래 방향 성장.
- 컨테이너는 `overflow-clip` — 최대 높이를 넘는 콘텐츠는 잘린다 (구현의 스크롤 대체는 §8-2).
- 보더는 Effect `State/*` — `INNER_SHADOW, offset (0,0), radius 0, spread 1.5` (안쪽 1.5pt 라인).

## 3. State 별 컬러 토큰

variant 축이 없으므로 모든 셀이 단일 열이다.

### Background

| State | Token | Figma Variable | Raw |
|---|---|---|---|
| `default` | `fillGrey` | `color/fill/grey` | `#FBFBFB` |
| `focused` | `fillGreyLight` | `color/fill/grey/light` | `#FDFDFD` |
| `error` | `fillGreyLight` | `color/fill/grey/light` | `#FDFDFD` |
| `readOnly` | `fillGreyHeavy` | `color/fill/grey/heavy` | `#F7F7F8` |
| `disabled` | `fillGrey` | `color/fill/grey` | `#FBFBFB` |

### Border (INNER_SHADOW 1.5pt)

| State | Effect Style | Token | Figma Variable | Raw |
|---|---|---|---|---|
| `default` | `State/default` | `stateDefault` | `color/state/default` | `#00000026` |
| `focused` | `State/active` | `stateActive` | `color/state/active` | `#000000D9` |
| `error` | `State/error` | `stateWarning` | `color/state/warning` | `#E67F2B` |
| `readOnly` | `State/default` | `stateDefault` | `color/state/default` | `#00000026` |
| `disabled` | `State/default` | `stateDefault` | `color/state/default` | `#00000026` |

### Text

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| placeholder (`hasValue=false`, 전 state 공통) | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| value (`hasValue=true`) | `textNeutral` | `color/text/neutral` | `#000000D9` |
| value (`state=readOnly`) | `textNeutralLight` | `color/text/neutral/light` | `#00000099` |

### Opacity

| State | 값 |
|---|---|
| `disabled` | `opacity/disabled` = 40% (전체) |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| placeholder / value | `BTSemanticToken.textXLarge(weight: .regular)` | `Typography/text/xlarge` (16 / 400 / lh 24 / ls -0.1) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

| State | 변경점 | 인터랙션 |
|---|---|---|
| `default` | 기본 (`fillGrey` + `State/default` 보더) | 활성 |
| `focused` | 배경 `fillGreyLight` + 보더 `State/active` | 편집 중 |
| `error` | 배경 `fillGreyLight` + 보더 `State/error` | 활성 |
| `readOnly` | 배경 `fillGreyHeavy`, value 텍스트 `textNeutralLight` | 편집 차단 |
| `disabled` | 전체 opacity 40% | 비활성 |

## 6. 디자이너 가이드라인 (Figma component description 인용)

- 여러 줄 텍스트를 작성하는 입력 영역. 설명, 메모, 답변 템플릿 등에 사용.
- state: Default / Focused / Error / ReadOnly / Disabled — Figma 설계용
- hasValue: false / true — 값 유무 상태 시각 확인용
- width: 기본 fill(부모 폭 채움). 비율 지정도 가능하나 Figma는 auto-layout 기능 한계로 표현 불가(FILL/FIXED/HUG만 지원). 최소 너비 40px.
- 모바일 기본 높이 64px(2행) / 최대 160px(6행) (line-height 24px 기준)
- hasError 사용 시 반드시 에러 메시지를 함께 표시할 것 (빨간 테두리만 표시 금지).
- 한 줄 입력(이름·이메일 등)에는 TextInput을 사용한다.

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierTextArea.swift` |
| SwiftUI 구현 | `SUBezierTextArea.swift` |
| 높이 모델 상수 | `BezierTextAreaSpec.swift` |
| 공유 Input 레이어 (internal) | `../BezierBaseInput/BezierBaseInputSpec.swift` |

## 8. Figma 외 · 협의 사항 (구현 결정 — SSOT 값 아님)

1. **internal BaseInput 레이어 재사용**: 배경·보더·텍스트 색의 state 해석은 `BezierBaseInputAppearance`에 `variant: .primary` 고정 주입으로 재사용한다. Figma에 variant 축이 없으므로 public API에 variant를 노출하지 않는다 (단일값 property 규칙). 높이 모델(64/160/상하 패딩 8)만 TextArea 자체 정의 (`BezierTextAreaSpec.swift`).
2. **높이 자동 확장 구현**: 콘텐츠 높이를 64~160pt 범위로 clamp. 160pt 초과분은 §2의 clip 대신 내부 스크롤로 노출해 캐럿 가시성을 유지한다.
3. **state 우선순위**: Figma state 축은 배타적 단일 축. 코드 상태 조합의 해석 순서는 `disabled > readOnly > error > focused > default` (`BezierBaseInputState.resolve` 재사용).
4. **INNER_SHADOW → 보더 구현**: spread 1.5 / blur 0 / offset (0,0)의 INNER_SHADOW는 안쪽 1.5pt 라인과 동일 — UIKit `layer.borderWidth = 1.5` (bounds 안쪽 렌더), SwiftUI `strokeBorder(lineWidth: 1.5)` (inset stroke)로 구현.
5. **line-height 24pt 적용**: 높이 모델(2행=48, 6행=144)이 lh24 기준이므로 line height를 실제 적용한다. UIKit은 `BTSemanticToken.attributes()`(paragraphStyle `minimumLineHeight` + baselineOffset), SwiftUI는 `applyBezierFontStyle`(lineSpacing + verticalPadding 보정)로 N행 블록 높이 = N×24pt.
6. **readOnly 동작**: UIKit은 `isEditable = false`(선택·복사·스크롤 유지), SwiftUI는 `TextField` 대신 `.textSelection(.enabled)` `Text`로 렌더 (SwiftUI TextField에 readOnly가 없음). SwiftUI readOnly에서 6행 초과분은 tail truncation.
7. **Enter = 줄 바꿈**: design spec doc §7 키보드 — Enter는 줄 바꿈이므로 `onSubmit`/`returnKeyType`을 제공하지 않는다. UIKit은 `keyboardType` passthrough만 최소 제공.
8. **높이 상한 구현 (패러다임별 기제가 다름)**: 두 패러다임 모두 상한을 **pt 높이(160)** 로 건다 — 행 수 API로는 상한을 걸 수 없다.
   - SwiftUI: `TextField(axis: .vertical)` + `lineLimit(2...)`(하한만) + 컨테이너 `maxHeight`. `lineLimit`의 상한은 폰트 고유 행높이로 높이를 예산 잡는데 실제 렌더는 `lineSpacing`이 실려 24pt 피치라, `2...6`을 주면 6행이 아니라 5행만 보인다 (시뮬레이터 실측 135.3pt).
   - UIKit: `UITextView` 래핑 + 높이 제약 갱신. iOS 16+ 기본인 TextKit 2가 `paragraphStyle.minimumLineHeight`를 무시해 행 피치가 폰트 고유값(약 22.7pt)으로 좁아지므로 `UITextView(usingTextLayoutManager: false)`로 TextKit 1을 쓴다. 그래야 공유 타이포 헬퍼가 `UILabel`에서와 동일하게 24pt 행 높이를 만든다.
9. **콜백 API**: UIKit은 `onTextChanged` / `onEditingChanged` 클로저, 포커스 제어는 `becomeFirstResponder()`/`resignFirstResponder()` 포워딩. SwiftUI는 `Binding<String>`.
10. **SwiftUI placeholder 렌더 방식**: `TextField(prompt:)`는 `Text`만 받아 View modifier인 `lineSpacing`을 실을 수 없다. 여러 줄 placeholder의 행 높이를 24pt로 세우려면 `prompt`를 쓰지 않고 `.overlay`로 직접 그려야 한다 (UIKit의 별도 `placeholderLabel`과 동형).
11. **placeholder 행 수 상한 2행 + 말줄임**: Figma는 placeholder를 한 줄로만 그려 행 수 규정이 없다. 컨테이너 높이는 **값** 기준으로만 자라므로(값이 비면 §2의 기본 높이 64pt=2행에 고정) placeholder를 막지 않으면 2행을 넘는 순간 UIKit은 `masksToBounds`에 잘리고 SwiftUI 오버레이는 라운드 박스 밖으로 그려진다. 양쪽 모두 2행 + tail 말줄임으로 막는다 (UIKit `numberOfLines` + paragraphStyle `.byTruncatingTail`, SwiftUI `.lineLimit(2)` + `.truncationMode(.tail)`). placeholder가 컨테이너를 키우지는 않는다.
12. **스크롤 인디케이터 숨김**: Figma는 오버플로 상태를 그리지 않아(전 인스턴스 height=64, 자식은 텍스트 레이어뿐) 인디케이터 규정이 없다 — 코드 전용 결정이다. 내부 스크롤(§8-2)은 인디케이터 없이 동작한다. SwiftUI `TextField(axis: .vertical)`는 내부 스크롤 뷰 접근 수단이 없어 인디케이터를 켤 수 없으므로, 패리티는 UIKit `showsVerticalScrollIndicator = false`로 맞춘다. 컴포넌트 내부의 부수적 오버플로 스크롤은 인디케이터를 숨기는 저장소 관례와도 일치한다.
13. **웹 전용 요소 스코프 제외**: `minRows`/`maxRows` prop(웹 `TextAreaHeight` 3|6|10|16|24|36)·`autoFocus`·IME 키 잠금은 bezier-react 전용 — 모바일 Figma 높이 모델(2행/6행 고정)만 구현한다.

## 9. Variant 매트릭스

총 instance: state 5 × hasValue 2 = **10개**

```text
state=default,  hasValue=false = 1850:3
state=focused,  hasValue=false = 1850:5
state=error,    hasValue=false = 1850:7
state=readOnly, hasValue=false = 1850:9
state=disabled, hasValue=false = 1850:11
state=default,  hasValue=true  = 4542:66
state=focused,  hasValue=true  = 4542:68
state=error,    hasValue=true  = 4542:70
state=readOnly, hasValue=true  = 4542:72
state=disabled, hasValue=true  = 4542:74
```
