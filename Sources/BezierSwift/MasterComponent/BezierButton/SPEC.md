# BezierButton SPEC

> **SSOT**: [Figma · Mobile-Components / Button (1734:146)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1734-146)
>
> 이 문서는 Figma 디자인의 단일 진실 공급원(SSOT)을 코드 관점에서 정리한 것이다. 모든 수치/토큰은 Figma에 실재해야 한다.

## 1. Component Overview

- **이름**: Button
- **설명**: 클릭·제출 등 단일 액션을 트리거하는 인터랙션 컴포넌트.
- **가이드라인**:
  - `semantic = primary` 버튼은 한 화면에 1개만 둔다.
  - 아이콘 전용 버튼은 IconButton(별도 컴포넌트)을 사용한다.

## 2. Component Properties

Figma Button 컴포넌트가 정의하는 property는 다음 9개가 전부다.

### Variant 축 (4)

| 축 | 값 | 비고 |
|---|---|---|
| `size` | `xsmall`, `small`, `medium`, `large`, `xlarge` | 5 옵션 |
| `variant` | `filled`, `outlined`, `ghost` | 3 옵션 |
| `semantic` | `primary`, `secondary`, `destructive` | 3 옵션 |
| `state` | `default`, `pressed`, `active`, `disabled`, `loading` | 런타임 API로 노출하지 않는다 (§2-1) |

Figma 매트릭스 총량: 5 × 3 × 3 × 5 = **225 symbols** (전부 실재).

### 콘텐츠 property (5)

| property | 타입 | 기본값 | 비고 |
|---|---|---|---|
| `text` | TEXT | `"Label"` | 라벨 문자열 |
| `leadingContent` | BOOLEAN | `false` | 라벨 왼쪽 슬롯 표시 여부 |
| `trailingContent` | BOOLEAN | `false` | 라벨 오른쪽 슬롯 표시 여부 |
| `leadingContentSource` | INSTANCE_SWAP | `icon/plus` | 왼쪽 슬롯에 주입할 인스턴스 |
| `trailingContentSource` | INSTANCE_SWAP | `icon/plus` | 오른쪽 슬롯에 주입할 인스턴스 |

- 슬롯은 Icon 사용 권장. 액션 이해에 특별히 유리하면 다른 UI를 swap instance로 적용 가능 (컴포넌트 description).

### 2-1. State 축의 해석

코드는 다음 런타임 상태만 노출한다:

| 코드 상태 | Figma state 매핑 |
|---|---|
| `isEnabled = true`, 정상 | `default` |
| `isHighlighted = true` (터치 중) | `pressed` |
| `isEnabled = false` | `disabled` |
| `isLoading = true` | `loading` |
| (없음) | `active` — Figma에 variant로 실재하나 코드 런타임 상태로 노출하지 않는다. |

## 3. Layout (size별)

> Figma 좌표/크기 (변하지 않는 cell-level 수치). 모든 size에서 `border-radius: 9999px` (= 완전 capsule, 높이의 절반).

| size | height | minWidth | horizontalPadding (px) | textHorizontalPadding (text px) | contentSpacing (gap) | iconLength |
|---|---|---|---|---|---|---|
| xsmall | 24 | 20 | 4 | 3 | 0 (no gap) | 16 |
| small | 30 | 24 | 6 | 3 | 0 (no gap) | 16 |
| medium | 40 | 36 | 10 | 4 | 2 | 16 |
| large | 44 | 44 | 12 | 4 | 2 | 16 |
| xlarge | 54 | 54 | 20 | 4 | 2 | 16 |

- **border-radius**: 모든 size에서 height의 절반 (완전 capsule).
- **icon**: leadingContent / trailingContent 슬롯은 텍스트 좌우에 배치, 16×16 고정. 아이콘 색은 텍스트와 동일 색 (export SVG raw 색이 §5 text 색과 일치).

## 4. Typography (size별)

