# BezierAvatarGroup Spec

> Figma: [Mobile Components — AvatarGroup](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/Mobile-Components?node-id=4055-1145) (node `4055:1145`)
> Design spec doc: [team-design/bezier-v3/components/AvatarGroup-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/AvatarGroup-spec.md) (v0.8)

복수의 Avatar를 겹치거나 나란히 표시하고 초과분을 ellipsis 인디케이터로 나타내는 그룹 컴포넌트.

- **모양**: 좌측부터 우측으로 Avatar가 일정 stride로 배치되며, 마지막 슬롯이 ellipsis (overflow) 인디케이터.
- **사용처 가이드** (Figma component description):
  - `size`: 20(인라인 보조) / 24(리스트·카드 표준) / 30·36(중간 밀도) / 42·48(상세 패널) / 72·90·120(대형 표시)
  - `ellipsisType=icon`: 초과 인원 수가 비중요할 때 (3-dot more 아이콘으로 표시)
  - `ellipsisType=count`: 초과 인원 수 파악이 중요할 때 (`+N` 텍스트로 표시)
  - `overlap=true`: 공간이 좁을 때 겹쳐 표시 (avatar 흰 border로 구분)
  - `overlap=false`: 공간이 충분할 때 나란히 표시 (border 없음)
- **Children 제약**: BezierAvatar 컴포넌트만 사용.

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **size** | `20` / `24` / `30` / `36` / `42` / `48` / `72` / `90` / `120` | 9단계. 그룹 내 모든 Avatar에 일괄 적용 |
| **ellipsisType** | `icon` / `count` | 마지막 슬롯의 overflow 표현 방식 |
| **overlap** | `true` / `false` | 겹침(spacing<0, showBorder=true) / 나란히(spacing>0, showBorder=false) |

> Figma 매트릭스에는 size 16·160도 그려져 있으나 component description의 공식 지원 범위(20~120)에 포함되지 않아 iOS 구현 대상에서 제외한다.
> 총 Figma instance: `9 size × 2 ellipsisType × 2 overlap = 36개`.

---

## 2. Size 별 Layout

### 2.1. 공통 — Avatar instance

각 슬롯의 Avatar는 그룹 size 그대로 `BezierAvatar` property로 렌더링된다 (size·cornerRadius·borderWidth는 BezierAvatar SPEC 준수). `overlap=true`이면 visible avatar에 `showBorder=true`, `overlap=false`이면 `showBorder=false`.

### 2.2. Layout 배치 모델 (flexbox)

Figma는 절대좌표가 아니라 flexbox 음수/양수 margin으로 배치한다. iOS 구현은 이를 `stride`(avatar 좌상단 간 거리)로 환산한다.

- `overlap=true`: `stride = length − 겹침`
- `overlap=false`: `stride = length + 간격`

### 2.3. Size 별 값 (Figma SSOT)

`length` / `cornerRadius` / `borderWidth`는 `BezierAvatarSize`에서 가져온다. icon·count의 stride는 동일하다.

| size | length | 겹침(overlap=true) | 간격(overlap=false) | more 아이콘 | more inset (중앙) | border 두께(overlap=true) |
|---|---|---|---|---|---|---|
| 20  | 20  | 5  | 3  | 12 | 4  | 1    |
| 24  | 24  | 6  | 3  | 16 | 4  | 1.5  |
| 30  | 30  | 7  | 3  | 20 | 5  | 1.5  |
| 36  | 36  | 9  | 4  | 24 | 6  | 1.5  |
| 42  | 42  | 10 | 4  | 24 | 9  | 2    |
| 48  | 48  | 12 | 6  | 30 | 9  | 2    |
| 72  | 72  | 18 | 9  | 30 | 21 | 2.5  |
| 90  | 90  | 22 | 11 | 30 | 30 | 3    |
| 120 | 120 | 30 | 14 | 30 | 45 | 3.5  |

- **more 아이콘 length**: size48부터 30pt 상한 고정.
- **more inset** = `(length − more아이콘 length) / 2` (중앙정렬 공식). Figma raw는 큰 size에서 완전 중앙이 아닌 비단조 값(size42=9 > size48=8 등)이라, 구현은 중앙정렬 공식으로 정규화한다.
- **border 두께**는 `BezierAvatarSize.borderWidth`와 동일하다.

### 2.4. Count 텍스트 배치

`ellipsisType=count`의 마지막 슬롯은 avatar 오른쪽에 `+N` 텍스트를 둔다.

