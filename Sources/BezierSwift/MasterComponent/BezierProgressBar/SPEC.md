# BezierProgressBar SPEC

> **SSOT**: [Figma · Mobile-Components / ProgressBar (3413:10)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=3413-10)
> **Design spec doc**: [team-design / bezier-v3 / components / ProgressBar-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/ProgressBar-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

작업의 진행률을 0~100% 범위의 색상 바로 시각화하는 컴포넌트 (Figma component description 1행).

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **variant** | `default` / `overlaid` | 트랙(배경) 색 결정. 진행 바 색은 공통 |
| **size** | `medium` / `small` | 바 높이·corner radius 결정 |

총 instance: variant 2 × size 2 = **4개**

## 2. Size 별 Spec

| Size | 높이 | Corner Radius |
|---|---|---|
| `medium` | 6pt | 3pt |
| `small` | 4pt | 2pt |

- 진행 바(ProgressBarActive)는 트랙과 동일한 높이·corner radius, 좌측 정렬.
- 진행 바 width = 진행률 × 트랙 width (Figma 심볼은 left: 0 / right: 40% — 60% 진행 샘플).
- Figma 심볼의 트랙 width는 240pt (캔버스 배치 샘플 값).

## 3. Variant 별 컬러 토큰

### 트랙 (배경)

| Variant | Token | Figma Variable | Raw (light) |
|---|---|---|---|
| `default` | `fillNeutralHeavy` | `color/fill/neutral/heavy` | `#00000026` |
| `overlaid` | `fillGreyHeavier` | `color/fill/grey/heavier` | `#EFEFF0` |

### 진행 바 (ProgressBarActive)

| Variant | Token | Figma Variable | Raw (light) |
|---|---|---|---|
| `default` / `overlaid` 공통 | `fillNeutralHeaviest` | `color/fill/neutral/heaviest` | `#000000D9` |

## 4. Typography

이 컴포넌트에 텍스트 없음.

## 5. State 별 시각 동작

Figma CS에 state variant 축 없음 (인터랙션 없는 표시 전용 컴포넌트). 진행률 값에 따라 진행 바 width만 변한다.

| 진행률 | 시각 |
|---|---|
| 0 | 진행 바 width 0 (트랙만 표시) |
| 0 < value < 1 | 진행 바 width = value × 트랙 width |
| 1 | 진행 바가 트랙 전체를 채움 |

## 6. 디자이너 가이드라인 (Figma component description 인용)

- 작업의 진행률을 0~100% 범위의 색상 바로 시각화하는 컴포넌트.
- variant: default(일반 배경 위) / overlaid(콘텐츠 위 겹침 — 불투명 흰 배경) — (컬러 실측: overlaid 트랙은 현재 `color/fill/grey/heavier` 바인딩)
- size: medium(6px, 기본) / small(4px)
- 진행률을 모르면 Spinner 사용. 단계 위치 표시는 Step indicator(커스텀) 사용.
- 캔버스 노트 (4781:12747): "진행 단계별 애니메이션 정의 필요함" — 진행 애니메이션은 Figma에 미정의.

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierProgressBar.swift` |
| SwiftUI 구현 | `SUBezierProgressBar.swift` |
| variant / size / constant 정의 | `BezierProgressBarSpec.swift` |

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **진행률 값 API**: `value: CGFloat`, 0~1 범위로 clamp (0 미만 → 0, 1 초과 → 1). web(bezier-react)의 0~1 float 관례를 따른다 (android는 0~100 int — 플랫폼별 상이).
2. **너비**: 배치는 컨테이너 책임 — public width/resizing/isFullWidth API를 제공하지 않는다. UIKit은 intrinsic width 없음(높이만 intrinsic), SwiftUI는 부모가 제안한 폭을 그대로 채운다. Figma 심볼의 240pt는 캔버스 샘플 값.
3. **진행 애니메이션**: Figma 미정의 (캔버스 노트 "진행 단계별 애니메이션 정의 필요함"). value 변경 시 UIKit `UIView.animate`(0.3s, easeInOut) / SwiftUI `.animation(.easeInOut(duration: 0.3), value:)`로 width 전환. Reduce Motion 활성 시 애니메이션 생략. 디자인 확정 시 값 교체 대상.
4. **트랙 색 alpha**: `fillNeutralHeavy` 등 fill 토큰은 alpha 내장 — 추가 opacity 곱 금지.

## 9. Variant 매트릭스

총 instance: 2 × 2 = **4개**

```text
variant=default,  size=medium = 3413:2
variant=overlaid, size=medium = 3413:4
variant=default,  size=small  = 3413:6
variant=overlaid, size=small  = 3413:8
```
