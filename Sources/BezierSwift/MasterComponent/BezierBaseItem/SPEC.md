# BezierBaseItem SPEC

> **SSOT**: [Figma · Mobile-Components / Base — `_BaseItem` (4404:11875)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4400-213)
> **Design spec doc**: [team-design / bezier-v3 / components / BaseItem.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseItem.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)
>
> 모든 수치/토큰은 Figma `_BaseItem` 노드에 실재한다. §7 인터랙션은 Figma `_BaseItem`에 state variant가 없어 별도 협의 결정으로 분리 표기한다.

## 1. Component Overview

- **이름**: BaseItem (`_BaseItem`)
- **설명**: 리스트/메뉴 계열 `*Item` 서브컴포넌트가 공유하는 공통 레이아웃 base. `leading` / `center`(title·description) / `trailing` 3영역 anatomy.
- **가이드라인** (Figma component description 인용):
  - 단독 배치 금지 — `*Item` 계열(NavigationItem, SelectItem 등) 내부 base 레퍼런스 전용.
  - `showLeadingContent`: 대표 UI 슬롯 (정방형 — small/medium 24×24 / large 36×36, **단일**).
  - `showTrailingContent`: 부가 메타 슬롯 (1~2개 요소, 꼭 필요할 때만).
  - `showDescription`: label 하단 보조 텍스트 (**size=small 미지원**).
  - `showCenterSlot`: label 우측 인라인 보조 슬롯.
  - label은 Figma에서 HUG이나, 구현에서는 공간 부족 시 ellipsis truncate.

## 2. Component Properties

Figma `_BaseItem`(4404:11875) property 정의 전수. 기계 property key(`has*` / SLOT / TEXT)를 기준으로 하고, component description의 서술 표기(`show*`)는 별도 주석.

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `size` | VARIANT | small | small / medium / large | `BezierBaseItemSize` |
| `hasLeadingContent` | BOOLEAN | true | on / off | leading 슬롯 유무 |
| `hasCenterSlot` | BOOLEAN | true | on / off | centerSlot 유무 |
| `hasDescription` | BOOLEAN | false | on / off (medium·large만) | description 유무 |
| `hasTrailingContent` | BOOLEAN | true | on / off | trailing 슬롯 유무 |
| `label` | TEXT | "Label" | 문자열 | title |
| `description` | TEXT | "Description text" | 문자열 | description |
| `leadingContent` | SLOT | — | 임의 콘텐츠 | leading 슬롯 |
| `centerSlot` | SLOT | — | 임의 콘텐츠 | centerSlot |
| `trailingContent` | SLOT | — | 임의 콘텐츠 | trailing 슬롯 |

> VARIANT 축은 `size` 하나뿐 — **state(hover/pressed/disabled) variant는 없다** (순수 레이아웃 심볼). 인터랙션은 §7 참조.
> component description은 위 boolean을 `showLeadingContent`/`showCenterSlot`/`showDescription`/`showTrailingContent`로 서술하나, 기계 property key는 `has*` (Figma 내 표기 혼용).
> **small의 description 미지원**: small variant(`4404:2`)엔 `descriptionWrapper`·`description` 노드가 **아예 없다**(medium·large만 `visible:false`로 보유).

## 3. Layout (size별) — Figma 실측

단위 iOS `pt`. Figma 인스턴스 `4448:277`(small) / `4448:278`(medium) / `4448:279`(large) / `4448:780`(large+desc) 실측.

| size | minHeight | padding (상하/좌우) | leading (정방형) | 근거 노드 |
|---|---|---|---|---|
| small | 40 | 6 / 6 (`p-6`) | 24×24 | `4448:277` |
| medium | 48 | 6 / 6 (`p-6`) | 24×24 | `4448:278` |
| large | 52 | 8 / 6 (`px-6 py-8`) | 36×36 | `4448:279` |

- **corner radius**: 전 size **8** (`rounded-[8px]`), `overflow-clip`(masksToBounds).
- **root gap**: 10 (leading ↔ center ↔ trailing), root `items-center`(세로 중앙 정렬).
- **centerContent**: `flex-1`, `min-w-px`, `pl-2`(좌측 인셋 2).
- **titleRow gap**: 4 (label ↔ centerSlot).
- **leading**: 고정 정방형(위 표). **trailing**: 내용 HUG(고정 크기 없음).
- **description 있을 때 높이(content-driven)**: large+desc = 8+24+16+8 = 56 (인스턴스 `4448:780` 실측). medium+desc = 6+24+16+6 = 52 (**파생 계산** — Figma에 medium+desc 인스턴스 부재, medium padding·description 높이로 산출). minHeight 초과 시 콘텐츠가 높이 결정.

### Anatomy (전 size 공통 — nest 구조)