| 항목 | 값 |
|---|---|
| avatar↔text 간격 (overlap=true) | 4pt (단 size120은 6pt) |
| avatar↔text 간격 (overlap=false) | 해당 size의 간격(§2.3) 과 동일 |
| text 너비 | intrinsic (고정 폭 없음) |
| text 세로 정렬 | avatar length 높이 컨테이너에 center |

---

## 3. Color 토큰

### 3.1. Avatar 자체
BezierAvatar SPEC 참조. AvatarGroup 자체는 avatar 컬러를 변경하지 않는다.

### 3.2. Ellipsis avatar (icon variant) — border / overlay / more 아이콘

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| Avatar border (overlap=true, size별 §2.3) | `surface` | `color/surface` | `#FFFFFF` |
| Overlay 배경 | `dimAbsoluteBlack` | `color/dim/absolute/black` | `#00000066` (rgba 0,0,0,0.4) |
| Overlay 내부 `more` 아이콘 | (raw 자산 색 inherit) | — | 자산 raw `#FFFFFF` |

- Overlay는 ellipsis avatar 이미지 위에 동일 크기·동일 cornerRadius로 덮인다.
- Overlay·border의 cornerRadius는 avatar cornerRadius(`length × 0.42`, raw 8.4~50.4)를 그대로 사용한다 (Figma의 정수 반올림 대신 avatar와 완전 동일 곡률 유지).

