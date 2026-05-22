# BezierTag Spec

> Figma: [🚧 Mobile Components — Tag](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1064-2)
> Design spec doc: [bezier-v3/component-spec/Tag-spec.md](https://github.com/channel-io/design-team/blob/main/docs/bezier-v3/component-spec/Tag-spec.md)

객체(상담·연락처·채팅 등)에 직접 부여하거나 제거할 수 있는 분류 레이블.

- **모양**: Capsule (radius/32 = 32pt, 실제 높이가 32 미만이므로 capsule 형태로 렌더링)
- **인터랙션**: 본체는 읽기 전용. `onDelete = true`일 때 trailing 위치의 × 아이콘이 제거 트리거 역할
- **Badge와의 구분**: 읽기 전용 상태·속성 표시에는 Badge 사용. Tag는 제거 가능한 분류 레이블 의미를 내포

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **Size** | `xsmall` / `small` / `medium` / `large` | 4단계 |
| **Color** | `default` / `red` / `orange` / `yellow` / `olive` / `green` / `cobalt` / `purple` / `pink` / `navy` / `blue` / `teal` | 12가지 |
| **onDelete** | `true` / `false` | `true` 시 trailing 16×16 × 아이콘 노출 (제거 트리거). 기본 `false` (읽기 전용) |
| **label** | string | 분류 레이블 텍스트. Figma의 `"Tag"`는 컴포넌트 preview용 placeholder이며 API default가 아님 |

총 instance: `4 size × 12 color = 48개` (Figma 컴포넌트 인스턴스 수와 일치)

---

## 2. Size 별 Spec

| Size | Height | Horizontal Padding | Vertical Padding | Text Horizontal Padding (TagText 내부) | Close Icon Length |
|---|---|---|---|---|---|
| `xsmall` | 18pt | 4pt | 1pt | 4pt | 16pt |
| `small`  | 22pt | 4pt | 2pt | 4pt | 16pt |
| `medium` | 22pt | 4pt | 2pt | 4pt | 16pt |
| `large`  | 26pt | 4pt | 3pt | 4pt | 16pt |

- **Corner radius**: `radius/32 = 32pt`. height < 32 이므로 capsule 형태로 보임.
- **Min height**: `xsmall`은 `min-h-[16px]` (Figma container에 직접 지정).
- **Layout**: `flex items-center justify-center` — TagText → (optional) close icon 순. content gap 0 (TagText 자체 horizontal padding 4pt가 close icon과의 간격을 만든다).
- **onDelete 시 layout**: trailing close icon 16×16이 추가됨. 컨테이너 horizontal padding 영역 안에는 들어가지 않고, TagText 우측에 인접 배치.

---

## 3. Size 별 Typography

> 📌 **TYPO-MIGRATION** (Figma description 인용): Text Style 미적용 — 로컬 타이포 스타일 등록 시 일괄 바인딩 예정. Figma는 raw value 직접 지정 상태.

| Size | Font Size | Line Height | Letter Spacing | Font Family Variable |
|---|---|---|---|---|
| `xsmall` | 12pt | 16pt | 0 (`text/letter-spacing`) | `text/font-family` (Inter) |
| `small`  | 14pt | 18pt | 0 (`label/letter-spacing`) | `label/font-family` (Inter) |
| `medium` | 15pt | 18pt | -0.1pt (`text/letter-spacing/tight`) | `font-family/sans-kr` (Inter) |
| `large`  | 16pt | 20pt | -0.1pt (`text/letter-spacing/tight`) | `text/font-family` (Inter) |

- Weight: 전부 regular (400).
- Italic: 전부 not-italic.

---

## 4. Color 별 컬러 토큰

### Background (variant 12개)

| Variant | Figma Variable | Raw |
|---|---|---|
| `default` | `color/fill/neutral/light` | `#0000000D` (rgba(0,0,0,0.05)) |
| `red` | `color/fill/accent/red/heavy` | `#E1535D33` |
| `orange` | `color/fill/accent/orange/heavy` | `#E67F2B33` |
| `yellow` | `color/fill/accent/yellow/heavy` | `#EDAE0D33` |
| `olive` | `color/fill/accent/olive/heavy` | `#A9B11033` |
| `green` | `color/fill/accent/green/heavy` | `#20AB5533` |
| `cobalt` | `color/fill/accent/cobalt/heavy` | `#3292E333` |
| `purple` | `color/fill/accent/purple/heavy` | `#8E57E733` |
| `pink` | `color/fill/accent/pink/heavy` | `#D64BB533` |
| `navy` | `color/fill/accent/navy/heavy` | `#424FAB33` |
| `blue` | `color/fill/accent/blue/heavy` | `#6157EA33` |
| `teal` | `color/fill/accent/teal/heavy` | `#09B2AC33` |

### Foreground (text & close icon)

| Variant | Figma Variable | Raw |
|---|---|---|
| (모든 variant 공통) | `color/text/neutral` | `#000000D9` (rgba(0,0,0,0.85)) |

> Tag는 Badge와 달리 모든 variant에서 동일한 `color/text/neutral` foreground를 사용한다. 배경색은 variant별로 다르지만 텍스트와 close 아이콘 색은 단일.

---

## 5. State

해당 없음. Tag 컴포넌트는 state property를 갖지 않는다 (default/pressed/active/disabled/loading 분기 없음). 단, `onDelete = true` 시 trailing close 아이콘이 노출되며 이 아이콘이 제거(remove) 동작의 트리거가 된다.

---

## 6. Close Icon (onDelete = true 시)

| Spec | 값 |
|---|---|
| Size | 16pt × 16pt |
| 자산 | Figma `data-name="icon/cancel-small"` → 코드 매핑 `BezierIcon.cancelSmall` (rawValue `"icon-cancel-small"`) |
| 색 | `color/text/neutral` (변동 없음, foreground와 동일) |
| 배치 | TagText 우측. TagText horizontal padding(4pt)이 시각적 간격 역할 |

- `onDelete = false`일 때는 close icon 영역이 layout에 포함되지 않는다 (컨테이너 width 변동).
- 자산은 Figma SSOT(cancel-small)와 동일해야 한다. SF Symbol(`xmark`) 등 임의 fallback 금지.

---

## 7. 디자이너 가이드라인 (Figma component description 인용)

- **variant 의미**: 의미 구분이 필요하면 variant 색상 지정. 동일 레벨의 태그는 `default`로 통일.
- **onDelete**: `false` = 읽기 전용. `true` = 우측 × 아이콘으로 직접 제거 가능.
- **Badge와의 구분**: 읽기 전용 상태·속성 표시에는 Badge 사용. Tag는 제거 가능한 분류 레이블 의미를 내포함.

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierTag.swift` |
| SwiftUI 구현 | `SUBezierTag.swift` |
| Size / Variant enum | `BezierTagSpec.swift` |
| 색상 토큰 (semantic) | `Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift` |
| 타이포 토큰 (semantic) | `Sources/BezierSwift/Foundation/Typography/V3/BTSemanticToken.swift` |
| Close icon 자산 | `Sources/BezierSwift/Icons/BezierIcon.swift` (`BezierIcon.cancelSmall`) |

> ⚠️ **Typography 매핑 정책 (TYPO-MIGRATION 진행 중 잠정 매핑)**: Figma component description의 `📌 TYPO-MIGRATION: Text Style 미적용 — 로컬 타이포 스타일 등록 시 일괄 바인딩 예정`에 따라, Figma는 현재 raw value를 직접 박아놓은 상태다.
>
> **현재 정책**: Figma SSOT를 우선시한다. `BTSemanticToken`의 case 중 Figma raw와 정확히 일치하는 것이 있더라도 일관성을 위해 **모든 size에서 raw 값을 직접 사용**한다.
>
> | Size | Figma raw (FS/LH/LS) |
> |---|---|
> | xsmall | 12 / 16 / 0 |
> | small | 14 / 18 / 0 |
> | medium | 15 / 18 / -0.1 |
> | large | 16 / 20 / -0.1 |
>
> **TODO**: 디자인팀의 TYPO-MIGRATION (로컬 typography style 일괄 바인딩) 완료 후 raw 값과 token이 정합되면 `BTSemanticToken` 기반 API로 통합 예정.

---

## 9. Variant 매트릭스

총 instance: `4 size × 12 color = 48개`

```text
Size=xsmall, Color=default = 1730:2
Size=xsmall, Color=red     = 1730:5
Size=xsmall, Color=orange  = 1730:8
Size=xsmall, Color=yellow  = 1730:11
Size=xsmall, Color=olive   = 1730:14
Size=xsmall, Color=green   = 1730:17
Size=xsmall, Color=cobalt  = 1730:20
Size=xsmall, Color=purple  = 1730:23
Size=xsmall, Color=pink    = 1730:26
Size=xsmall, Color=navy    = 1730:29
Size=xsmall, Color=blue    = 1731:42
Size=xsmall, Color=teal    = 1731:58

Size=small, Color=default  = 1730:32
Size=small, Color=red      = 1730:35
Size=small, Color=orange   = 1730:38
Size=small, Color=yellow   = 1730:41
Size=small, Color=olive    = 1730:44
Size=small, Color=green    = 1730:47
Size=small, Color=cobalt   = 1730:50
Size=small, Color=purple   = 1730:53
Size=small, Color=pink     = 1730:56
Size=small, Color=navy     = 1730:59
Size=small, Color=blue     = 1731:46
Size=small, Color=teal     = 1731:62

Size=medium, Color=default = 1730:62
Size=medium, Color=red     = 1730:65
Size=medium, Color=orange  = 1730:68
Size=medium, Color=yellow  = 1730:71
Size=medium, Color=olive   = 1730:74
Size=medium, Color=green   = 1730:77
Size=medium, Color=cobalt  = 1730:80
Size=medium, Color=purple  = 1730:83
Size=medium, Color=pink    = 1730:86
Size=medium, Color=navy    = 1730:89
Size=medium, Color=blue    = 1731:50
Size=medium, Color=teal    = 1731:66

Size=large, Color=default  = 1730:92
Size=large, Color=red      = 1730:95
Size=large, Color=orange   = 1730:98
Size=large, Color=yellow   = 1730:101
Size=large, Color=olive    = 1730:104
Size=large, Color=green    = 1730:107
Size=large, Color=cobalt   = 1730:110
Size=large, Color=purple   = 1730:113
Size=large, Color=pink     = 1730:116
Size=large, Color=navy     = 1730:119
Size=large, Color=blue     = 1731:54
Size=large, Color=teal     = 1731:70
```
