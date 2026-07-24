# BezierAvatar / BezierStatus Spec

> **SSOT**: team-design [`bezier-v3/components/Status-spec.md`](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Status-spec.md) · [`Avatar-spec.md`](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Avatar-spec.md)
> Figma (참고): [🚧 Mobile Components — Avatar](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1083-2)

이 문서는 Avatar와 Status 두 컴포넌트를 함께 다룬다. Status는 Figma description의 "Used within Avatar only. Do not place standalone." 규약에 따라 Avatar 위에 결합 사용된다.

> **SSOT 전환 이력**: 이 문서는 이전에 Figma Mobile(node 1083:2 / 1081:22)을 SSOT로 작성됐으나, team-design GitHub spec을 상위 SSOT로 전환했다. team-design spec과 Figma Mobile 실측값의 차이는 **§Deviations** 참조. 리네임 `AvatarStatus → Status`는 team-design Status-spec.md `Status` 확정과 일치한다.

| 컴포넌트 | Figma node | 설명 |
|---|---|---|
| **Avatar** | 1085:2 | 사람/엔티티 식별용 프로필 이미지 컴포넌트 |
| **Status** | 1081:22 | Avatar 위에 표시하는 상태 인디케이터 오버레이 |

- **모양 (Avatar)**: Rounded square (cornerRadius = `size × 0.42`). 정수 50%가 아닌 42% 비율의 squircle.
- **모양 (Status)**: Circle (cornerRadius = `size / 2`).
- **Accessibility**: 디자이너 가이드라인 §A 참조.

---

# Part 1 — Avatar (node 1085:2)

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **size** | `16` / `20` / `24` / `30` / `36` / `42` / `48` / `72` / `90` / `120` / `160` | 11단계 (단위 pt) |
| **state** | `default` / `disabled` | `disabled`는 전체 wrapper opacity 0.4 |
| **showBorder** | `true` / `false` | true 시 size별 두께의 흰색 border 표시 |
| **status** | `true` / `false` | Figma preview용 boolean toggle. 실제 type은 Status 컴포넌트가 담당 |

총 instance: `11 size × 2 state = 22개` (Figma 노출 매트릭스. showBorder/status는 boolean toggle로 매트릭스 축이 아님)

---

## 2. Size 별 Layout

| Size | Length (W=H) | Corner Radius | Border Width (showBorder=true) |
|---|---|---|---|
| `size16`  | 16pt  | 6.72pt   | 1pt   |
| `size20`  | 20pt  | 8.4pt    | 1pt   |
| `size24`  | 24pt  | 10.08pt  | 1.5pt |
| `size30`  | 30pt  | 12.6pt   | 1.5pt |
| `size36`  | 36pt  | 15.12pt  | 1.5pt |
| `size42`  | 42pt  | 17.64pt  | 2pt   |
| `size48`  | 48pt  | 20.16pt  | 2pt   |
| `size72`  | 72pt  | 30.24pt  | 2.5pt |
| `size90`  | 90pt  | 37.8pt   | 3pt   |
| `size120` | 120pt | 50.4pt   | 3.5pt |
| `size160` | 160pt | 67.2pt   | 4pt   |

- **Corner radius**: `length × 0.42` (정수가 아닌 raw 값). 50% 원이 아닌 *squircle* 형태.
- **Border**: showBorder=true 시 외곽선 추가. Border는 length 내부에 inset (Avatar 외곽 length 불변).
- 이미지는 컨테이너에 corner radius 모양으로 클리핑.
- Layout shift 없음 (showBorder/status toggle 시 length 불변).

---

## 3. Color 토큰

### Image 컨테이너
이미지는 외부 주입. 컬러 토큰 없음 (이미지의 raw pixel).

### Border (showBorder = true)

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| Border | `surface` | `color/surface` | `#FFFFFF` (white) |

### Status overlay (status = true)
Status 인디케이터의 컨테이너·inner 컬러는 §Part 2 참조. Avatar는 type-agnostic하게 overlay 위치만 정의.

---

## 4. Status Overlay 배치 (status = true 시)

Avatar-spec §6 매핑 및 좌표 공식(SSOT):
- **매핑**: `20/24 → small`, `30/36/42 → medium`, `48 → large`, `72/90 → xlarge`, `120/160 → xxlarge`. (`16`은 매트릭스 외 custom 6×6)
- **좌표 공식**: `size < 72 → x = y = avatarSize − statusSize + 2` · `size ≥ 72 → x = y = avatarSize − statusSize − 4`

