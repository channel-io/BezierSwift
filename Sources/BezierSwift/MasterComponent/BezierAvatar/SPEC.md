# BezierAvatar / BezierAvatarStatus Spec

> Figma: [🚧 Mobile Components — Avatar](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1083-2)
> Design spec doc: [design-team/specs/components/Avatar-spec.md](https://github.com/channel-io/design-team/blob/main/specs/components/Avatar-spec.md)

이 문서는 Avatar 캔버스(node 1083:2)에 정의된 두 컴포넌트를 함께 다룬다. 두 컴포넌트는 Figma description의 "Used within Avatar only. Do not place standalone." 규약에 따라 결합 사용된다.

| 컴포넌트 | Figma node | 설명 |
|---|---|---|
| **Avatar** | 1085:2 | 사람/엔티티 식별용 프로필 이미지 컴포넌트 |
| **AvatarStatus** | 1081:22 | Avatar 위에 표시하는 상태 인디케이터 오버레이 |

- **모양 (Avatar)**: Rounded square (cornerRadius = `size × 0.42`). Figma raw 값이 정수 50%가 아니라 42% 비율의 squircle.
- **모양 (AvatarStatus)**: Circle (cornerRadius = `size / 2`).
- **Accessibility**: 디자이너 가이드라인 §A 참조.

---

# Part 1 — Avatar (node 1085:2)

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **size** | `16` / `20` / `24` / `30` / `36` / `42` / `48` / `72` / `90` / `120` / `160` | 11단계 (단위 pt) |
| **state** | `default` / `disabled` | `disabled`는 전체 wrapper opacity 0.4 |
| **showBorder** | `true` / `false` | true 시 size별 두께의 흰색 border 표시 |
| **status** | `true` / `false` | Figma preview용 boolean toggle. 실제 type은 AvatarStatus 컴포넌트가 담당 |

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

- **Corner radius**: `length × 0.42` (정수가 아닌 raw 값). 50% 원이 아닌 *squircle*(둥근 모서리 사각형) 형태.
- **Border**: showBorder=true 시 외곽선 추가. Border는 length 내부에 inset (Avatar 외곽 length 불변).
- 이미지는 컨테이너에 `overflow: clip` 적용하여 corner radius 모양으로 클리핑.
- Layout shift 없음 (showBorder/status toggle 시 length 불변).

---

## 3. Color 토큰

### Image 컨테이너
이미지는 외부 주입. 컬러 토큰 없음 (이미지의 raw pixel).

### Border (showBorder = true)

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| Border | `surface` | `color/surface` | `#FFFFFF` (white) |

### Status overlay (status = true) — Avatar 내부 렌더링

Status 인디케이터의 외곽 container 배경과 inner 인디케이터 컬러는 §Part 2 (AvatarStatus) 참조. Avatar는 type-agnostic하게 overlay 위치만 정의.

---

## 4. Status Overlay 배치 (status = true 시)

Figma SSOT는 각 size별로 overlay container의 크기·위치를 다음과 같이 직접 명시한다.

| Avatar Size | Status container Size | 위치 (left, top) | 대응 AvatarStatus size |
|---|---|---|---|
| `size16`  | 6×6   | (12, 12)   | (custom 6pt, AvatarStatus 매트릭스 외) |
| `size20`  | 8×8   | (14, 14)   | `small` |
| `size24`  | 8×8   | (18, 18)   | `small` |
| `size30`  | 12×12 | (21, 20)   | `medium` |
| `size36`  | 12×12 | (26, 26)   | `medium` |
| `size42`  | 12×12 | (32, 32)   | `medium` |
| `size48`  | 12×12 | (36, 37)   | `medium` |
| `size72`  | 16×16 | (55, 54)   | `large` |
| `size90`  | 24×24 | (68, 68)   | `xlarge` |
| `size120` | 24×24 | (96, 94)   | `xlarge` |
| `size160` | 24×24 | (132, 129) | `xlarge` |

- **Avatar 16의 특수성**: Figma SSOT의 `size16 + status=true` 노드(1084:8)는 AvatarStatus.small(8×8)이 아닌 **하드코딩된 6×6 mini container**다. inner ellipse는 6×6으로 container 전체를 채운다 (AvatarStatus.small의 8×8 container + 6×6 inner와 다름). 따라서 Avatar 16은 AvatarStatus 매트릭스 외부 케이스로 다루며, 코드 매핑은 §8 참조.
- 위치 (left, top)는 Avatar 컨테이너의 좌상단을 (0, 0)으로 한 절대 좌표. 매크로식이 아닌 Figma 디자이너가 size별로 직접 지정한 raw 좌표.

---

## 5. State 별 시각 동작

| State | 동작 |
|---|---|
| `default` | 기본 |
| `disabled` | Avatar wrapper 전체에 opacity 0.4 적용 (이미지 + border + status overlay 모두 영향) |

- **disabled opacity 값**: Figma variable `opacity/disabled = 0.4` (40%).
- 인터랙션 자체는 Avatar primitive가 정의하지 않음 (presentational view). 탭/제스처는 상위 컨테이너 책임.

---

## 6. Typography

이 컴포넌트에 텍스트 없음. (Figma description은 "이미지 없을 때 이니셜 표시"를 언급하지만 Avatar 캔버스 노드(1085:2)의 어떤 variant에도 텍스트 노드가 존재하지 않음. 이니셜/폴백 동작은 Avatar 캔버스 SSOT 밖.)

---

## 7. 디자이너 가이드라인 (Figma component description 인용)

> 사람 또는 엔티티를 시각적으로 식별하는 프로필 이미지 컴포넌트.
> - size: 16(Mobile 전용·초소형 인라인) / 20(인라인·드롭다운) / 24(기본 목록) / 30·36(중간 밀도) / 42·48(상세 패널) / 72~160(대형 표시)
> - state: default / disabled(불투명도 감소 — 비활성 계정 표시)
> - status(옵션): true 시 우측 하단에 Status 인디케이터 오버레이
> - showBorder(옵션): true 시 외곽 border 표시 — 겹치는 배경 위 가시성 확보
> - 이미지 없을 때 이니셜 또는 폴백 아이콘 자동 표시. 복수 Avatar 표시는 AvatarGroup 사용.

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierAvatar.swift` |
| SwiftUI 구현 | `SUBezierAvatar.swift` |
| Size enum + 정수 spec | `BezierAvatarSpec.swift` |
| Border 컬러 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` — `surface` |

---

## 9. Variant 매트릭스

총 instance: `11 size × 2 state = 22개`

```text
State=default
  size=16  = 1084:5
  size=20  = 1084:10
  size=24  = 1084:15
  size=30  = 1084:20
  size=36  = 1084:25
  size=42  = 1084:30
  size=48  = 1084:35
  size=72  = 1084:40
  size=90  = 1084:45
  size=120 = 1084:50
  size=160 = 1084:55

State=disabled
  size=16  = 2708:13
  size=20  = 2708:17
  size=24  = 2708:21
  size=30  = 2708:25
  size=36  = 2708:29
  size=42  = 2708:33
  size=48  = 2708:37
  size=72  = 2708:41
  size=90  = 2708:45
  size=120 = 2708:49
  size=160 = 2708:53
```

---

# Part 2 — AvatarStatus (node 1081:22)

> Figma description 인용: *"📌 이동 예정: Internal 페이지 (구현 정착 후) Used within Avatar only. Do not place standalone."*
>
> AvatarStatus는 Avatar 위에 결합 사용한다. Standalone 배치는 디자인 원칙상 비권장.

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **type** | `online` / `offline` / `lock` / `onlineDnd` / `offlineDnd` | 5가지 |
| **size** | `small` / `medium` / `large` / `xlarge` | 4단계 (Avatar size에 따른 매핑은 Part 1 §4) |

총 instance: `5 type × 4 size = 20개` (Figma 노출 매트릭스와 일치)

---

## 2. Size 별 Layout

| Size | Container Length | Container Padding | Container Corner Radius | Inner Indicator Length |
|---|---|---|---|---|
| `small`  | 8pt  | 2pt | 4pt  | 6pt  |
| `medium` | 12pt | 2pt | 6pt  | 8pt  |
| `large`  | 16pt | 3pt | 8pt  | 12pt |
| `xlarge` | 24pt | 2pt | 12pt | 18pt |

- Container corner radius는 `length / 2` (원형).
- Inner indicator (ellipse 또는 icon)는 container 중앙에 배치 (`flex items-center justify-center`).
- Inner indicator length는 container length의 50~75% 사이로 size마다 다름 (small 75% / medium 66.7% / large 75% / xlarge 75%).

---

## 3. Color 토큰

### Container background (모든 type 공통)

| Token | Figma Variable | Raw |
|---|---|---|
| `surfaceHighest` | `color/surface/highest` | `#FFFFFF` (white) |

### Inner indicator (type 별)

| Type | 형태 | Token | Figma Variable | Raw |
|---|---|---|---|---|
| `online`     | Filled ellipse | `iconAccentGreen`  | `color/icon/accent/green`  | `#20AB55` |
| `offline`    | Filled ellipse | `iconNeutral`      | `color/icon/neutral`       | `#00000066` |
| `lock`       | Lock glyph     | `iconNeutral`      | `color/icon/neutral`       | `#00000066` |
| `onlineDnd`  | Moon glyph     | `iconAccentGreen`  | `color/icon/accent/green`  | `#20AB55` |
| `offlineDnd` | Moon glyph     | `iconAccentYellow` | `color/icon/accent/yellow` | `#EDAE0D` |

---

## 4. Type별 시각 자산 (Inner indicator asset)

| Type | 형태 | Figma 노드 데이터 |
|---|---|---|
| `online`     | Ellipse (filled circle) | `data-name="Ellipse"` — 단색 원형 |
| `offline`    | Ellipse (filled circle) | `data-name="Ellipse"` — 단색 원형 |
| `lock`       | Lock icon glyph | `data-name="icon/lock"` — Figma asset, 코드 매핑 `BezierIcon.lock` |
| `onlineDnd`  | Moon-filled icon glyph | `data-name="icon/moon-filled"` — Figma asset, 코드 매핑 `BezierIcon.moonFilled` |
| `offlineDnd` | Moon-filled icon glyph | `data-name="icon/moon-filled"` — Figma asset, 코드 매핑 `BezierIcon.moonFilled` |

- `online` / `offline`은 단색 filled circle 도형. 디자인시스템 아이콘 자산 없음.
- `lock` / `onlineDnd` / `offlineDnd`는 `BezierIcon` enum의 기존 case로 매핑되어야 함. SF Symbol 폴백 금지.
- `onlineDnd`와 `offlineDnd`는 동일 자산(`icon/moon-filled`)을 사용하되 tint 컬러만 다름.

---

## 5. Typography

이 컴포넌트에 텍스트 없음.

---

## 6. State

해당 없음. AvatarStatus는 state property를 갖지 않음. Avatar의 disabled state는 wrapper opacity로 AvatarStatus도 함께 흐려진다 (Avatar 책임).

---

## 7. 디자이너 가이드라인 (Figma component description 인용)

> 📌 이동 예정: Internal 페이지 (구현 정착 후) Used within Avatar only. Do not place standalone. 온라인/오프라인/방해금지/잠금 등 Avatar 위에 표시하는 상태 인디케이터.
> - type: online / offline / onlineDnd / offlineDnd / lock
> - size: small(8px, Avatar 16-24) / medium(12px, Avatar 30-60) / large(16px, Avatar 72) / xlarge(24px, Avatar 90-160)
>
> ⚠️ description의 size 매핑("small(8px) for Avatar 16-24")은 가이드라인이고, Figma 실제 매트릭스 노드에서 Avatar 16은 AvatarStatus.small 인스턴스가 아닌 custom 6×6 노드(1084:8)를 사용한다. Part 1 §4 표 참조.

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierAvatarStatus.swift` |
| SwiftUI 구현 | `SUBezierAvatarStatus.swift` |
| Type / Size enum | `BezierAvatarSpec.swift` (Avatar과 공유) |
| Container 배경 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` — `surfaceHighest` |
| Indicator 컬러 (semantic) | 동 파일 — `iconAccentGreen` / `iconNeutral` / `iconAccentYellow` |
| Lock / Moon 아이콘 자산 | `Sources/BezierSwift/Icons/BezierIcon.swift` — `lock`, `moonFilled` |

---

## 9. Variant 매트릭스

총 instance: `5 type × 4 size = 20개`

```text
type=online
  size=small  = 2806:2
  size=medium = 1079:16
  size=large  = 1079:18
  size=xlarge = 2806:4

type=offline
  size=small  = 2806:8
  size=medium = 1079:20
  size=large  = 1079:22
  size=xlarge = 2806:10

type=lock
  size=small  = 2806:31
  size=medium = 1079:30
  size=large  = 1079:39
  size=xlarge = 2806:40

type=onlineDnd
  size=small  = 2806:59
  size=medium = 1079:48
  size=large  = 1079:51
  size=xlarge = 2806:62

type=offlineDnd
  size=small  = 2806:69
  size=medium = 1079:54
  size=large  = 1079:57
  size=xlarge = 2806:72
```