```
_BaseItem (H, items-center, gap 10, radius 8, overflow-clip, padding[size])
  ├─ leadingContent (고정 정방형 24/24/36)            [optional]
  ├─ centerContent (V, flex-1, min-w-px, pl 2)
  │    ├─ titleRow (H, gap 4, items-center)
  │    │    ├─ label (text/xlarge, 1줄 ellipsis·nowrap)
  │    │    └─ centerSlot                              [optional]
  │    └─ descriptionWrapper (H, items-start)          [optional; small 미지원]
  │         └─ description (caption/medium, wrap)
  └─ trailingContent (HUG, 중앙)                       [optional]
```

> description은 전 size 모두 `centerContent` **내부**에 위치(nest). 루트 `items-center`라 leading/trailing은 항목 전체 높이 기준 세로 중앙.

## 4. Color 토큰 (Figma 사용처 기준)

| 위치 | Token (`BCSemanticToken`) | Figma Variable | Raw |
|---|---|---|---|
| label 텍스트 | `.textNeutral` | `color/text/neutral` | `rgba(0,0,0,0.85)` |
| description 텍스트 | `.textNeutralLighter` | `color/text/neutral/lighter` | `rgba(0,0,0,0.4)` |

> `_BaseItem` 기본 상태는 배경 fill 없음(투명). leadingContent/trailingContent는 슬롯이라 색을 강제하지 않는다(소비 측 책임). Figma 플레이스홀더의 accent 색(red/blue/green)은 슬롯 예시일 뿐 SSOT 아님.

## 5. Typography

### Case A — Typography Token 사용 (전부 토큰)

| 위치 | Token (`BTSemanticToken`) | Figma Style |
|---|---|---|
| label | `.textXLarge(weight: .regular)` | `Typography/text/xlarge` (Inter Regular, size 16, lineHeight 24, letterSpacing `text/letter-spacing/tight` −0.1) |
| description | `.captionMedium(weight: .regular)` | `Typography/caption/medium` (Inter Regular, size 12, lineHeight 16, letterSpacing `caption/letter-spacing` 0) |

> 전 size 라벨 단일 타이포(`text/xlarge`) — size별 분기 없음. letter-spacing은 semantic 토큰에 내장.

### Case B — Custom Typography

없음 (모든 텍스트가 토큰 사용).

## 6. State 별 시각 동작 (Figma)

`_BaseItem` 노드에 state variant 없음 — Figma는 **default 레이아웃 1종만** 정의. 시각 상태 정의는 §7(협의) 참조.

## 7. 인터랙션 (Figma `_BaseItem` 외 · 협의 결정)

> ⚠️ 아래는 Figma `_BaseItem` 노드에 **없다**. 출처: design-team `BaseItem.md` §상태 정의(웹 states) + 구현 협의(MOB-6444). SSOT(Figma `_BaseItem`)의 일부가 아니므로 Color/Noise Validator가 "Figma 외"로 보고하는 것이 정상.

| 상태 | 시각/거동 | 값 |
|---|---|---|
| default | 배경 없음(투명) | — |
| pressed | 배경 오버레이 + 콘텐츠 축소 | 배경 `.fillNeutralLighter` / 콘텐츠 scale `0.97` (release 시 `[0.97, 1.004, 1.0]` 오버슈트 복귀) |
| disabled | 본체 opacity | `BOGlobalToken.disabled` = 0.4 |

- `onTap` 제공 시에만 인터랙티브(pressed 피드백 + 탭). 미제공 시 순수 레이아웃.
- pressed 배경 매핑 근거: 웹 hover/active 배경 = `fill-neutral-lighter`(design-team spec). 모바일엔 hover 없어 pressed로 매핑.
- **press scale 피드백**: 콘텐츠(배경 제외)가 눌림 시 `0.97`로 축소, 뗄 때 살짝 오버슈트하며 복귀 (출처: ch-desk-ios `ListItemPressFeedback`). UIKit은 press-in `UIView.animate`(0.10s) + release `CAKeyframeAnimation`(0.40s, `[0.97,1.004,1.0]`), SwiftUI는 `scaleEffect` + spring. **Reduce Motion 시 비활성**.

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierBaseItem.swift` (`UIControl`, `BezierComponentable`) |
| SwiftUI 구현 | `SUBezierBaseItem.swift` (제네릭 슬롯 `<Leading, CenterAccessory, Trailing>`) |
| size / 상수 / 토큰 매핑 | `BezierBaseItemSpec.swift` (`BezierBaseItemSize`, `BezierBaseItemConstant`) |

> 사용 토큰 실재 확인: `.textNeutral` / `.textNeutralLighter` / `.fillNeutralLighter`(`BCSemanticToken`), `.textXLarge` / `.captionMedium`(`BTSemanticToken`), `BOGlobalToken.disabled`=0.4.

## 9. Figma 참조 노드

- 심볼 세트: `_BaseItem` `4404:11875` (`size=small` 4404:2 / `size=medium` 4404:3 / `size=large` 4404:4)
- 실측 인스턴스: small `4448:277` / medium `4448:278` / large `4448:279` / large+description `4448:780`
