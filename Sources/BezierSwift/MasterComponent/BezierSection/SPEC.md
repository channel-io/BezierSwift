# BezierSection SPEC

> **SSOT**: [Figma · Mobile-Components / Section (4990:10604)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4990-10604) · [Internal/SectionLabel (1856:32)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1856-32)
> **Design spec doc**: [team-design / bezier-v3 / components / Section-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Section-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

모바일에서 관련 콘텐츠를 의미 단위로 묶는 섹션 컨테이너 (Figma component description 1행).

## 1. Component Properties

### Section (CS `4990:10604`)

| Property | 값 | 비고 |
|---|---|---|
| **variant** | `solid` / `card` | 섹션 배경·테두리·radius·행 간 divider 결정 |
| **hasLabel** | BOOLEAN, 기본 `true` | SectionLabel 표시 여부 |
| **content** | SLOT | 리스트 아이템 영역 (solid: `content`, card: `Card > contentSlot`) |
| **hasFooter** / **hasFooterText** / **footerText** / **hasError** | BOOLEAN / BOOLEAN / TEXT / BOOLEAN | CS에 정의되어 있으나 두 variant의 어떤 레이어에도 미배선(unbound) — footer 레이어 자체가 없음. 구현 스코프 제외 (§8.1) |

총 instance: variant 2개 (`solid` = `1268:2`, `card` = `4990:10605`)

### Internal/SectionLabel (CS `1856:32`)

| Property | 값 | 비고 |
|---|---|---|
| **color** | `neutral-dark` / `neutral-light` | 텍스트 색 결정 |
| **hasLeadingContent** | BOOLEAN, 기본 `false` | 좌측 아이콘 슬롯 표시 |
| **hasTrailingContent** | BOOLEAN, 기본 `false` | 우측 액션 영역 표시 |
| **label** | TEXT | 헤더 텍스트 |
| **leadingContent** | SLOT (20×20) | 좌측 아이콘 |
| **trailingContent** | SLOT (높이 20, 우측 정렬) | 우측 액션 |

총 instance: color 2개 (`neutral-dark` = `1856:5`, `neutral-light` = `4276:61232`)

## 2. Layout Spec

### Section 루트 (variant 공통)

| Part | 값 |
|---|---|
| 배치 | 세로 스택: SectionLabel → 콘텐츠 영역 |
| SectionLabel–콘텐츠 간격 | `0pt` |
| 루트 패딩 | 없음 (좌우 패딩은 SectionLabel과 아이템이 각자 보유) |

### variant=solid (`1268:2`)

| Part | 값 |
|---|---|
| 콘텐츠 영역 (`content`) | 투명 배경, 테두리 없음, radius 없음, 패딩 없음 |
| 행 간 divider | 없음 |

### variant=card (`4990:10605`)

콘텐츠 영역은 `Card` 인스턴스(`4990:10631`)다.

| Part | 값 | Figma Variable |
|---|---|---|
| Card 배경 | `surface` | `color/surface` |
| Card 테두리 | `1pt` solid `borderNeutral` | `color/border/neutral` |
| Card radius | `16pt` | `radius/16` |
| Card 패딩 | 상하 `2pt`, 좌우 `0` | — |
| 행 간 divider | `Divider` 인스턴스 — `1pt`, `borderNeutral`, 좌우 인셋 `0`(풀폭), 상하 여백 `0` | `color/border/neutral` |
| divider 개수 | 행 사이에만 (행 n개 → divider n−1개) | — |

### Internal/SectionLabel

| Part | 값 |
|---|---|
| 최소 높이 | `32pt` (min-height — 내용이 크면 성장) |
| 좌우 패딩 | `10pt` |
| radius | `8pt` |
| 루트 gap | `4pt` (leadingCenterWrapper ↔ trailingContent) |
| leadingCenterWrapper 내부 gap | `8pt` (leadingContent ↔ 텍스트) |
| leadingContent 슬롯 | `20×20pt` |
| trailingContent 슬롯 | 높이 `20pt` 래퍼, 우측 정렬, shrink 없음 |
| 텍스트 overflow | 1줄, ellipsis (텍스트만 가변폭) |

## 3. Variant 별 컬러 토큰

### Section

| Variant | 영역 | Token | Figma Variable | Raw |
|---|---|---|---|---|
| `solid` | 콘텐츠 배경 | — *(transparent)* | — | — |
| `card` | Card 배경 | `surface` | `color/surface` | `#FFFFFF` |
| `card` | Card 테두리 | `borderNeutral` | `color/border/neutral` | `#00000014` |
| `card` | 행 간 divider | `borderNeutral` | `color/border/neutral` | `#00000014` |

### SectionLabel 텍스트

| color | Token | Figma Variable | Raw |
|---|---|---|---|
| `neutral-dark` | `textNeutral` | `color/text/neutral` | `#000000D9` |
| `neutral-light` | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| SectionLabel 텍스트 | `BTSemanticToken.textMedium(weight: .bold)` | `Typography/text/medium-bold` (14 / 700 / lh 18 / ls 0) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

Section·SectionLabel 모두 Figma CS에 state variant 축 없음 (정적 컴포넌트).

## 6. 디자이너 가이드라인 (Figma component description 인용)

### Section

- 모바일에서 관련 콘텐츠를 의미 단위로 묶는 섹션 컨테이너. Header + Content + Footer 구조. footer는 Description/Error/SeeMore 배타적 타입. Section 중첩 금지. Description과 Error footer 동시 사용 금지.
  - (구조 실측: 현재 CS의 두 variant에는 footer 레이어가 존재하지 않음 — SectionLabel + 콘텐츠 영역만 존재)

### Internal/SectionLabel

- Used within Section only. Do not place standalone. Section의 정적 헤더 bar. leadingIcon(optional) · 텍스트 · trailing action을 담는다.
- color: neutralDark(--color-text-neutral) / neutralLight(--color-text-neutral-lighter)
- hasLeadingContent: 좌측 아이콘 슬롯 표시 (기본 꺼짐, optional, DES-18872)
- hasTrailingContent: 우측 액션 영역 표시
- label: 헤더 텍스트. Overlay 내부에서는 color=neutralLight를 사용한다.

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 정적 컨테이너 | `BezierSection.swift` |
| SwiftUI 컨테이너 | `SUBezierSection.swift` |
| UIKit SectionLabel | `BezierSectionLabel.swift` |
| SwiftUI SectionLabel | `SUBezierSectionLabel.swift` |
| variant / appearance / constant | `BezierSectionSpec.swift` |
| UIKit 컴포지셔널 레이아웃 지원 | `BezierSectionLayout.swift` |
| 행 간 divider (internal) | `BezierSectionRowDivider.swift` |

## 8. Figma 외 · 협의 사항 (2026-07-24 구조 확정)

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **스코프**: collapsible(web 전용, Mobile CS에 없음)·footer(CS 구조에 레이어 없음)·SectionContent 자식 타입 제약·UITableView 미지원.
2. **UIKit 동적 리스트 = UICollectionViewCompositionalLayout 전용** (`BezierSectionLayout`):
   - 섹션 배경/테두리/radius는 background decoration view 1장. per-section variant는 variant별 decoration elementKind로 전달.
   - `BezierSectionLayout.register(in:)`을 레이아웃 생성 직후 필수 호출 (미등록 시 decoration dequeue 크래시).
   - 행 간 divider는 list separator로 처리 — 셀이 `UICollectionViewListCell`(서브클래스 포함)일 것. 커스텀 콘텐츠 셀은 `separatorLayoutGuide`를 셀 전체 폭에 고정해야 divider 인셋이 그대로 적용된다 (Examples `SectionDemoListCell` 참조).
   - `numberOfItems`는 마지막 행 bottom separator 숨김에 사용. 데이터 변경 시 레이아웃 invalidate는 소비자 책임 (diffable snapshot apply 시 자동).
   - header(SectionLabel)는 높이 32pt 고정 boundary item. decoration이 header 영역을 덮는 동작을 decoration top inset으로 상쇄하므로 label trailing 슬롯 높이는 32pt 초과 금지 (Figma trailing 래퍼도 20pt 고정).
   - 셀 배경은 `UIBackgroundConfiguration.clear()`로 두어야 card decoration이 비쳐 보인다.
   - **componentTheme 지원**: decoration view는 UIKit이 dequeue해 소비자가 직접 주입할 수 없으므로 `makeSection(componentTheme:)` 인자를 variant × theme 조합의 decoration elementKind로 인코딩해 전달한다 (`BezierSectionDecorationKind`, `register(in:)`이 4종 전부 등록). separator 색도 같은 인자로 계산한다. label boundary supplementary는 소비자가 configure 시점에 `sectionLabel.componentTheme`를 직접 설정한다.
3. **SwiftUI = ScrollView + LazyVStack 안에서 쓰는 `SUBezierSection` 컨테이너**, 데이터 주도 init (ForEach 동형). 정적 나열(free `@ViewBuilder`) init은 iOS 16에서 자식 분해에 비공개 API가 필요해 제공하지 않음. lazy 단위는 섹션 — 행이 매우 많은 화면은 UIKit 경로 사용.
4. **행 간 divider 구현**: Figma의 card divider는 `Divider` 컴포넌트 인스턴스(1pt·borderNeutral·인셋 0)다. 구현은 값 소스를 `BezierSectionVariant.Appearance.Divider` 한곳에 두고 정적 컨테이너(internal `BezierSectionRowDivider`)·SwiftUI(Rectangle)·컴포지셔널(`UIListSeparatorConfiguration`) 세 경로가 공유한다.
5. **label 유무 표현**: 코드 API는 `hasLabel` boolean 대신 `labelText: String?`(nil = 미표시) / 컴포지셔널은 `showsLabel: Bool`.

## 9. Variant 매트릭스

```
Section:      variant=solid = 1268:2, variant=card = 4990:10605  (총 2)
SectionLabel: color=neutral-dark = 1856:5, color=neutral-light = 4276:61232  (총 2)
```
