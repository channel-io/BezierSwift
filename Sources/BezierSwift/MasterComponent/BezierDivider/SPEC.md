# BezierDivider Spec

> Figma: [🚧 Mobile Components — Divider](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=3353-9)
> Design spec doc: [team-design/bezier-v3/components/Divider-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Divider-spec.md)

콘텐츠 그룹 사이를 시각적으로 분리하거나 묶음을 표시하는 1px 구분선.

- **모양**: 수평 직선(1pt 두께). 라인은 부모 너비를 채운다.
- **인접 배치**: 항목 하나하나 사이가 아닌, 의미가 다른 그룹 사이에만 사용. 단순 간격 조정이 아닌 구분 표시 용도 (Figma description).

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **orientation** | `horizontal` | 단일값. Figma description: "horizontal만 지원 (vertical은 web 전용, Mobile 미지원)" |
| **sideIndent** | `Bool` (기본 `true`) | 좌우 6pt 여백 (`_spacer-left` + `_spacer-right`) |
| **parallelIndent** | `Bool` (기본 `true`) | 상하 6pt 여백 (`_spacer-top` + `_spacer-bottom`) |

> Figma `orientation` property에는 임시 탐색용 값 `(임시) 0.5`(0.5pt 라인, node 5386:13234)가 함께 존재하나, description "horizontal만 지원" + `(임시)` 마커에 따라 지원 spec/구현에서 제외한다.

`sideIndent` / `parallelIndent`는 각각 기본 `true`인 BOOLEAN prop → 지원 조합 = `horizontal 1 × sideIndent 2 × parallelIndent 2 = 4`.

---

## 2. Layout (고정 수치)

Divider는 size axis가 없다. 고정 수치만 존재한다.

| 항목 | 값 |
|---|---|
| Line thickness (height) | `1pt` |
| sideIndent padding (좌/우) | `6pt` (기본) · sideIndent=false 시 `0` |
| parallelIndent padding (상/하) | `6pt` (기본) · parallelIndent=false 시 `0` |
| Line width | 부모 너비 채움 (min-width `1pt`) |
| corner radius | `0` |

- 컨테이너 height = `lineThickness + (parallelIndent ? 2 × 6 : 0)` = 기본 `13pt`, parallelIndent=false 시 `1pt`.
- 라인은 컨테이너 세로 중앙에 배치. indent 영역(spacer)은 투명.

---

## 3. Color 토큰

### Line (background)

| 위치 | Token | Figma Variable | Raw (light) |
|---|---|---|---|
| 라인 fill | `borderNeutral` | `color/border/neutral` | `#00000014` (black @ 8%) |

- `color/border/neutral`은 모드별 동적 변수 — 위 raw는 light 해석값. 다크 모드 값은 토큰이 해석한다.
- 단일 컬러. state·variant별 컬러 분기 없음. spacer(indent) 영역은 투명.

---

## 4. Typography

이 컴포넌트에 텍스트 없음.

---

## 5. State

해당 없음. Divider는 state property를 갖지 않음 (순수 시각적 구분선, 인터랙션 없음).

---

## 6. 디자이너 가이드라인 (Figma component description 인용)

> 콘텐츠 그룹 사이를 시각적으로 분리하거나 묶음을 표시하는 1px 구분선.
> - sideIndent (기본 true): 좌우 6px 여백
> - parallelIndent (기본 true): 상하 6px 여백
> - orientation: horizontal만 지원 (vertical은 web 전용, Mobile 미지원)
> - 항목 하나하나 사이가 아닌, 의미가 다른 그룹 사이에만 사용. 단순 간격 조정이 아닌 구분 표시 용도.

---

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierDivider.swift` |
| SwiftUI 구현 | `SUBezierDivider.swift` |
| 상수 (thickness / indent) | `BezierDividerSpec.swift` — `BezierDividerConstant` |
| 라인 컬러 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` — `borderNeutral` |

---

## 8. Variant 매트릭스

지원 조합: `horizontal 1 × sideIndent 2 × parallelIndent 2 = 4개`

```text
orientation=horizontal · sideIndent=true  · parallelIndent=true   (기본; Figma 3353:2)
orientation=horizontal · sideIndent=false · parallelIndent=true
orientation=horizontal · sideIndent=true  · parallelIndent=false
orientation=horizontal · sideIndent=false · parallelIndent=false

(임시) 0.5 = 5386:13234  ← 임시 탐색 변형(0.5pt line), 지원 제외
```
