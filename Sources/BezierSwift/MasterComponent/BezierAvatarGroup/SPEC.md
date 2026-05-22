# BezierAvatarGroup Spec

> Figma: [🚧 Mobile Components — AvatarGroup](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1088-38)
> Design spec doc: [design-team/specs/components/AvatarGroup-spec.md](https://github.com/channel-io/design-team/blob/main/specs/components/AvatarGroup-spec.md)

복수의 Avatar를 겹쳐 표시하고 초과분을 ellipsis 인디케이터로 나타내는 그룹 컴포넌트.

- **모양**: 좌측부터 우측으로 Avatar가 일정 stride로 겹쳐 배치되며, 마지막 슬롯이 ellipsis (overflow) 인디케이터.
- **사용처 가이드**:
  - `size=20`: 텍스트 인라인 보조 — 타이핑 인디케이터, 레퍼런스
  - `size=24`: 리스트·카드·패널 표준 — 담당자, 팔로워, 참여자
  - `ellipsisType=icon`: 초과 인원 수가 비중요할 때 (3-dot more 아이콘으로 표시)
  - `ellipsisType=count`: 초과 인원 수 파악이 중요할 때 (`+N` 텍스트로 표시)
- **Children 제약**: BezierAvatar 컴포넌트만 사용.

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **size** | `20` / `24` | 그룹 내 모든 Avatar에 일괄 적용 |
| **ellipsisType** | `icon` / `count` | 마지막 슬롯의 overflow 표현 방식 |
| **moreText** | string | `count` 일 때 노출되는 `+N` 텍스트 (Figma preview = `+2`) |

총 Figma instance: `2 size × 2 ellipsisType = 4개`

| Node ID | size | ellipsisType | Frame |
|---|---|---|---|
| `2695:62` | 20 | icon | 59 × 20 |
| `2695:39` | 20 | count | 66 × 20 |
| `2693:15` | 24 | icon | 75 × 24 |
| `1087:3` | 24 | count | 81 × 24 |

---

## 2. Size 별 Layout

### 2.1. 공통 — Avatar instance

각 슬롯의 Avatar는 다음 BezierAvatar property로 렌더링된다.

| Spec | 값 |
|---|---|
| `size` | `20` 또는 `24` (그룹 size 그대로 전달) |
| `cornerRadius` | size × 0.42 (BezierAvatar SPEC 준수) — `20 → 8.4`, `24 → 10.08` |
| `borderWidth` (showBorder=true 일 때) | `20 → 1pt`, `24 → 1.5pt` (BezierAvatar SPEC 준수) |

### 2.2. `size=20`, `ellipsisType=icon` (frame 59 × 20)

| Index | 슬롯 | left | size | 외곽 border |
|---|---|---|---|---|
| 0 | avatar | 0 | 20 × 20 | 없음 |
| 1 | avatar | 13 | 20 × 20 | 없음 |
| 2 | avatar | 26 | 20 × 20 | 없음 |
| 3 | ellipsis avatar (image + overlay + more icon + border outline) | 39 | 20 × 20 | **있음** (`1pt`, overlay 위 outline §5) |

- **Stride**: `13pt` (각 avatar 사이 7pt overlap).
- **Total width**: `39 + 20 = 59pt`.
- 모든 슬롯은 `position: absolute`로 좌상단 기준 배치.

### 2.3. `size=20`, `ellipsisType=count` (frame 66 × 20)

| Index | 슬롯 | left | size | showBorder |
|---|---|---|---|---|
| 0 | avatar | 0 | 20 × 20 | false |
| 1 | avatar | 13 | 20 × 20 | false |
| 2 | avatar | 26 | 20 × 20 | false |
| 3 | count text container | 50 | 16 × 20 | — |

- **Stride (avatars)**: `13pt` (7pt overlap, 2.2와 동일).
- **Avatar→count text 간격**: avatar 끝(46pt) → count 컨테이너 시작(50pt) = `4pt` gap.
- **count text 컨테이너**: width `16pt`, height `20pt`, `justify-content: center`, horizontal padding `4pt`.
- **Total width**: `50 + 16 = 66pt`.

### 2.4. `size=24`, `ellipsisType=icon` (frame 75 × 24)

| Index | 슬롯 | left | size | 외곽 border |
|---|---|---|---|---|
| 0 | avatar | 0 | 24 × 24 | 없음 |
| 1 | avatar | 17 | 24 × 24 | 없음 |
| 2 | avatar | 34 | 24 × 24 | 없음 |
| 3 | ellipsis avatar (image + overlay + more icon + border outline) | 51 | 24 × 24 | **있음** (`1.5pt`, overlay 위 outline §5) |

- **Stride**: `17pt` (각 avatar 사이 7pt overlap).
- **Total width**: `51 + 24 = 75pt`.

### 2.5. `size=24`, `ellipsisType=count` (frame 81 × 24)

| Index | 슬롯 | left (cumulative) | size | showBorder |
|---|---|---|---|---|
| 0 | avatar | 0 | 24 × 24 | false |
| 1 | avatar | 18 | 24 × 24 | false |
| 2 | avatar | 36 | 24 × 24 | false |
| spacer | spacer | 60 (width 4) | 4 × 24 | — |
| 3 | count text | 64 | (intrinsic) × 24 | — |

- **Stride (avatars)**: `18pt` (6pt overlap; Figma `mr=-6`).
- **Avatar→count text 간격**: spacer `4pt` (Figma 명시적 spacer 노드 `1087:21`).
- **Total width**: `81pt` (Figma frame width와 일치).

> ℹ️ **2.3 vs 2.5의 stride 차이**: `size=20` count는 7pt overlap, `size=24` count는 6pt overlap (Figma SSOT 그대로 반영).

---

## 3. Color 토큰

### 3.1. Avatar 자체

BezierAvatar SPEC 참조. AvatarGroup 자체는 avatar 컬러를 변경하지 않는다.

### 3.2. Ellipsis avatar (icon variant) — border / overlay / more 아이콘

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| Avatar border (size=20: 1pt / size=24: 1.5pt) | `surface` | `color/surface` | `#FFFFFF` |
| Overlay 배경 | `dimAbsoluteBlack` | `color/dim/absolute/black` | `#00000066` (rgba 0,0,0,0.4) |
| Overlay 내부 `more` 아이콘 | (raw 자산 색 inherit) | — | 자산 raw `#FFFFFF` |

- Overlay는 ellipsis avatar 이미지 위에 동일 크기·동일 cornerRadius로 덮인다.

### 3.3. Count text (count variant)

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| `+N` 텍스트 | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` (rgba 0,0,0,0.4) |

---

## 4. Typography (count variant)

| Size | Token | Font Size | Line Height | Weight | Family |
|---|---|---|---|---|---|
| `20` | `text/xsmall-bold` | 12pt | 16pt | 600 (semi bold) | `Inter` (`text/font-family`) |
| `24` | `text/small-bold` | 13pt | 18pt | 600 (semi bold) | `Inter` (`text/font-family`) |

- Letter spacing: `0` (`text/letter-spacing`).
- Italic: 없음.

---

## 5. Ellipsis Indicator — Icon Variant

`ellipsisType=icon` 일 때 마지막 슬롯은 다음 4개 layer 를 *아래에서 위로* 쌓아 렌더링한다.

| z-order | Layer | 내용 | 비고 |
|---|---|---|---|
| 1 (bottom) | Avatar image | 일반 avatar와 동일한 이미지 표시 | 자체 border 없음 |
| 2 | Overlay | Avatar 위에 덮인 반투명 darker layer | 색 §3.2, 크기 = avatar length, 동일 cornerRadius |
| 3 | More icon | Overlay 중앙 정렬 horizontal 3-dot 아이콘 | 자산 §5.1 |
| 4 (top) | Border outline | Avatar 외곽 stroke | 색 §3.2, 두께 size=20 → 1pt / size=24 → 1.5pt, 동일 cornerRadius |

> Border가 overlay 보다 *위*에 그려져야 한다. Avatar(이미지) 자체의 border 레이어를 사용하면 overlay 가 border 를 가려 흐려 보이므로, 구현은 BezierAvatar `showBorder=false` 로 그리고 별도 outline layer 를 가장 위에 추가한다 (§I-2 참조).

### 5.1. More 아이콘 자산

| Size 컨텍스트 | 아이콘 length | Overlay 내부 위치 (top-left) | Figma node | Figma data-name |
|---|---|---|---|---|
| `size=20` | 12 × 12 | (4, 4) | `2695:89` | `icon/more` (horizontal 3-dot) |
| `size=24` | 16 × 16 | (4, 4) | `2693:54` | `icon/more` (horizontal 3-dot) |

---

## 6. Ellipsis Indicator — Count Variant

`ellipsisType=count` 일 때 마지막 슬롯은 다음 구성으로 렌더링된다.

| 항목 | 값 |
|---|---|
| 텍스트 | `+N` 형식 (예: `+2`, `+12`) |
| 텍스트 스타일 | §4 typography |
| 텍스트 색 | §3.3 |
| Container 정렬 | (`size=20`) 컨테이너 16×20, justify-center, px=4 / (`size=24`) intrinsic width, vertical-center |

---

## 7. State

해당 없음. AvatarGroup 자체는 state property를 갖지 않는다 (default/pressed/active/disabled/loading 분기 없음).

내부 Avatar의 state(default/disabled)는 각 Avatar 인스턴스 단위로 전달되며 그룹 차원의 상태 분기는 없다.

---

# Implementation Notes (Figma 외 — implementation 규칙)

## I-1. 동적 표시 동작

Figma 컴포넌트는 instance preview용으로 항상 *3 visible avatar + 1 ellipsis slot* 으로 그려져 있다. 실제 동적 동작은 다음과 같이 implement한다.

| 입력 avatar 수 | 표시 |
|---|---|
| `≤ 3` | 모든 avatar 표시, ellipsis slot 미표시 |
| `> 3` | 첫 3개 avatar 표시 + 4번째 슬롯에 ellipsis indicator (icon 또는 count) |
| count variant 의 `+N` | `N = (입력 수) - 3` |

- Visible cap = `3` (Figma instance preview 기준).
- Ellipsis avatar(icon variant)의 이미지는 4번째 입력 avatar의 이미지를 사용 (Figma instance에서 4번째 avatar 이미지 위에 overlay).

## I-2. BezierSwift 코드 매핑

| Spec 항목 | 코드 심볼 |
|---|---|
| Typography size=20 count text | `BTSemanticToken.textXSmall(weight: .bold)` |
| Typography size=24 count text | `BTSemanticToken.textSmall(weight: .bold)` |
| Overlay 배경 색 | `BCSemanticToken.dimAbsoluteBlack` |
| Count text 색 | `BCSemanticToken.textNeutralLighter` |
| Avatar border 색 | `BCSemanticToken.surface` |
| More 아이콘 | `BezierIcon.more` (raw value `"icon-more"`) |
| Avatar 컴포넌트 | `BezierAvatar` / `SUBezierAvatar` (size·cornerRadius·borderWidth는 BezierAvatar SPEC 준수) |
| Ellipsis avatar border (icon variant) | BezierAvatar 자체 `showBorder` 미사용. 별도 outline layer (UIKit: `borderView` / SwiftUI: `RoundedRectangle().strokeBorder`) 를 overlay·more icon 보다 z-order 위에 추가. |

- More 아이콘은 `BezierIcon.more`만 사용. SF Symbol (`UIImage(systemName:)` / `Image(systemName:)`) fallback 금지.

## I-3. Accessibility

- `size=20`, `size=24` 모두 시각 보조용 정보 표시. 인터랙션 없음.
- 사용 컨텍스트(예: 담당자 목록)는 상위 화면에서 별도 label 제공 권장.