> **xsmall·small·medium**은 Foundation `Typography/label/*` 텍스트 스타일 토큰에 바인딩되어 있고,
> **large·xlarge**는 대응 label 스타일 미등록으로 raw 변수 조합(`font-size/16` + `line-height/24` + `label/weight`)이 직접 적용되어 있다.

공통값 (5 size 동일):
- `font-family`: `Inter` (variable: `label/font-family`)
- `letter-spacing`: `0` (variable: `label/letter-spacing`)

size 별 값:

| size | Figma 바인딩 | fontSize | lineHeight | fontWeight |
|---|---|---|---|---|
| xsmall | `Typography/label/small` | 13 (`label/size/small`) | 18 (`label/line-height/small`) | 700 (`label/weight/bold`) |
| small | `Typography/label/medium` | 14 (`label/size/medium`) | 20 (`label/line-height/medium`) | 700 (`label/weight/bold`) |
| medium | `Typography/label/large` | 15 (`label/size/large`) | 20 (`label/line-height/large`) | 700 (`label/weight/bold`) |
| large | raw 변수 조합 | 16 (`font-size/16`) | 24 (`line-height/24`) | 500 (`label/weight`) |
| xlarge | raw 변수 조합 | 16 (`font-size/16`) | 24 (`line-height/24`) | 500 (`label/weight`) |

> weight는 size에 따라 갈린다 — xsmall·small·medium은 `label/weight/bold`(700), large·xlarge는 `label/weight`(500).
>
> iOS 매핑 (디자인 시스템 합의): `Typography/label/{small,medium,large}` ↔ `BTSemanticToken.label{Small,Medium,Large}` (13/18·14/20·15/20, weight bold 고정 — 값 완전 일치). large·xlarge의 16/24/500 조합은 대응 semantic 토큰이 없어 raw 값(`UIFont.Weight.medium`)으로 직접 구성한다.

## 5. Color (variant × semantic 별, default state)

> 키는 Figma variable 경로. 괄호 안은 raw 값. text 색은 아이콘·스피너에도 동일 적용된다 (§3, §7).

| variant × semantic | background | text/icon | border |
|---|---|---|---|
| `filled` × `primary` | `color/fill/neutral/heaviest` (`#000000d9`) | `color/text/inverse` (`#ffffff`) | — |
| `filled` × `secondary` | `color/fill/neutral` (`#00000014`) | `color/text/neutral` (`#000000d9`) | — |
| `filled` × `destructive` | `color/fill/accent/red/heavier` (`#e1535d`) | `color/text/absolute/white` (`#ffffff`) | — |
| `outlined` × `primary` | — | `color/text/neutral/heaviest` (`#000000`) | `color/border/neutral` (`#00000014`) |
| `outlined` × `secondary` | — | `color/text/neutral/light` (`#00000099`) | `color/border/neutral` (`#00000014`) |
| `outlined` × `destructive` | — | `color/text/accent/red` (`#e1535d`) | `color/border/neutral` (`#00000014`) |
| `ghost` × `primary` | — | `color/text/neutral/light` (`#00000099`) | — |
| `ghost` × `secondary` | — | `color/text/neutral/lighter` (`#00000066`) | — |
| `ghost` × `destructive` | — | `color/text/accent/red` (`#e1535d`) | — |

- **border-width**: outlined 1px (모든 size 공통).
- **outlined / ghost** variant는 default state에서 background fill 없음.
- `filled × destructive`의 텍스트는 `color/text/inverse`가 아니라 `color/text/absolute/white`다 — 붉은 배경 위 라벨은 테마와 무관하게 항상 흰색.

## 6. State 별 시각 동작

