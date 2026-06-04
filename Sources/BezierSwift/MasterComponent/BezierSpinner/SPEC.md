# BezierSpinner Spec

> Figma: [🚧 Mobile Components — Spinner](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=3380-1591)
> Design spec doc: [design-team/specs/components/Spinner-spec.md](https://github.com/channel-io/design-team/blob/main/specs/components/Spinner-spec.md)

진행률을 알 수 없는 로딩 상태를 회전 애니메이션으로 표시하는 인디케이터 컴포넌트.

- **모양**: 도넛 호(donut arc). 270° 호 + 하단 중앙 90° gap. stroke가 아닌 fill 기반 도넛 호.
- **Accessibility**: 디자이너 가이드라인 §7 참조 (텍스트/라벨 없음 — 컨테이너 측 라벨링 책임).
- **인접 배치**: 진행률(0~100%)을 알면 ProgressBar, 콘텐츠 첫 로드는 Skeleton 사용 (Figma description).

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **size** | `12` / `16` / `20` / `24` / `30` / `36` / `42` / `48` | 8단계 (숫자 = pt 크기, Figma `sourceSize` 토큰 대응) |

총 instance: `8 size = 8개` (Figma 노출 인스턴스 수와 일치)

---

## 2. Size 별 Layout

| Size | Length (W=H) | Ring 두께 | Inner Radius |
|---|---|---|---|
| `size12` | 12pt | 1.5pt  | 4.5pt   |
| `size16` | 16pt | 2pt    | 6pt     |
| `size20` | 20pt | 2.5pt  | 7.5pt   |
| `size24` | 24pt | 3pt    | 9pt     |
| `size30` | 30pt | 3.75pt | 11.25pt |
| `size36` | 36pt | 4.5pt  | 13.5pt  |
| `size42` | 42pt | 5.25pt | 15.75pt |
| `size48` | 48pt | 6pt    | 18pt    |

- **Ring 두께**: `length × 0.125` (전 size 공통 비율 — Figma SVG path에서 전수 역산 확인).
- **Inner radius**: `outer radius × 0.75` (= `length / 2 × 0.75`).
- **호 형태**: 270° 도넛 호. gap 90°는 하단 중앙(6시 방향) 기준 ±45° 구간. 호의 양 끝은 평면 컷(라운드 캡 아님 — Figma SVG path가 직선 모서리로 끝남).
- 컨테이너 length는 정사각 (W=H). 호의 bounding box는 컨테이너 안에서 상단 정렬 (하단 14.64% 영역은 gap).

---

## 3. Color 토큰

### 호(arc) Fill

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| 도넛 호 fill | `borderNeutral` | `color/border/neutral` | `#00000014` (black @ 8%) |

- 전 size 공통 단일 컬러. Figma 매트릭스에 색상 축 없음.
- stroke 없음 — fill 기반 도넛 호 (Figma SVG `fill-opacity="0.08"`).

---

## 4. Typography

이 컴포넌트에 텍스트 없음.

---

## 5. State

해당 없음. Spinner는 state property를 갖지 않음 (Figma 매트릭스 축은 size 단일). 인터랙티브 요소 아님.

---

## 6. 회전 애니메이션 (협의 사항 — Figma SSOT 외)

Figma에 애니메이션 스펙이 정의되어 있지 않다. Figma description이 링크한 design spec doc(§6 Token Map / §7 Behavior)의 정의를 협의 사항으로 채택한다:

> 애니메이션: 1초 linear infinite 회전

- 회전 주기 **1초**, **linear** easing, **무한 반복**, 시계 방향.
- 회전 대상은 도넛 호 전체 (컨테이너 기준 중심축 회전).
- 이 항목은 Figma SSOT가 아니므로, 추후 Figma에 모션 스펙이 정의되면 그쪽이 우선한다.

---

## 7. 디자이너 가이드라인 (Figma component description 인용)

> 진행률을 알 수 없는 로딩 상태를 회전 애니메이션으로 표시하는 인디케이터 컴포넌트.
> - size: 12 / 16 / 20 / 24 / 30 / 36 / 42 / 48 (숫자 = px 크기, sourceSize 토큰 대응)
> - 진행률(0~100%)을 알면 ProgressBar 사용. 콘텐츠 첫 로드는 Skeleton 사용.

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierSpinner.swift` |
| SwiftUI 구현 | `SUBezierSpinner.swift` |
| Size enum + 정수 spec | `BezierSpinnerSpec.swift` |
| 호 컬러 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` — `borderNeutral` |

---

## 9. Variant 매트릭스

총 instance: `8 size = 8개`

```text
size=12 = 3380:1581
size=16 = 3380:1583
size=20 = 3380:1585
size=24 = 3380:1587
size=30 = 3400:2
size=36 = 3400:4
size=42 = 3400:6
size=48 = 3380:1589
```
