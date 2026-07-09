# BezierIconButton Spec

> Figma: [🚧 Mobile Components / IconButton](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/?node-id=1735-442)
> Design spec: [bezier-v3/component-spec/IconButton-spec.md](https://github.com/channel-io/design-team/blob/main/docs/bezier-v3/component-spec/IconButton-spec.md)

아이콘만으로 액션을 표현하는 원형 버튼. 텍스트 레이블이 필요한 경우 `BezierButton` 사용.

- **모양**: 원형 (`cornerRadius = length / 2`)
- **Accessibility**: `accessibilityLabel` 필수
- **인접 배치**: 같은 variant로 통일 (예: ghost ↔ ghost / filled ↔ filled)

---

## 1. Component Properties (4축 구조)

Figma 컴포넌트가 정의하는 property와 옵션은 다음 4개가 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **Size** | `xsmall` / `small` / `medium` / `large` | 컨테이너 크기 결정 |
| **variant** | `filled` / `outlined` / `ghost` | 배경/보더 스타일 |
| **semantic** | `primary` / `secondary` / `destructive` | 액션 위계·색 톤 |
| **state** | `default` / `pressed` / `active` / `disabled` / `loading` | 상호작용 상태 |

총 instance: `4 × 3 × 3 × 5 = 180개` (Mobile Figma CS `1735:442` 노출 인스턴스 수와 일치)

---

## 2. Size 별 Spec

| Size | Length (W=H) | Padding | Icon Length | Spinner (loading) |
|---|---|---|---|---|
| `xsmall` | **20pt** | 2pt | 16pt | 12pt |
| `small`  | **24pt** | 4pt | 16pt | 16pt |
| `medium` | **32pt** | 6pt | 20pt | 20pt |
| `large`  | **44pt** | 12pt | 20pt | 24pt |

- `iconLength = length - padding × 2`
- `cornerRadius = length / 2` (완전 원형)
- 모든 사이즈에서 `min-width = length` (contents에 의해 줄어들지 않음)

---

## 3. variant × semantic 컬러 매트릭스

색은 `variant`(3) × `semantic`(3) = 9조합으로 결정된다. 아이콘 색과 Loading Spinner 색은 동일하다(§6).

| variant × semantic | Background | Border | Icon (= Spinner) |
|---|---|---|---|
| `filled` × `primary` | `fillNeutralHeaviest` (`#000000D9`) | — | `iconInverseHeavier` (`#FFFFFF`) |
| `filled` × `secondary` | `fillNeutral` (`#00000014`) | — | `iconNeutralHeavy` (`#00000099`) |
| `filled` × `destructive` | `fillAccentRedHeavier` (`#E1535D`) | — | `iconInverseHeavier` (`#FFFFFF`) |
| `outlined` × `primary` | — | `borderNeutral` (`#00000014`) | `iconNeutralHeavier` (`#000000D9`) |
| `outlined` × `secondary` | — | `borderNeutral` (`#00000014`) | `iconNeutral` (`#00000066`) |
| `outlined` × `destructive` | — | `borderNeutral` (`#00000014`) | `textAccentRed` (`#E1535D`) |
| `ghost` × `primary` | — | — | `iconNeutralHeavier` (`#000000D9`) |
| `ghost` × `secondary` | — | — | `iconNeutral` (`#00000066`) |
| `ghost` × `destructive` | — | — | `textAccentRed` (`#E1535D`) |

- **border-width**: `outlined` 1pt (모든 size 공통).
- `outlined` / `ghost`는 배경 fill 없음(clear).
- `destructive` 아이콘은 `textAccentRed`를 사용한다 (값 `#E1535D`로 `iconAccentRed`와 동일 — Button과 토큰 통일).

---

## 4. Typography

이 컴포넌트에 텍스트 없음 — IconButton은 아이콘만 표시한다. 텍스트 레이블이 필요한 경우 `BezierButton`을 사용한다.

---

## 5. State 별 시각 동작

pressed/active 처리는 배경 유무로 갈린다. **배경 없는 variant**(`outlined` / `ghost`)와 **배경 있는 variant**(`filled`)로 나눈다.

| State | 배경 없는 variant (outlined/ghost) | 배경 있는 variant (filled) | 인터랙션 |
|---|---|---|---|
| `default` | 기본 (배경 없음) | 기본 (§3 배경) | 활성 |
| `pressed` | 배경 `rgba(0,0,0,0.05)` 오버레이 *(임시)* | **default와 동일** *(추가 변경 없음)* | 활성 |
| `active`  | 배경 `rgba(0,0,0,0.05)` 오버레이 *(임시)* | **default와 동일** *(추가 변경 없음)* | 토글 ON 상태 표현 |
| `disabled` | opacity **0.4** | opacity **0.4** | 비활성 (`isEnabled = false`) |
| `loading`  | 아이콘 숨김 + spinner 표시 *(배경은 default와 동일)* | 아이콘 숨김 + spinner 표시 *(배경은 default와 동일)* | 비활성 (사용자 입력 차단) |

> ⚠️ **HOVER-MIGRATION**: 배경 없는 variant(`outlined` / `ghost`)의 `pressed` / `active` 오버레이 색상은 현재 `bezier-tokens`에 공식 등록되지 않아 raw `rgba(0,0,0,0.05)`를 사용한다. Figma는 `fill/neutral-hovered` 등 hovered 토큰을 정의하나, 정식 반영은 후속 이슈로 미룬다. 토큰 등록 시 Variable로 일괄 교체 예정.
>
> ℹ️ `filled` variant는 `default = pressed = active = loading` 모두 동일한 배경(§3)을 사용하며, **상호작용에 따른 추가 overlay가 적용되지 않는다**.

### State 별 구현 가이드

- `filled`의 `pressed` / `active`: 추가 overlay 없음 — `default`와 동일하게 렌더링
- `disabled`: opacity `0.4` 적용
- `loading`: Spinner 컴포넌트 (UIKit: `BezierSpinner` / SwiftUI: `SUBezierSpinner`) 사용. 크기는 §6의 Spinner 값에 맞춰 적용

---

## 6. Loading Indicator

> Figma loading variant는 Spinner 컴포넌트(`3380:1591`) 인스턴스를 내장한다 (8셀 전수 확인).
> 색상·크기는 MOB-5322에서 디자인팀이 확정한 정책(design-team `IconButton-spec.md §6` / `Spinner-spec.md`)을 반영한다.

| Size | Spinner 인스턴스 size | 배치 |
|---|---|---|
| `xsmall` | 12pt | 컨테이너 중앙, 아이콘 자리를 invisible 처리 후 absolute 중앙 정렬 |
| `small`  | 12pt | 동일 |
| `medium` | 12pt | 동일 |
| `large`  | 16pt | 동일 |

### Spinner 색상 (variant × semantic)

> **원칙**: **모든 조합에서 Spinner 색 = 해당 조합의 아이콘 색**(§3 Icon 컬럼). 텍스트 라벨이 없으므로 아이콘 색을 그대로 따른다.

| variant × semantic | Spinner fill |
|---|---|
| `filled` × `primary` / `destructive` | `iconInverseHeavier` |
| `filled` × `secondary` | `iconNeutralHeavy` |
| `outlined` / `ghost` × `primary` | `iconNeutralHeavier` |
| `outlined` / `ghost` × `secondary` | `iconNeutral` |
| `outlined` / `ghost` × `destructive` | `textAccentRed` |

- 코드에서는 `loadingSpinnerToken(semantic)`이 `foregroundToken(semantic)`을 그대로 위임한다.

### 기타
- Loading 시에도 컨테이너 자체 사이즈는 유지 (layout shift 없음)
- Filled 배경은 그대로 유지, Ghost는 배경 없음 유지

> Spinner 색은 GitHub design-team `IconButton-spec.md §6`(v1.2, "Spinner 색 = 아이콘 색" 원칙)과 일치한다. 크기(§6 표)는 MOB-5322에서 확정한 값을 유지한다.

---

## 7. 디자이너 가이드라인 (Figma 컴포넌트 노트)

- **ghost** — 기본값. 투명 배경 위 보조 액션 (닫기, 더보기, 편집, 뒤로가기 등)
- **outlined** — 테두리로 구분되는 보조 액션. filled와 함께 쓰거나 목록·행 인라인 액션에 사용
- **filled** — 배경 구분이 필요한 맥락 (카드 위, 미디어 오버레이)
- **semantic** — `primary`(강조/진한 톤) / `secondary`(중립/연한 톤) / `destructive`(위험/붉은 톤)
- **size 가이드**: large(44px) / medium(32px) / small(24px) / xsmall(20px)
- **state 축**은 Figma 설계용 — disabled/loading/pressed 시각 확인 용도
- 텍스트 레이블이 필요하면 `BezierButton` 사용
- 인접 배치 시 동일 variant로 통일

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierIconButton.swift` |
| SwiftUI 구현 | `SUBezierIconButton.swift` |
| size / variant 정의 | `BezierIconButtonSpec.swift` |

> 코드 측에 본 spec의 SSOT(Figma)와 어긋나는 정의가 존재한다면, 그것은 코드 측의 정리 대상이며 spec에 반영하지 않는다.

---

## 9. Variant 매트릭스

총 instance: 4 sizes × 3 variants × 3 semantics × 5 states = **180개** (Mobile Figma CS `1735:442`, Button Figma CS와 동일한 semantic×variant 구조).
