# BezierCollapsibleSection SPEC

> **SSOT**: [Figma · Mobile-Components / CollapsibleSection (4281:36)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4281-36) · [Internal/CollapsibleSectionLabel (4279:6229)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4279-6229)
> **Design spec doc**: [team-design / bezier-v3 / components / CollapsibleSection-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/CollapsibleSection-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

접기/펼치기 가능한 인터랙티브 섹션 컴포넌트 (Figma component description 1행).

## 1. Component Properties

### CollapsibleSection (CS `4281:36`)

| Property | 값 | 비고 |
|---|---|---|
| **open** | `true` / `false` (기본 `true`) | `true`: SectionContent 표시, `false`: 숨김 |
| **SectionContent** | SLOT | 리스트 아이템 영역 (`open=false`에서 hidden) |

총 instance: open 2개 (`true` = `4281:10`, `false` = `4281:23`)

### Internal/CollapsibleSectionLabel (CS `4279:6229`)

| Property | 값 | 비고 |
|---|---|---|
| **color** | `neutral-dark` / `neutral-light` | 텍스트·chevron 색 결정 |
| **open** | `true` / `false` | chevron 방향 결정 |
| **hasLeadingContent** | BOOLEAN, 기본 `false` | 좌측 아이콘 슬롯 표시 |
| **hasTrailingContent** | BOOLEAN, 기본 `false` | 우측 액션 영역 표시 |
| **label** | TEXT | 헤더 텍스트 |
| **leadingContent** | SLOT (20×20) | 좌측 아이콘 |
| **trailingContent** | SLOT (높이 20, 우측 정렬) | 우측 액션 |

총 instance: color 2 × open 2 = 4개

## 2. Layout Spec

### CollapsibleSection 루트

| Part | 값 |
|---|---|
| 배치 | 세로 스택: CollapsibleSectionLabel(header) → SectionContent |
| header–SectionContent 간격 | `0pt` |
| 루트 패딩 / 배경 / 테두리 | 없음 |
| header 폭 | 루트 전체 폭 |
| SectionContent | `open=true`일 때만 표시, 루트 전체 폭 |

### Internal/CollapsibleSectionLabel

| Part | 값 |
|---|---|
| 최소 높이 | `32pt` (min-height — 내용이 크면 성장) |
| 좌우 패딩 | `10pt` |
| radius | `8pt` (`radius/8`) |
| 루트 gap | `4pt` (centerContent ↔ trailingContent) |
| centerContent | flex-1, 내부 gap `8pt`, min-height `24pt` |
| leadingContent 슬롯 | `20×20pt` |
| chevron | `16×16pt`, label 텍스트 바로 우측, 항상 표시 |
| trailingContent 슬롯 | 높이 `20pt` 래퍼, 우측 정렬, shrink 없음 |
| 텍스트 overflow | 1줄, ellipsis (텍스트만 가변폭 HUG) |

## 3. Variant 별 컬러 토큰

open 상태에 따른 컬러 변화 없음 (color variant만 컬러를 결정한다).

### CollapsibleSectionLabel 텍스트

| color | Token | Figma Variable | Raw |
|---|---|---|---|
| `neutral-dark` | `textNeutral` | `color/text/neutral` | `#000000D9` |
| `neutral-light` | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |

### CollapsibleSectionLabel chevron

| color | Token | Figma Variable | Raw |
|---|---|---|---|
| `neutral-dark` | `iconNeutralHeavier` | `color/icon/neutral/heavier` | `#000000D9` |
| `neutral-light` | `iconNeutral` | `color/icon/neutral` | `#00000066` |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| CollapsibleSectionLabel 텍스트 | `BTSemanticToken.textMedium(weight: .bold)` | `Typography/text/medium-bold` (14 / 700 / lh 18 / ls 0) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

| State | 시각 변화 | 비고 |
|---|---|---|
| `open=true` (expanded) | SectionContent 표시. chevron = `chevron-small-down` | Figma description: "open: true(ChevronSmallDown)" |
| `open=false` (collapsed) | SectionContent 숨김. chevron = `chevron-small-right` | Figma description: "false(ChevronSmallRight)" |

CollapsibleSectionLabel CS의 variant 축은 `color` × `open`뿐 — pressed/hover/disabled 시각 variant 없음.

## 6. Asset

| 위치 | 조건 | Figma asset | 코드 자산 |
|---|---|---|---|
| chevron | `open=true` | chevron-small-down 형상 (Figma 렌더는 chevron-small-right 90° 회전 인스턴스) | `BezierIcon.chevronSmallDown` |
| chevron | `open=false` | chevron-small-right 형상 | `BezierIcon.chevronSmallRight` |
| leadingContent 기본 예시 | `hasLeadingContent=true` | `icon/folder` (SLOT 대표 예시 콘텐츠 — 소비자 주입 영역) | 소비자 주입 |
| trailingContent 기본 예시 | `hasTrailingContent=true` | `IconButton` 20×20 (SLOT 대표 예시 콘텐츠 — 소비자 주입 영역) | 소비자 주입 |

## 7. 디자이너 가이드라인 (Figma component description 인용)

### CollapsibleSection

- 접기/펼치기 가능한 인터랙티브 섹션 컴포넌트.
- CollapsibleSectionLabel: color(neutralDark/neutralLight) · leadingIcon · label · trailingContent
- open: true(expanded) / false(collapsed, SectionContent 숨김)
- 정적 그룹핑만 필요하면 Section 사용.

### Internal/CollapsibleSectionLabel

- Used within CollapsibleSection only. Do not place standalone. CollapsibleSection 전용 header bar. SectionLabel과 동일한 머리 영역 역할이며, chevron이 항상 표시된다.
- color: neutralDark(--color-text-neutral) / neutralLight(--color-text-neutral-lighter)
- open: true(ChevronSmallDown) / false(ChevronSmallRight)
- hasLeadingContent / leadingContent: 좌측 아이콘 슬롯 표시 (기본값 false)
- hasTrailingContent / trailingContent: 우측 액션 영역 슬롯 표시
- label: 헤더 텍스트

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **상태 소유**: UIKit `BezierCollapsibleSection`은 `isOpen`을 컴포넌트가 소유하고 헤더 탭 시 스스로 토글 후 `onOpenChange`로 통지한다 (`UISwitch.isOn` 관례). 프로그래매틱 변경은 `isOpen` setter(비애니메이션) 또는 `setOpen(_:animated:)`. SwiftUI `SUBezierCollapsibleSection`은 `Binding<Bool>` 제어형 단일 모드 (SwiftUI 관례 — 소비자가 `@State` 보유).
2. **헤더 pressed 피드백**: Mobile CS에 state 축이 없으나 헤더는 인터랙티브 요소이므로 `BezierBaseItem` pressed 관례와 정렬한다 — pressed 배경 `fillNeutralLighter`(radius 8, full-size 유지) + 콘텐츠 press scale(`BezierPressFeedback`, Reduce Motion 시 생략).
3. **접기/펼치기 애니메이션**: Figma에 명세 없음. UIKit은 `UIView.animate` easeInOut 0.25s로 SectionContent 표시/숨김 + 알파 전환, SwiftUI는 동일 duration의 easeInOut. Reduce Motion 시 애니메이션 생략. chevron은 상태별 아이콘 교체 (회전 애니메이션 명세 없음).
4. **라벨 비공개**: Figma `Internal/` 그룹 + "Do not place standalone" description에 따라 라벨 뷰는 internal (`BezierSectionLabel`이 public인 것은 `BezierSectionLayout` supplementary 구성 요구 때문이며 CollapsibleSection에는 해당 경로가 없음).
5. **Section 패밀리 공유 재사용**: 라벨 color 축은 `BezierSectionLabelColor`, 공통 레이아웃 수치는 `BezierSectionConstant.label*`을 그대로 재사용한다 (composition — Figma 실측상 두 라벨의 레이아웃 수치가 동일). chevron 등 CollapsibleSection 전용 수치만 `BezierCollapsibleSectionConstant`에 둔다.
6. **items API**: `BezierSection`과 동형 — `items` / `setItems(_:)` / `addItem(_:)` (UIKit), 데이터 주도 init (SwiftUI).
7. **라벨 필수**: 헤더는 필수 파트(CS에 hasLabel 축 없음) — `labelText`는 non-optional.
8. **disabled 미제공**: Mobile CS에 disabled variant 없음 — 스타일·API 미제공.

## 9. Variant 매트릭스

```
CollapsibleSection:      open=true = 4281:10, open=false = 4281:23  (총 2)
CollapsibleSectionLabel: color=neutral-dark, open=true  = 4279:7
                         color=neutral-dark, open=false = 4279:16
                         color=neutral-light, open=true  = 4279:25
                         color=neutral-light, open=false = 4279:34  (총 4)
```