| Avatar Size | Status container Size | 위치 (left, top) | 대응 Status size |
|---|---|---|---|
| `size16`  | 6×6   | (12, 12)   | custom 6pt (Status 매트릭스 외) |
| `size20`  | 8×8   | (14, 14)   | `small` |
| `size24`  | 8×8   | (18, 18)   | `small` |
| `size30`  | 12×12 | (20, 20)   | `medium` |
| `size36`  | 12×12 | (26, 26)   | `medium` |
| `size42`  | 12×12 | (32, 32)   | `medium` |
| `size48`  | 16×16 | (34, 34)   | `large` |
| `size72`  | 24×24 | (44, 44)   | `xlarge` |
| `size90`  | 24×24 | (62, 62)   | `xlarge` |
| `size120` | 32×32 | (84, 84)   | `xxlarge` |
| `size160` | 32×32 | (124, 124) | `xxlarge` |

- **Avatar 16의 특수성**: `size16 + status=true`는 Status.small(8×8)이 아닌 하드코딩된 6×6 mini container다. 코드 매핑상 `matchingAvatarStatusSize = nil`로 처리 (§8).
- 위치는 Avatar 컨테이너 좌상단을 (0,0)으로 한 절대 좌표(공식 계산). Figma Mobile 실측 좌표와는 차이 있음 — §Deviations.

---

## 5. State 별 시각 동작

| State | 동작 |
|---|---|
| `default` | 기본 |
| `disabled` | Avatar wrapper 전체에 opacity 0.4 (이미지 + border + status overlay 모두 영향) |

- **disabled opacity 값**: Figma variable `opacity/disabled = 0.4` (40%).
- 인터랙션은 Avatar primitive가 정의하지 않음 (presentational view).

---

## 6. Typography

이 컴포넌트에 텍스트 없음. (이니셜/폴백 동작은 Avatar 캔버스 SSOT 밖.)

---

## 7. 디자이너 가이드라인 (Figma component description 인용)

> 사람 또는 엔티티를 시각적으로 식별하는 프로필 이미지 컴포넌트.
> - size: 16(Mobile 전용·초소형 인라인) / 20(인라인·드롭다운) / 24(기본 목록) / 30·36(중간 밀도) / 42·48(상세 패널) / 72~160(대형 표시)
> - state: default / disabled(불투명도 감소)
> - status(옵션): true 시 우측 하단에 Status 인디케이터 오버레이
> - showBorder(옵션): true 시 외곽 border 표시
> - 이미지 없을 때 이니셜 또는 폴백 아이콘 자동 표시. 복수 Avatar 표시는 AvatarGroup 사용.

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierAvatar.swift` |
| SwiftUI 구현 | `SUBezierAvatar.swift` |
| Size enum + spec | `BezierAvatarSpec.swift` |
| Border 컬러 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` — `surface` |

---

# Part 2 — Status (node 1081:22)

> Figma description 인용: *"Used within Avatar only. Do not place standalone."*
>
> Status는 Avatar 위에 결합 사용한다. Standalone 배치는 디자인 원칙상 비권장.

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **type** | `online` / `offline` / `lock` / `onlineDnd` / `offlineDnd` | 5가지 |
| **size** | `small` / `medium` / `large` / `xlarge` / `xxlarge` | 5단계 (Avatar size에 따른 매핑은 Part 1 §4) |

> `xxlarge`는 team-design Status-spec §4 기준 추가. Figma Mobile Status 세트(node 1081:22)에는 미존재 — §Deviations.

---

## 2. Size 별 Layout

| Size | Container Length | Border Width | Circle Length (= container − 2×border) |
|---|---|---|---|
| `small`   | 8pt  | 1pt | 6pt  |
| `medium`  | 12pt | 2pt | 8pt  |
| `large`   | 16pt | 2pt | 12pt |
| `xlarge`  | 24pt | 3pt | 18pt |
| `xxlarge` | 32pt | 4pt | 24pt |

- Container corner radius는 `length / 2` (원형).
- 외부 컨테이너 = fill + stroke(2겹). 내부 원은 stroke 두께만큼 안쪽으로 inset되어 `Circle Length` 크기로 중앙 배치.
- 아이콘 type(lock/onlineDnd/offlineDnd)의 glyph는 현재 `Circle Length` 크기로 렌더. team-design §6의 `icon-badge` 별도 크기(10/14/22/28)는 유보 — §Deviations.

---

## 3. Color 토큰 (team-design Status-spec §6)

### 외부 컨테이너 (모든 type 공통)

| 위치 | Token | Figma Variable |
|---|---|---|
| fill | `surfaceHigh` | `color/surface/high` |
| stroke (width = size.borderWidth) | `surfaceHighest` | `color/surface/highest` |

### Inner indicator (type 별)