### 3.3. Count text (count variant)

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| `+N` 텍스트 | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` (rgba 0,0,0,0.4) |

---

## 4. Typography (count variant)

count `+N` 텍스트는 **AvatarGroup 전용 typography 토큰**(`BezierAvatarGroupCountFont`)으로 렌더링한다.

> line-height 컬럼은 Figma 참조값이며 **iOS 구현에는 적용하지 않는다**(아래 사유 참고).

| size | font-size | line-height (참조) | weight | letter-spacing |
|---|---|---|---|---|
| 20  | 12 | 18 | regular(400) | 0 |
| 24  | 13 | 18 | regular(400) | 0 |
| 30  | 15 | 18 | regular(400) | 0 |
| 36  | 16 | 18 | regular(400) | 0 |
| 42  | 18 | 18 | regular(400) | 0 |
| 48  | 24 | 18 | regular(400) | 0 |
| 72  | 24 | 18 | regular(400) | 0 |
| 90  | 32 | 32 | regular(400) | 0 |
| 120 | 36 | 18 | regular(400) | 0 |

> **전용 토큰 사유 (Custom)**: Figma SSOT(`4055:1145`)의 size별 font-size/line-height 조합이 `BTSemanticToken`의 고정 페어(예: `text/small`=13/18)와 맞지 않는다 (size48·72=24/18, size120=36/18, size90=32/32는 line-height<font-size이거나 semantic 토큰에 없는 조합). GitHub SSOT 문서(team-design v0.8)에도 typography 스펙이 없어 Figma 실측값이 유일 근거다. 따라서 공용 `BTSemanticToken`/`BTGlobalToken`을 오염시키지 않고 `BezierAvatarGroupCountFont`(컴포넌트 전용 internal 토큰)로 raw 값을 정의한다. size90(32/32)·size120(36/18)은 Figma 원본 raw 그대로다. iOS 구현은 count 가 단일 라인이고 avatar length 컨테이너에 수직 center 되므로 **line-height 를 렌더에 적용하지 않고 font-size 만 사용**한다. UIKit 도 baselineOffset 없이 순수 font 로 그려 SwiftUI 와 렌더가 일치한다(특히 size120 처럼 line-height<font-size 인 경우 baselineOffset 을 쓰면 UIKit 만 텍스트가 아래로 밀리는 불일치가 생김).

- Font family: system (Inter 대응). Italic 없음.

---

## 5. Ellipsis Indicator — Icon Variant

`ellipsisType=icon` 일 때 마지막 슬롯은 다음 layer를 *아래에서 위로* 쌓아 렌더링한다.

| z-order | Layer | 내용 | 비고 |
|---|---|---|---|
| 1 (bottom) | Avatar image | 일반 avatar와 동일한 이미지 (4번째 입력 이미지) | 자체 border 없음 (`showBorder=false`) |
| 2 | Overlay | 반투명 darker layer | 색 §3.2, 크기 = avatar length, 동일 cornerRadius |
| 3 | More icon | Overlay 중앙 정렬 3-dot 아이콘 | 자산 §5.1, size §2.3 |
| 4 (top) | Border outline | Avatar 외곽 stroke | **`overlap=true`일 때만.** 색 §3.2, 두께 §2.3, 동일 cornerRadius |

> Border가 overlay보다 *위*에 그려져야 하므로 BezierAvatar `showBorder`를 쓰지 않고 별도 outline layer(UIKit: `borderView` / SwiftUI: `RoundedRectangle().strokeBorder`)를 가장 위에 추가한다. `overlap=false`에서는 border를 그리지 않는다.

### 5.1. More 아이콘 자산

- 자산: `BezierIcon.more` (raw value `"icon-more"`, horizontal 3-dot). SF Symbol fallback 금지.
- length: §2.3 (size48부터 30pt 상한), Overlay 내부 위치: (moreIconInset, moreIconInset) 중앙.

---

## 6. Ellipsis Indicator — Count Variant

`ellipsisType=count` 일 때 마지막 슬롯은 다음 구성으로 렌더링된다.

| 항목 | 값 |
|---|---|
| 텍스트 | `+N` 형식 (`N = 입력 수 − maxVisible`) |
| 텍스트 스타일 | §4 typography (전용 토큰) |
| 텍스트 색 | §3.3 `textNeutralLighter` |
| 배치 | §2.4 (avatar↔text 간격, intrinsic width, 세로 center) |

---

## 7. State

해당 없음. AvatarGroup 자체는 state property를 갖지 않는다. 내부 Avatar의 state는 각 Avatar 인스턴스 단위이며 그룹 차원 상태 분기는 없다.

---

# Implementation Notes (Figma 외 — implementation 규칙)

## I-1. 동적 표시 동작

Figma 컴포넌트는 preview용으로 고정 개수를 그려두지만, 실제 동적 동작은 다음과 같다.

| 입력 avatar 수 | 표시 |
|---|---|
| `≤ maxVisible(3)` | 모든 avatar 표시, ellipsis 미표시 |
| `> maxVisible` | 첫 3개 avatar + 4번째 슬롯에 ellipsis indicator (icon 또는 count) |
| count variant 의 `+N` | `N = (입력 수) − maxVisible` |

- Visible cap = `BezierAvatarGroupConstant.maxVisibleAvatars = 3`.
- Ellipsis avatar(icon variant)의 이미지는 4번째 입력 avatar 이미지를 사용.

## I-2. BezierSwift 코드 매핑

| Spec 항목 | 코드 심볼 |
|---|---|
| Size / stride / more / border / count 값 | `BezierAvatarGroupSize` (`BezierAvatarGroupSpec.swift`) |
| Count typography 전용 토큰 | `BezierAvatarGroupCountFont` (**internal**, 동 파일). font-size 만 보유(system, weight `.regular`). line-height 는 미보유 |
| overlap 여부 | `BezierAvatarGroup.overlap` / `SUBezierAvatarGroup(overlap:)` (기본 `true`) |
| Overlay 배경 색 | `BCSemanticToken.dimAbsoluteBlack` |
| Count text 색 | `BCSemanticToken.textNeutralLighter` |
| Avatar border 색 | `BCSemanticToken.surface` |
| More 아이콘 | `BezierIcon.more` |
| Avatar 컴포넌트 | `BezierAvatar` / `SUBezierAvatar` |
| Ellipsis border(icon, overlap=true) | 별도 outline layer (UIKit `borderView` / SwiftUI `strokeBorder`), overlay·more icon보다 z-order 위 |
| Count 텍스트 렌더 | UIKit/SwiftUI 모두 순수 font(system·weight `.regular`) + avatar length 컨테이너 center. baselineOffset·line-height 미적용으로 양 플랫폼 렌더 일치. 폭은 `BezierAvatarGroupSize.countTextWidth(overflowCount:)` 공통 헬퍼로 측정 |

- More 아이콘은 `BezierIcon.more`만 사용. SF Symbol fallback 금지.
- count typography는 `BezierAvatarGroupCountFont` 전용 토큰만 사용. 공용 `BTGlobalToken`/`BTSemanticToken`은 변경하지 않는다.

## I-3. Accessibility

- 전 size 시각 보조용 정보 표시. 인터랙션 없음.
- 사용 컨텍스트(예: 담당자 목록)는 상위 화면에서 별도 label 제공 권장.
