# ConfirmModal Spec

> Figma: [🚧 Mobile Components — ConfirmModal](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=2420-477&m=dev)
> Design spec doc: [ConfirmModal-spec.md](https://github.com/channel-io/design-team/blob/main/specs/components/ConfirmModal-spec.md)
> Linear: [MOB-6343](https://linear.app/channel/issue/MOB-6343/bezierswift-v3-modal-confirmmodal-컴포넌트-구현)

모바일 다이얼로그. 확인·경고·파괴 액션에 사용한다 (Figma component description 1행).

- **모양**: 라운드 사각형 (radius/32 = 32pt), 하방 drop shadow (§3 Effect 참조)
- **구조**: 루트 프레임이 컨테이너 스타일(배경 / radius / shadow / padding)을 직접 보유하고, 내부에 title / description / customContent 슬롯 / 버튼 영역을 세로로 쌓은 구성
- **너비 정책** (Figma description): 너비 = min(화면너비 − 80pt, 480pt). 양쪽 마진 40pt · 상한 480pt. Figma 기준 폭 320pt = 약 400pt 화면 기준 프리뷰

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

### Variant 축

| Property | 값 | 비고 |
|---|---|---|
| **destructive** | `false` / `true` | 기본 `false`. 강조 버튼의 semantic (false → primary / true → destructive) |
| **buttonLayout** | `vertical` / `horizontal` | 버튼 배치 방향. 기본 `horizontal` (2026-07-21 협의 확정 — description의 "vertical(기본)" 표기는 수정 예정) |

### Boolean / Text / Slot property

| Property | 타입 | 기본값 | 비고 |
|---|---|---|---|
| **title** | text | `"Dialog Title"` (placeholder) | 제목 |
| **hasDescription** | boolean | `true` | description 표시 여부 |
| **description** | text | `"Description text goes here."` (placeholder) | 본문 |
| **hasCustomContent** | boolean | `false` | customContent 슬롯 표시 여부 |
| **customContent** | slot (children) | — | title/description 아래·버튼 위에 임의 콘텐츠 삽입 (node 4750:3951) |
| **hasAltAction** | boolean | `false` | vertical 전용 — 강조 버튼과 취소 버튼 사이 보조 액션 버튼 표시 |

- State 축 없음 (ConfirmModal 자체는 default/pressed/disabled/loading 분기가 없다. 버튼 인터랙션은 내장 Button 인스턴스 소관)
- ⚠️ `horizontal` + `hasAltAction=true` 조합 금지 — 3버튼은 항상 vertical (Figma description)

총 instance: `destructive 2 × buttonLayout 2 = 4개`

> **2026-07-21 디자이너 협의 확정 (Figma 반영 예정)** — ConfirmModal-spec.md(team-design)와 Figma 실물 대조에서 발견된 불일치를 디자이너와 협의해 확정한 사항:
> - variant 축 `destructive`는 `type = default | destructive` enum 축으로 전환
> - `showCancel` BOOLEAN(기본 `true`) 추가 — `false`는 취소 없는 1버튼(acknowledge) 케이스, `hasAltAction=false` 조합만 유효
> - `hasCustomContent` / `customContent`는 현행 유지
> - `buttonLayout` 기본값은 `horizontal`
>
> 코드는 이 결정을 선반영한다 (`BezierConfirmModalType`, `cancelAction` optional, 기본 `.horizontal`). Figma 반영 후 §1/§9를 실물 기준으로 재검증한다.

---

## 2. Layout Spec

### 컨테이너 (ConfirmModal 루트 노드에 직접 존재)

| 항목 | 값 |
|---|---|
| Width | 320pt |
| Max Width | 480pt |
| Padding Top | 20pt |
| Padding Bottom | 16pt |
| Padding Horizontal | 16pt |
| Corner Radius | `radius/32` = 32pt |
| Overflow | clip |
| 정렬 | 세로 스택, 가로 center |

### 내부 블록

| 블록 | 값 |
|---|---|
| content (title+description) | 세로 스택, gap 10pt, padding-bottom 8pt, 폭 full, 텍스트 center 정렬, word-break |
| customContent 슬롯 | 폭 full. Figma 마스터에서는 높이 16pt placeholder frame (node 4750:3951) |
| buttons 영역 | padding-top 12pt, 폭 full |
| buttons — `horizontal` | 가로 스택, gap 8pt, 각 버튼 균등 분할 (flex 1) |
| buttons — `vertical` | 세로 스택, gap 10pt, 각 버튼 폭 full |
| 버튼 | Button 컴포넌트 `Size=large` 인스턴스 — 높이 44pt, min-width 44pt |

### 전체 높이 (Figma master, hasDescription=true · customContent/altAction 없음 기준)

| buttonLayout | 높이 |
|---|---|
| `horizontal` | 154pt |
| `vertical` | 208pt |

---

## 3. 컬러 토큰

### 컨테이너

| 대상 | Figma Variable | Raw |
|---|---|---|
| 배경 | `color/surface/higher` | `#FFFFFF` |

### Shadow (Effect)

| 대상 | Figma Style | 구성 |
|---|---|---|
| 컨테이너 그림자 | `Elevation/Mobile/3` | DROP_SHADOW, color `color/elevation/large` (`#00000038`), offset (0, `elevation/4` = 4), blur `elevation/20` = 20, spread 0 |

### 텍스트

| 대상 | Figma Variable | Raw |
|---|---|---|
| title / description | `color/text/neutral` | `#000000D9` |

### 버튼 (내장 Button `Size=large, variant=filled` 인스턴스)

| 역할 | Button semantic | Background | Raw | Foreground | Raw |
|---|---|---|---|---|---|
| 강조 (destructive=false) | `primary` | `color/fill/neutral/heaviest` | `#000000D9` | `color/text/inverse` | `#FFFFFF` |
| 강조 (destructive=true) | `destructive` | `color/fill/accent/red/heavier` | `#E1535D` | `color/text/inverse` | `#FFFFFF` |
| 취소 / Alt Action | `secondary` | `color/fill/neutral` | `#00000014` | `color/text/neutral` | `#000000D9` |

Border 없음.

---

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 | 구성 |
|---|---|---|---|
| title | `headingXSmall` | `Typography/heading/xsmall` | Inter SemiBold, size 16, weight 700, line-height 24, letter-spacing -0.1 |
| description | `textLarge` | `Typography/text/large` | Inter Regular, size 15, weight 400, line-height 20, letter-spacing -0.1 |

### Case B — Custom Typography

없음.

> 버튼 라벨 typography는 내장 Button 인스턴스 내부 텍스트로, Button 컴포넌트 spec이 관할한다.

---

## 5. State 별 시각 동작

ConfirmModal 자체는 state property가 없다. 버튼의 pressed/disabled/loading 시각은 내장 Button 인스턴스가 담당한다.

### 버튼 배치 규칙 (Figma description)

| buttonLayout | 배치 |
|---|---|
| `vertical` | 강조 위 · (Alt Action 중간) · 취소 아래 |
| `horizontal` (기본 — 2026-07-21 협의) | 취소 좌 · 강조 우 (2버튼 전용) |

- 버튼 방향은 라벨 길이 기준 디자이너 수동 선택 (플랫폼 자동 전환 없음)

---

## 6. Loading Indicator

해당 없음 (ConfirmModal 레벨). 버튼 loading은 Button 컴포넌트 소관.

---

## 7. 디자이너 가이드라인 (Figma 컴포넌트 description 인용)

> 모바일 다이얼로그 (BezierDialog). 확인·경고·파괴 액션에 사용한다. \[너비 정책\] 너비 = min(화면너비 − 80px, 480px). 양쪽 마진 40px · 상한 480px. 예) 360px 폰 → 280px / 390px iPhone → 310px / 480px+ → 480px. Figma 기준 폭 320px = 약 400px 화면 기준 프리뷰. \[buttonLayout\] vertical(기본): 강조 위·취소 아래. horizontal: 취소 좌·강조 우 (2버튼 전용). ⚠️ horizontal + hasAltAction=true 조합 금지 — 3버튼은 항상 vertical. 버튼 방향은 라벨 길이 기준 디자이너 수동 선택 (플랫폼 자동 전환 없음). 스펙: Modal-spec.md §11 \[Mobile\]

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 / 심볼 |
|---|---|
| UIKit 구현 | `BezierConfirmModal.swift` *(신설 예정 — V3 컨벤션)* |
| SwiftUI 구현 | `SUBezierConfirmModal.swift` *(신설 예정 — V3 컨벤션)* |
| Layout 상수 정의 | `BezierConfirmModalSpec.swift` *(신설 예정 — V3 컨벤션)* |
| 컨테이너 재사용 | `BezierModal` / `SUBezierModal` (`Sources/BezierSwift/MasterComponent/BezierModal/`) — 협의 사항: ConfirmModal이 Modal 컨테이너를 재사용 (BezierModal SPEC §8) |
| 버튼 재사용 | `BezierButton` / `SUBezierButton` — `BezierButtonSize.large`, `BezierButtonVariant.filled`, `BezierButtonSemantic.primary` / `.secondary` / `.destructive` (`BezierButtonSpec.swift`, 버튼 spec: `Sources/BezierSwift/MasterComponent/BezierButton/SPEC.md`) |
| Typography 토큰 | `BTSemanticToken.headingXSmall`, `BTSemanticToken.textLarge(weight: .regular)` (`Sources/BezierSwift/Foundation/Typography/V3/BTSemanticToken.swift`) |
| 텍스트 컬러 토큰 | `BCSemanticToken.textNeutral` (`Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift`) |

> 코드 측에 본 spec의 SSOT(Figma)와 어긋나는 정의가 존재한다면, 그것은 코드 측의 정리 대상이며 spec에 반영하지 않는다.

---

## 9. Variant 매트릭스

총 instance: destructive 2 × buttonLayout 2 = **4개**

```text
destructive=false, buttonLayout=horizontal = 4858:114
destructive=true,  buttonLayout=horizontal = 4858:123
destructive=false, buttonLayout=vertical   = 4750:3947
destructive=true,  buttonLayout=vertical   = 4750:3956
```