| state | 시각 처리 |
|---|---|
| `default` | 위 §5 색상 그대로 |
| `pressed` | 배경색이 `*-hovered` 변수로 전환 (아래 표). 텍스트·아이콘·보더 색은 default와 동일 |
| `active` | pressed와 동일 배경 변수 (Figma active variant 실측값). 코드 미노출 (§2-1) |
| `disabled` | 본체 노드 전체 `opacity: opacity/disabled` (`40%`) |
| `loading` | 라벨·아이콘 숨김 + 가운데 Spinner 인스턴스 표시, 사용자 입력 무시. **filled는 배경이 별도 `background` 레이어로 분리되어 레이어 opacity가 `opacity/disabled`(`40%`)로 낮아지고, Spinner는 full opacity를 유지한다.** outlined/ghost는 background 레이어 없음 (outlined 보더는 그대로) |

### pressed 배경 (variant × semantic)

| variant × semantic | pressed background |
|---|---|
| `filled` × `primary` | `color/fill/neutral/heaviest-hovered` (`#1c1c1cd9`) |
| `filled` × `secondary` | `color/fill/neutral-hovered` (`#1c1c1c1e`) |
| `filled` × `destructive` | `color/fill/accent/red-heavier-hovered` (`#da444f`) |
| `outlined` × 전체 | `color/fill/neutral/transparent-hovered` (`#0000000d`) — 투명 배경 위에 fill 추가, 보더 유지 |
| `ghost` × 전체 | `color/fill/neutral/transparent-hovered` (`#0000000d`) — 투명 배경 위에 fill 추가 |

## 7. Loading Spinner (size별)

> Figma loading variant는 Spinner 컴포넌트(`3380:1591`) 인스턴스를 내장한다.

### Spinner 크기 (size별)

| size | Spinner 인스턴스 size |
|---|---|
| xsmall | 12 |
| small | 12 |
| medium | 12 |
| large | 16 |
| xlarge | 20 |

### Spinner 색 (variant × semantic)

> **원칙: Spinner 색 = 해당 조합의 label(text) 색** (§5 `text/icon` 컬럼과 동일 토큰 — 9개 조합 모두 loading variant의 Spinner export SVG raw 색이 §5 text 색과 일치).

| variant × semantic | Spinner fill | Token | Figma Variable |
|---|---|---|---|
| `filled` × `primary` | label 색 | `textInverse` | `color/text/inverse` |
| `filled` × `secondary` | label 색 | `textNeutral` | `color/text/neutral` |
| `filled` × `destructive` | label 색 | `textAbsoluteWhite` | `color/text/absolute/white` |
| `outlined` × `primary` | label 색 | `textNeutralHeaviest` | `color/text/neutral/heaviest` |
| `outlined` × `secondary` | label 색 | `textNeutralLight` | `color/text/neutral/light` |
| `outlined` × `destructive` | label 색 | `textAccentRed` | `color/text/accent/red` |
| `ghost` × `primary` | label 색 | `textNeutralLight` | `color/text/neutral/light` |
| `ghost` × `secondary` | label 색 | `textNeutralLighter` | `color/text/neutral/lighter` |
| `ghost` × `destructive` | label 색 | `textAccentRed` | `color/text/accent/red` |

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierButton.swift` (`UIControl`, `BezierComponentable`) |
| SwiftUI 구현 | `SUBezierButton.swift` (`View`, `Themeable`) |
| size / variant / semantic 정의 | `BezierButtonSpec.swift` (`BezierButtonSize`, `BezierButtonVariant`, `BezierButtonSemantic`, `BezierButtonConstant`) |

> 코드 측에 본 spec의 SSOT(Figma)와 어긋나는 정의가 존재한다면, 그것은 코드 측의 정리 대상이며 spec에 반영하지 않는다.
>
> pressed 배경의 코드 재현은 `BCSemanticToken.pressedColor`(HSL 계산, 노션 "Pressed/Hover Color" 기획 로직)를 사용한다 (디자인 시스템 합의 — `*-hovered` 시맨틱 토큰은 iOS 미sync). 계산 결과는 §6 표의 raw 값과 일치하며, `filled × secondary` 한 조합만 색상부가 `#0000001e`로 미세하게 다르다 (alpha 12% 무채색 간 차이 — 시각 동등, 기획 로직과 Figma 스냅샷의 계산 차).
