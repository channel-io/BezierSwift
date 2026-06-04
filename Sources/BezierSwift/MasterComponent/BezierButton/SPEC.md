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

## 2. Component Properties (Figma variant 축)

| 축 | 값 | 비고 |
|---|---|---|
| `size` | `xsmall`, `small`, `medium`, `large`, `xlarge` | 5 옵션 |
| `variant` | `filled`, `outlined`, `ghost` | 3 옵션 |
| `semantic` | `primary`, `secondary`, `destructive` | 3 옵션 |
| `state` | `default`, `pressed`, `active`, `disabled`, `loading` | **Figma 설계용 축** — 시각 검토 목적, 런타임 API로 노출하지 않는다. |

Figma 매트릭스 총량: 5 × 3 × 3 × 5 = **225 symbols** (전부 실재).

### 2-1. State 축의 해석

Figma 컴포넌트 설명에 명시:
> "state 축: Figma 설계용 — disabled/loading/pressed 상태별 시각 확인에 사용"

따라서 코드는 다음 런타임 상태만 노출한다:

| 코드 상태 | Figma state 매핑 |
|---|---|
| `isEnabled = true`, 정상 | `default` |
| `isHighlighted = true` (터치 중) | `pressed` |
| `isEnabled = false` | `disabled` |
| `isLoading = true` | `loading` |
| (없음) | `active` — 토글/선택 상태를 위한 설계용. Button 컴포넌트는 sticky-toggled 상태를 노출하지 않는다. |

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
- **icon**: leadingIcon / trailingIcon은 텍스트 좌우에 배치, 16×16 고정.

## 4. Typography (size별, Custom)

> **Typography 적용 방식: Custom (Token 미적용)**.
> Figma Button 텍스트 노드는 Foundation의 typography token(`Typography/heading/*` text style 또는 `heading/size/*` / `heading/line-height/*` variable)에 연결되어 있지 않다. 5개 size 모두 `get_variable_defs` 결과가 `label/font-family` (= `"Inter"`) + `label/letter-spacing` (= `0`)만 노출하며, font-size 와 line-height 는 raw 값으로 직접 적용되어 있다.
>
> **Custom 사유**: Figma Mobile Components Button(`1734:146`)이 typography token 매핑을 보유하고 있지 않은 상태. (디자이너 의도 — 디자인 시스템 typography token 매핑은 별도 진행 예정으로 추정되며, 현 시점 Button 의 SSOT 는 raw 값 자체.)

공통값 (5 size 동일):
- `font-family`: `Inter` (variable: `label/font-family`)
- `font-weight`: `SemiBold` (600)
- `letter-spacing`: `0` (variable: `label/letter-spacing`)

size 별 raw 값:

| size | fontSize | lineHeight |
|---|---|---|
| xsmall | 13 | 18 |
| small | 14 | 18 |
| medium | 15 | 20 |
| large | 16 | 20 |
| xlarge | 16 | 20 |

> ⚠️ iOS BezierSwift V3 Typography는 regular/bold 이진 weight 시스템(`BTFontWeight`)을 사용한다. Figma SemiBold(600)는 iOS에서 `bold`로 매핑된다 (디자인 시스템 합의 사항).

## 5. Color (variant × semantic × variant 별, default state)

> 키는 Figma variable 경로. 괄호 안은 raw 값.

| variant × semantic | background | text/icon | border |
|---|---|---|---|
| `filled` × `primary` | `color/fill/neutral/heaviest` (`#000000d9`) | `color/text/inverse` (`#ffffff`) | — |
| `filled` × `secondary` | `color/fill/neutral/light` (`#0000000d`) | `color/text/neutral` (`#000000d9`) | — |
| `filled` × `destructive` | `color/fill/accent/red/heavier` (`#e1535d`) | `color/text/inverse` (`#ffffff`) | — |
| `outlined` × `primary` | — | `color/text/neutral/heaviest` (`#000000`) | `color/border/neutral` (`#00000014`) |
| `outlined` × `secondary` | — | `color/text/neutral/light` (`#00000099`) | `color/border/neutral` (`#00000014`) |
| `outlined` × `destructive` | — | `color/text/accent/red` (`#e1535d`) | `color/border/neutral` (`#00000014`) |
| `ghost` × `primary` | — | `color/text/neutral/light` (`#00000099`) | — |
| `ghost` × `secondary` | — | `color/text/neutral/lighter` (`#00000066`) | — |
| `ghost` × `destructive` | — | `color/text/accent/red` (`#e1535d`) | — |

- **border-width**: outlined 1px (모든 size 공통).
- **outlined / ghost** variant는 background fill 없음 (clear).

## 6. State 별 시각 동작

> `pressed` / `active` 시각은 Figma SSOT에 별도 컬러 토큰이 없고 opacity 기반으로 표현된다.

| state | 시각 처리 |
|---|---|
| `default` | 위 §5 색상 그대로 |
| `pressed` | 본체 opacity를 낮춤 (터치 중에만 일시적) |
| `active` | 코드 미노출 (Button은 토글 상태를 가지지 않음) |
| `disabled` | 본체 전체 `opacity: 0.4` (Figma `opacity-40` 일치) |
| `loading` | 라벨/아이콘 숨김 + 가운데 Spinner 컴포넌트 인스턴스 표시. 사용자 입력 무시 |

## 7. Loading Spinner (size별)

> Figma loading variant는 Spinner 컴포넌트(`3380:1591`) 인스턴스를 내장한다.

| size | Spinner 인스턴스 size |
|---|---|
| xsmall | 12 |
| small | 16 |
| medium | 20 |
| large | 24 |
| xlarge | 30 |

### Spinner 색 (variant별, semantic 무관 — Figma 인스턴스 색 override)

| variant | Ellipse fill | 바인딩 |
|---|---|---|
| `filled` | white @ 0.7 | raw (변수 미바인딩) |
| `outlined` / `ghost` | black @ 0.08 | raw (변수 미바인딩) |

> 협의 사항: `outlined`/`ghost`의 black@0.08은 `color/border/neutral` light raw와 동일값이므로 구현은 Spinner 기본색(`borderNeutral` 토큰)을 그대로 사용한다. `filled`의 white@0.7은 대응 토큰이 없어 raw로 적용한다.
