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
| **variant** | `ghost` / `filled` | 배경 유무 |
| **semantic** | `secondary` | **단일 값** — 현재 IconButton은 `secondary` 외 semantic을 정의하지 않는다 |
| **state** | `default` / `pressed` / `active` / `disabled` / `loading` | 상호작용 상태 |

총 instance: `4 × 2 × 1 × 5 = 40개` (Figma 노출 인스턴스 수와 일치)

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

## 3. Variant 별 컬러 토큰

`semantic = secondary` 단일 값이므로 매트릭스는 variant 축만으로 결정된다.

### Background (배경)

| Variant | Background | Figma Variable | Raw |
|---|---|---|---|
| `filled` | `fillNeutralLight` | `color/fill/neutral/light` | `#0000000D` (5% black) |
| `ghost`  | — *(transparent)* | — | — |

### Foreground (아이콘 색)

| Variant | Foreground | Figma Variable | Raw |
|---|---|---|---|
| `filled` | `iconNeutralHeavy` | `color/icon/neutral/heavy` | `#00000099` (60% black) |
| `ghost`  | `iconNeutral` | `color/icon/neutral` | `#00000066` (40% black) |

---

## 4. Typography

이 컴포넌트에 텍스트 없음 — IconButton은 아이콘만 표시한다. 텍스트 레이블이 필요한 경우 `BezierButton`을 사용한다.

---

## 5. State 별 시각 동작

| State | Ghost 변경점 | Filled 변경점 | 인터랙션 |
|---|---|---|---|
| `default` | 기본 (배경 없음) | 기본 (배경 `fillNeutralLight`) | 활성 |
| `pressed` | 배경 `rgba(0,0,0,0.05)` 오버레이 *(임시)* | **default와 동일** *(추가 변경 없음)* | 활성 |
| `active`  | 배경 `rgba(0,0,0,0.05)` 오버레이 *(임시)* | **default와 동일** *(추가 변경 없음)* | 토글 ON 상태 표현 |
| `disabled` | opacity **0.4** | opacity **0.4** | 비활성 (`isEnabled = false`) |
| `loading`  | 아이콘 숨김 + spinner 표시 *(배경은 default와 동일)* | 아이콘 숨김 + spinner 표시 *(배경은 default와 동일)* | 비활성 (사용자 입력 차단) |

> ⚠️ **HOVER-MIGRATION**: `ghost` variant의 `pressed` / `active` 오버레이 색상은 현재 `bezier-tokens`에 공식 등록되지 않아 raw `rgba(0,0,0,0.05)`를 사용한다. 토큰 등록 시 Variable로 일괄 교체 예정.
>
> ℹ️ `filled` variant는 Figma상 `default = pressed = active = loading` 모두 동일한 배경(`fillNeutralLight`)을 사용하며, **상호작용에 따른 추가 overlay가 적용되지 않는다**.

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

### Spinner 색상 (variant별)

| Variant | Spinner fill | Token | Figma Variable |
|---|---|---|---|
| `filled` | `fillBright` | `fillBright` | `color/fill/bright` |
| `ghost`  | icon 색 | `iconNeutral` | `color/icon/neutral` |

- `filled`: `color/fill/bright` (배경 `fillNeutralLight` 위 대비). 아이콘 색(`iconNeutralHeavy`)과는 다른 토큰.
- `ghost`: `color/icon/neutral` — ghost의 default 아이콘 색(`foregroundToken`)을 그대로 사용한다.

### 기타
- Loading 시에도 컨테이너 자체 사이즈는 유지 (layout shift 없음)
- Filled 배경은 그대로 유지, Ghost는 배경 없음 유지

> 협의 사항(MOB-5322 / Figma SSOT 외): 위 색·크기는 팀챗 스레드에서 확정해 design-team spec 문서에 반영된 정책이며, 현 시점 Figma loading 인스턴스의 기본색(borderNeutral) override 없음 상태보다 우선한다. 추후 Figma 인스턴스가 갱신되면 그쪽이 SSOT가 된다.

---

## 7. 디자이너 가이드라인 (Figma 컴포넌트 노트)

- **ghost** — 기본값. 투명 배경 위 보조 액션 (닫기, 더보기, 편집, 뒤로가기 등)
- **filled** — 배경 구분이 필요한 맥락 (카드 위, 미디어 오버레이)
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

총 instance: 4 sizes × 2 variants × 5 states = **40개**

```text
Size   x variant x state        = Node
─────────────────────────────────────────────────
xsmall x ghost   x default      = 1735:347
xsmall x ghost   x pressed      = 2534:724
xsmall x ghost   x active       = 2534:796
xsmall x ghost   x disabled     = 2534:868
xsmall x ghost   x loading      = 2534:940
xsmall x filled  x default      = 2635:1665
... (동일 패턴으로 small / medium / large 각각 10개씩)
```
