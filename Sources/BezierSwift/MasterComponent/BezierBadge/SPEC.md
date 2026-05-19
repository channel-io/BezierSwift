# BezierBadge Spec

> Figma: [🚧 Mobile Components — Badge](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1729-170)
> Design spec doc: [bezier-v3/component-spec/Badge-spec.md](https://github.com/channel-io/design-team/blob/main/docs/bezier-v3/component-spec/Badge-spec.md)

목록·카드 UI에서 항목의 상태나 속성을 색상과 텍스트로 즉각 전달하는 인라인 레이블.

- **모양**: Capsule (radius/32 = 32pt, 실제 높이가 32 미만이므로 capsule 형태로 렌더링)
- **읽기 전용**: Badge는 항상 읽기 전용. 사용자가 제거할 수 있다면 Tag를 사용한다.
- **인터랙션 없음**: state property 없음 (default/pressed/active/disabled 분기 없음)

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **Size** | `xsmall` / `small` / `medium` / `large` | 4단계 |
| **Color** | `default` / `monochrome-light` / `monochrome-dark` / `blue` / `cobalt` / `teal` / `green` / `olive` / `pink` / `navy` / `yellow` / `orange` / `red` / `purple` | 14가지 |
| **hasIcon** | `true` / `false` | 옵션. true 시 leading icon 표시 |
| **iconSource** | slot (ReactNode) | leading icon 본체. `hasIcon = true`일 때 렌더. 사이즈 16×16 |
| **label** | string | 디자인 시스템 콘텐츠 (placeholder default 없음). Figma의 `"Badge"`는 컴포넌트 preview용 placeholder이며 API default가 아님 |

총 instance: `4 size × 14 color = 56개` (Figma 컴포넌트 인스턴스 수와 일치)

---

## 2. Size 별 Spec

| Size | Height | Horizontal Padding | Vertical Padding | Text Horizontal Padding (BadgeText 내부) | Icon Length |
|---|---|---|---|---|---|
| `xsmall` | 18pt | 4pt | 1pt | 4pt | 16pt |
| `small`  | 22pt | 4pt | 2pt | 4pt | 16pt |
| `medium` | 22pt | 4pt | 2pt | 4pt | 16pt |
| `large`  | 26pt | 4pt | 3pt | 4pt | 16pt |

- **Corner radius**: `radius/32 = 32pt`. height < 32 이므로 capsule 형태로 보임.
- **Min width**: container `justify-center`이며 padding 외 최소 폭 제약 없음. xsmall은 `min-h-[16px]` (Figma container에 직접 지정).
- **Layout**: `flex items-center justify-center` — leading icon → BadgeText 순. content gap 0 (BadgeText가 자체 horizontal padding으로 간격을 만든다).

---

## 3. Size 별 Typography

> 📌 **TYPO-MIGRATION** (Figma description 인용): Text Style 미적용 — 로컬 타이포 스타일 등록 시 일괄 바인딩 예정. Figma는 raw value 직접 지정 상태.

| Size | Font Size | Line Height | Letter Spacing | Font Family |
|---|---|---|---|---|
| `xsmall` | 12pt | 16pt | 0 | `text/font-family` (Inter) |
| `small`  | 14pt | 18pt | 0 | `label/font-family` (Inter) |
| `medium` | 15pt | 18pt | 0 | `label/font-family` (Inter) |
| `large`  | 16pt | 20pt | -0.1pt (`text/letter-spacing/tight`) | `font-family/sans-kr` (Inter) |

- Weight: 전부 regular (400).
- Italic: 전부 not-italic.

---

## 4. Color 별 컬러 토큰

### Background

| Variant | Figma Variable | Raw |
|---|---|---|
| `default` | `color/fill/neutral/light` | `#0000000D` (rgba(0,0,0,0.05)) |
| `monochrome-light` | `color/fill/neutral/light` | `#0000000D` |
| `monochrome-dark` | `color/fill/neutral/heavier` | `#00000066` (rgba(0,0,0,0.4)) |
| `blue` | `color/fill/accent/blue/heavy` | `#6157EA33` |
| `cobalt` | `color/fill/accent/cobalt/heavy` | `#3292E333` |
| `teal` | `color/fill/accent/teal/heavy` | `#09B2AC33` |
| `green` | `color/fill/accent/green/heavy` | `#20AB5533` |
| `olive` | `color/fill/accent/olive/heavy` | `#A9B11033` |
| `pink` | `color/fill/accent/pink/heavy` | `#D64BB533` |
| `navy` | `color/fill/accent/navy/heavy` | `#424FAB33` |
| `yellow` | `color/fill/accent/yellow/heavy` | `#EDAE0D33` |
| `orange` | `color/fill/accent/orange/heavy` | `#E67F2B33` |
| `red` | `color/fill/accent/red/heavy` | `#E1535D33` |
| `purple` | `color/fill/accent/purple/heavy` | `#8E57E733` |

### Foreground (text & icon)

| Variant | Figma Variable | Raw |
|---|---|---|
| `default` | `color/text/neutral` | `#000000D9` (rgba(0,0,0,0.85)) |
| `monochrome-light` | `color/text/neutral/lighter` | `#00000066` |
| `monochrome-dark` | `color/text/absolute/white` | `#FFFFFF` |
| `blue` | `color/text/accent/blue` | `#6157EA` |
| `cobalt` | `color/text/accent/cobalt` | `#3292E3` |
| `teal` | `color/text/accent/teal` | `#09B2AC` |
| `green` | `color/text/accent/green` | `#20AB55` |
| `olive` | `color/text/accent/olive` | `#A9B110` |
| `pink` | `color/text/accent/pink` | `#D64BB5` |
| `navy` | `color/text/accent/navy` | `#424FAB` |
| `yellow` | `color/text/accent/yellow` | `#EDAE0D` |
| `orange` | `color/text/accent/orange` | `#E67F2B` |
| `red` | `color/text/accent/red` | `#E1535D` |
| `purple` | `color/text/accent/purple` | `#8E57E7` |

---

## 5. State

해당 없음. Badge는 항상 읽기 전용이며 default/pressed/active/disabled/loading state property가 존재하지 않는다.

---

## 6. 디자이너 가이드라인 (Figma component description 인용)

- **상태 의미**: `green`=성공·활성 / `red`=오류·긴급 / `orange`=경고 / `blue`=정보·진행 / `monochrome-light`=비활성·초안
- **읽기 전용**: 사용자가 제거할 수 있으면 Tag 사용. Badge는 항상 읽기 전용.

---

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierBadge.swift` |
| SwiftUI 구현 | `SUBezierBadge.swift` |
| Size / Variant enum | `BezierBadgeSpec.swift` |
| 색상 토큰 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` |
| 타이포 토큰 (semantic) | `Sources/BezierSwift/Foundation/Typography/V3/BTSemanticToken.swift` |

> ⚠️ **Typography 매핑 정책 (TYPO-MIGRATION 진행 중 잠정 매핑)**: Figma component description의 `📌 TYPO-MIGRATION: Text Style 미적용 — 로컬 타이포 스타일 등록 시 일괄 바인딩 예정`에 따라, Figma는 현재 raw value를 직접 박아놓은 상태다.
>
> **현재 정책**: Figma SSOT를 우선시한다. `BTSemanticToken`의 case 중 Figma raw와 정확히 일치하는 것이 있더라도 일관성을 위해 **모든 size에서 raw 값을 직접 사용**한다. 일치하지 않는 medium/large는 token이 아닌 raw로 처리.
>
> | Size | Figma raw (FS/LH/LS) | 가장 가까운 token (참고용) | Token 정합성 |
> |---|---|---|---|
> | xsmall | 12 / 16 / 0 | `.textXSmall(.regular)` (12 / 16 / 0) | ✅ 일치 (참고) |
> | small | 14 / 18 / 0 | `.textMedium(.regular)` (14 / 18 / 0) | ✅ 일치 (참고) |
> | medium | 15 / 18 / 0 | `.textLarge(.regular)` (15 / 20 / -0.1) | ⚠️ lineHeight·spacing 불일치 |
> | large | 16 / 20 / -0.1 | `.textXLarge(.regular)` (16 / 24 / -0.1) | ⚠️ lineHeight 불일치 |
>
> **TODO**: 디자인팀의 TYPO-MIGRATION (로컬 typography style 일괄 바인딩) 완료 후 raw 값과 token이 정합되면 `BTSemanticToken` 기반 API로 통합 예정.

---

## 8. Variant 매트릭스

총 instance: `4 size × 14 color = 56개`

```
Size=xsmall, Color=default          = 1729:2
Size=xsmall, Color=monochrome-light = 1729:41
Size=xsmall, Color=monochrome-dark  = 1729:38
Size=xsmall, Color=blue             = 1729:5
Size=xsmall, Color=cobalt           = 1729:8
Size=xsmall, Color=teal             = 1729:11
Size=xsmall, Color=green            = 1729:14
Size=xsmall, Color=olive            = 1729:17
Size=xsmall, Color=pink             = 1729:20
Size=xsmall, Color=navy             = 1729:23
Size=xsmall, Color=yellow           = 1729:26
Size=xsmall, Color=orange           = 1729:29
Size=xsmall, Color=red              = 1729:32
Size=xsmall, Color=purple           = 1729:35

Size=small, Color=default           = 1729:44
... (각 색상별 14 instance, 동일 패턴)
Size=small, Color=monochrome-light  = 1729:83
Size=small, Color=monochrome-dark   = 1729:80

Size=medium, Color=default          = 1729:86
... (각 색상별 14 instance, 동일 패턴)
Size=medium, Color=monochrome-light = 1729:125
Size=medium, Color=monochrome-dark  = 1729:122

Size=large, Color=default           = 1729:128
... (각 색상별 14 instance, 동일 패턴)
Size=large, Color=monochrome-light  = 1729:167
Size=large, Color=monochrome-dark   = 1729:164
```