| Type | 형태 | 내부원(`circleToken`) | 아이콘(`iconToken`) |
|---|---|---|---|
| `online`     | Filled circle | `textAccentGreen` | — |
| `offline`    | Filled circle | `fillNeutralHeavy` (토큰 자체가 15% opacity — black15/white20, 추가 곱 없음) | — |
| `lock`       | Lock glyph     | `surfaceHigh` (아이콘 배경) | `textNeutralLight` |
| `onlineDnd`  | Moon glyph     | `surfaceHigh` (아이콘 배경) | `iconAccentGreen` |
| `offlineDnd` | Moon glyph     | `surfaceHigh` (아이콘 배경) | `iconAccentYellow` |

- 불변식: `icon != nil ⇔ iconToken != nil`. 아이콘 type은 내부원 배경이 외부 fill(surfaceHigh)과 동일하므로 별도 원을 그리지 않고 glyph만 렌더.

---

## 4. Type별 시각 자산 (Inner indicator asset)

| Type | 형태 | 코드 매핑 |
|---|---|---|
| `online`     | Filled circle | 도형 (자산 없음) |
| `offline`    | Filled circle | 도형 (자산 없음) |
| `lock`       | Lock glyph    | `BezierIcon.lock` |
| `onlineDnd`  | Moon glyph    | `BezierIcon.moonFilled` |
| `offlineDnd` | Moon glyph    | `BezierIcon.moonFilled` |

- `lock` / `onlineDnd` / `offlineDnd`는 `BezierIcon` enum 기존 case로 매핑. SF Symbol 폴백 금지.
- `onlineDnd`와 `offlineDnd`는 동일 자산(`moonFilled`)을 tint만 달리 사용.

---

## 5. Typography

이 컴포넌트에 텍스트 없음.

---

## 6. State

해당 없음. Status는 state property를 갖지 않음. Avatar의 disabled state는 wrapper opacity로 Status도 함께 흐려진다 (Avatar 책임).

---

## 7. 디자이너 가이드라인

> 온라인/오프라인/방해금지/잠금 등 Avatar 위에 표시하는 상태 인디케이터.
> - type: online / offline / onlineDnd / offlineDnd / lock
> - size: small / medium / large / xlarge / xxlarge (Avatar size에 따라 자동 결정, Part 1 §4)

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierStatus.swift` |
| SwiftUI 구현 | `SUBezierStatus.swift` |
| Type / Size enum | `BezierStatusSpec.swift` |
| Deprecated alias (`BezierAvatarStatus` 등) | `BezierStatusDeprecated.swift` |
| 컨테이너 fill/stroke (semantic) | `BCSemanticToken.swift` — `surfaceHigh` / `surfaceHighest` |
| Indicator 컬러 (semantic) | 동 파일 — `textAccentGreen` / `fillNeutralHeavy` / `textNeutralLight` / `iconAccentGreen` / `iconAccentYellow` |
| Lock / Moon 아이콘 자산 | `Sources/BezierSwift/Icons/BezierIcon.swift` — `lock`, `moonFilled` |

---

# Deviations — team-design SSOT vs Figma Mobile 실측

team-design GitHub spec을 SSOT로 따르되, 아래 항목은 Figma Mobile 실측과 차이가 있다. Figma Mobile은 아직 team-design spec을 반영하지 않은 상태로 보이며, 디자이너 확인 후 Figma 갱신이 필요하다.

| 항목 | team-design (SSOT, 구현 반영) | Figma Mobile 실측 (node 1081:22) |
|---|---|---|
| online 내부원 | `textAccentGreen` | `iconAccentGreen` (`#20AB55`) |
| offline 내부원 | `fillNeutralHeavy` (15% opacity 토큰 그대로) | `iconNeutral` (`#00000066`) |
| lock glyph | `textNeutralLight` | `iconNeutral` (`#00000066`) |
| 외부 컨테이너 | fill `surfaceHigh` + stroke `surfaceHighest` | `surfaceHighest` 단일 배경 |
| size 단계 | 5단계 (xxlarge 32×32 포함) | 4단계 (xxlarge 없음) |
| Avatar 매핑 48/72/120/160 | large / xlarge / xxlarge / xxlarge | medium / large / xlarge / xlarge |
| overlay 좌표 | 공식 계산 (§Part 1 §4) | 디자이너 지정 raw 좌표 (30·48·72·90·120·160 등에서 상이) |

### 유보 (Held)
- **icon-badge 정밀 크기**: team-design §6 Layout은 아이콘 type에 내부원보다 큰 `icon-badge`(small 6 / medium 10 / large 14 / xlarge 22 / xxlarge 28)를 명시하나, medium 10 > 컨테이너−2·border(8)로 stroke ring을 넘는 자기모순이 있고 Figma 근거도 불명확하다. 구현은 glyph를 `Circle Length`로 렌더하며, 정밀 크기는 디자이너 확인 후 별도 반영한다.
