# BezierSelect SPEC

> **SSOT**: [Figma · Mobile-Components / Select (4870:581)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4870-581) · [Internal/SelectOption (4670:92)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4670-92) · [Internal/SelectGroup (4648:129)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4648-129) · [Internal/SelectGroupLabel (4371:28)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4371-28)
> **Design spec doc**: [team-design / bezier-v3 / components / Select-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Select-spec.md) · [BaseOverlay.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseOverlay.md) · [BaseItem.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseItem.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

미리 정의된 선택지 중 하나를 고르고, 선택된 항목을 우측 체크 아이콘으로 표시하는 단일 선택 리스트 컴포넌트.

## 1. Component Properties

### Select (CS `4870:581`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `container` | VARIANT | page | page / bottomsheet / overlay | `BezierSelectContainer` (§9-2) |
| `hasLabel` | BOOLEAN | false | on / off | 라벨 유무 (`container=page`에서만 렌더) |
| `content` | SLOT (`1460:39`) | — | `Internal/SelectGroup` 배치 (preferredValues) | content |

총 instance: `container(3) = 3개`

### Internal/SelectGroup (COMPONENT `4648:129`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `hasLabel` | BOOLEAN | false | on / off | 그룹 라벨 유무 (복수 그룹일 때만 켠다) |
| `showDivider` | BOOLEAN | false | on / off | 그룹 하단 구분선 |
| `content` | SLOT (`4648:132`) | — | `Internal/SelectOption` 배치 | options |

단일 COMPONENT — variant 축 없음. 라벨 텍스트 편집은 내부 `Internal/SelectGroupLabel` 인스턴스 프로퍼티로 (CS 레벨 label TEXT prop 없음).

### Internal/SelectGroupLabel (CS `4371:28`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `color` | VARIANT | neutral-light | `neutral-dark` (`4371:24`) / `neutral-light` (`4371:26`) | 텍스트 색. `Internal/SelectGroup` 내부 인스턴스도 `neutral-light` |
| `label` | TEXT | "Group Label" | 문자열 | labelText |

총 instance: `color(2) = 2개`

### Internal/SelectOption (CS `4670:92`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `leadingType` | VARIANT | none | none / icon / avatar / custom | `BezierSelectOptionLeading` |
| `state` | VARIANT | default | default / pressed / disabled | 인터랙션 상태 (§5) |
| `content` | TEXT | "Option" | 문자열 | title |
| `hasDescription` | BOOLEAN | false | on / off | description 유무 |
| `description` | TEXT | "Description" | 문자열 | description |
| `hasCenterSlot` | BOOLEAN | false | on / off | centerSlot 유무 |
| `centerSlot` | SLOT | — | 임의 콘텐츠 | centerSlot |
| `isSelected` | BOOLEAN | false | on / off | true면 trailing 체크 아이콘 표시 |
| `leadingIconSource` | INSTANCE_SWAP | icon/plus | 아이콘 인스턴스 (leadingType=icon) | `.icon(BezierIcon)` |
| `leadingContent` | SLOT | — | 임의 콘텐츠 (leadingType=custom) | `.custom(뷰)` |

총 instance: `leadingType(4) × state(3) = 12개`

## 2. Layout Spec

### Select 루트

| container | 값 |
|---|---|
| `page` (`1331:3`) | 세로 스택, gap `0` · padding `0` · 폭 FILL (마스터 목업 폭 `360pt`). `hasLabel` 라벨 → content 순 |
| `bottomsheet` (`4903:2464`) | `BottomSheet`(`1306:200`) 인스턴스 `360×667pt`. 시트 content 슬롯 padding 상 `12pt` / 좌우 `10pt` |
| `overlay` (`5150:1162`) | `overlay`(`5078:2253`) 인스턴스 — 폭 `240pt` FIXED · padding `10pt` 균일 · corner radius `32pt`(`radius/32`) · content 폭 `220pt` |

`container=page`의 `hasLabel` 라벨은 `Internal/SelectGroupLabel` 인스턴스이며 루트 기준 x=`10pt`, 폭 `340pt`(= 360 − 10×2)로 배치된다.

### Internal/SelectGroup

| Part | 값 |
|---|---|
| 배치 | 세로 스택: GroupLabel(optional) → content → divider(optional), gap `0` |
| 폭 | 마스터 `260pt` (사용처에서 FILL) |
| divider | `Divider` 인스턴스 — 선 `1pt` × 폭 FILL, 좌우 인셋 `6pt`, 상하 여백 `6pt` (총 높이 13pt) |

### Internal/SelectGroupLabel

| Part | 값 |
|---|---|
| 높이 | 마스터(`4371:28`)와 `container=page` 사용처(`1331:11`)는 min-height `32pt` + HUG. `Internal/SelectGroup` 내부 인스턴스(`4648:130`)만 FIXED `32pt`로 오버라이드 |
| 좌우 패딩 | `10pt` |
| corner radius | `8pt` |
| 텍스트 overflow | 1줄, ellipsis |

### Internal/SelectOption

| Part | 값 |
|---|---|
| min height | `48pt`. description 시 콘텐츠 기반으로 늘어나며 Figma 인스턴스 실측은 `55pt`(= 8+24+15+8) — 여기서 15는 description 텍스트 노드의 glyph box 높이이고, 바인딩된 `caption/line-height/medium`은 `16`이다. line-height 기준으로는 `56pt`(= 8+24+16+8)이며 구현은 이쪽을 따른다(§9-12) |
| padding | 상하 `8pt` / 좌우 `10pt` |
| corner radius | `16pt` (`radius/16`), overflow clip |
| 루트 gap | `10pt` (contentWrapper ↔ check 아이콘), 세로 중앙 정렬 |
| labelWrapper gap | `10pt` (leading ↔ centerContent) — `leadingType≠none`일 때만 |
| labelRow gap | `4pt` (label ↔ centerSlot) |
| leading | `24×24pt` 정방형 (icon / avatar / custom 공통) |
| centerContent 좌측 인셋 | `0` |
| centerSlot | 폭 HUG × 높이 FIXED, 세로 중앙. **Figma 실측값**: `state=default` `24pt`(y=0) / `state=pressed`·`disabled` `18pt`(y=3) — 세 state의 나머지 지오메트리는 동일하다. **구현은 24pt 고정**(§9-5). 이 행은 Figma 거울이므로 구현값이 아니라 실측값을 적는다 |
| check 아이콘 | `24×24pt`, 세로 중앙 (`isSelected=true`일 때만) |
| description 들여쓰기 | `leadingType≠none`이면 `34pt`(= 24 + 10), `none`이면 `0` |
| label overflow | 1줄 (Figma nowrap — 구현은 truncate) |

## 3. 컬러 토큰 (Figma 사용처 기준)

### Select / overlay (container=overlay)

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| overlay 배경 | `surfaceHighest` | `color/surface/highest` | `#FFFFFF` |
| overlay shadow | `elevationLarge` | `color/elevation/large` | `#00000038` |

`container=page`에는 컬러 레이어 없음 — 순수 레이아웃 컨테이너.

### Internal/SelectGroup

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| divider 선 | `borderNeutral` | `color/border/neutral` | `#00000014` |

### Internal/SelectGroupLabel

| color | Token | Figma Variable | Raw |
|---|---|---|---|
| `neutral-light` | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| `neutral-dark` | `textNeutral` | `color/text/neutral` | `#000000D9` |

### Internal/SelectOption

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| label 텍스트 | `textNeutral` | `color/text/neutral` | `#000000D9` |
| description 텍스트 | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| leading 아이콘 (leadingType=icon) | `iconNeutralHeavy` | `color/icon/neutral/heavy` | `#00000099` |
| check 아이콘 (isSelected) | `iconNeutralHeavier` | — *(변수 바인딩 없음)* | `#000000D9` (§9-6) |

| state | 배경 | 기타 |
|---|---|---|
| default | 없음 (투명) | — |
| pressed | `fillNeutralLighter` (`color/fill/neutral/lighter`, `#00000008`) | — |
| disabled | 없음 | 본체 opacity `opacity/disabled` = 0.4 |

## 4. Typography

### Case A — Typography Token 사용 (전부 토큰)

| 위치 | Token (`BTSemanticToken`) | Figma Style |
|---|---|---|
| option label | `.textXLarge(weight: .regular)` | `Typography/text/xlarge` (Inter Regular, size 16, lineHeight 24, letterSpacing `text/letter-spacing/tight` −0.1) |
| option description | `.captionMedium(weight: .regular)` | `Typography/caption/medium` (Inter Regular, size 12, lineHeight 16, letterSpacing `caption/letter-spacing` 0) |
| group label | `.textMedium(weight: .bold)` | `Typography/text/medium-bold` (Inter Bold, size 14, lineHeight 18, letterSpacing `text/letter-spacing` 0) |

### Case B — Custom Typography

없음 (모든 텍스트가 토큰 사용).

## 5. State 별 시각 동작 (Internal/SelectOption)

| State | 시각 변화 | 인터랙션 |
|---|---|---|
| `default` | 배경 없음 | 활성 |
| `pressed` | 배경 `fillNeutralLighter` | 활성 (탭 진행 중) |
| `disabled` | 본체 opacity 0.4, 배경 없음 | 입력 차단 |

`isSelected`는 state와 독립된 BOOLEAN 축이며, true일 때 trailing에 check 아이콘이 추가된다 (세 state 모두에서 동작).

Select / Internal/SelectGroup / Internal/SelectGroupLabel에는 state variant 축 없음 (정적 컨테이너).

## 6. Elevation

| Effect Style | 구성 |
|---|---|
| `Elevation/Mobile/3` (container=overlay의 overlay 인스턴스) | DROP_SHADOW · color `color/elevation/large` · offset (0, `elevation/4` = 4) · blur `elevation/20` = 20 · spread 0 |

`container=page`·`container=bottomsheet`의 Select 루트 자체에는 elevation 없음 (bottomsheet의 그림자는 `BottomSheet` 쉘 소유).

## 7. 디자이너 가이드라인 (Figma component description 인용)

### Select (`4870:581`)

- Select 옵션 목록을 BottomSheet 또는 Overlay로 띄워서 제공하거나, 인라인으로 배치한다.
- `container`: page(인라인 목록 직접 배치) / bottomsheet(BottomSheet로 present) / overlay(앵커형 팝오버로 present — backdrop 없는 floating 카드).
- `hasLabel`: 그룹 레이블 표시 여부. `content`: 옵션 목록 슬롯 (SelectOption 사용).
- bottomsheet 사용 시 BottomSheet(Header=false, ContentFooter=false)를 present한다. overlay 사용 시 Overlay 컴포넌트 인스턴스 안에 SelectGroup을 배치해 present한다(backdrop 없음, 태블릿·넓은 화면 등 앵커 기반 맥락).
- 단일 선택이므로 확인 버튼 없이 항목 선택 즉시 반영.
- (`container=page`/`bottomsheet`/`overlay` 각 variant description) 항목 선택이 값 표시가 아니라 액션 실행이면 DropdownMenu. (DES-18468) 다중 선택이 필요하면 MultiSelect 사용.

### Internal/SelectGroup (`4648:129`)

- Used within Select only. Do not place standalone. Select 옵션을 카테고리별로 묶는 그룹 컨테이너.
- `hasLabel`: 그룹 라벨 표시 여부 (기본 false, 복수 그룹일 때만 켠다).
- `showDivider`: true 시 그룹 하단에 구분선 표시.
- 단일 그룹일 때는 SelectGroup 없이 SelectOption을 직접 나열할 것.

### Internal/SelectOption (`4670:92`)

- Used within Select only. Do not place standalone. 단일 선택 드롭다운의 개별 선택지 아이템.
- `leadingType`: none(텍스트 전용) / icon / avatar / custom(SLOT).
- `isSelected=true` 시 trailing 체크아이콘 자동 표시.
- `hasDescription=true` 시 높이 자동 확장.

### overlay (`5078:2253` — container=overlay가 내장하는 쉘)

- position 기본 bottom-start, 트리거와 8px 간격, 화면 밖이면 flip, 가장자리 마진 16px (코드 구현 참고용) · backdrop 없음 · 외부 탭 시 닫힘 · 드래그 딜미스 없음.

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 컨테이너 | `BezierSelect.swift` |
| UIKit 그룹 | `BezierSelectGroup.swift` |
| UIKit 옵션 | `BezierSelectOption.swift` |
| SwiftUI 컨테이너 | `SUBezierSelect.swift` |
| SwiftUI 그룹 | `SUBezierSelectGroup.swift` |
| SwiftUI 옵션 | `SUBezierSelectOption.swift` |
| container / leading / constant | `BezierSelectSpec.swift` |

> 재사용 심볼 실재 확인: `BezierOverlay` / `SUBezierOverlay` / `BezierOverlayConstant`(width 240 · padding 10 · cornerRadius 32 · elevation `.mEv3`), `BezierBaseItem` / `SUBezierBaseItem` / `BezierBaseItemStyle`(레이아웃·pressed 배경·press scale·disabled opacity), `BezierSectionLabel` / `SUBezierSectionLabel` + `BezierSectionLabelColor.neutralLight`(그룹 라벨 — 높이 32·좌우 패딩 10·radius 8·`.textMedium(weight: .bold)`·`textNeutralLighter`로 Figma GroupLabel과 동일), `BezierDivider` / `SUBezierDivider` + `BezierDividerConstant`(indentSize 6 · lineThickness 1), `BCSemanticToken`(.textNeutral / .textNeutralLighter / .iconNeutralHeavy / .iconNeutralHeavier / .fillNeutralLighter / .surfaceHighest / .borderNeutral), `BTSemanticToken`(.textXLarge / .captionMedium / .textMedium), `BOGlobalToken.disabled` = 0.4, `BezierIcon.check`.

## 9. Figma 외 · 협의 사항 (구현 결정)

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **컴포지션 구조 (MOB-6353 핸드오프)**: SelectOption은 `BezierBaseItem`/`SUBezierBaseItem`을 소유(composition)해 구현한다 (상속 금지 — 채널 정석). 오버레이 패널은 `BezierOverlay`/`SUBezierOverlay` 재사용, 그룹 라벨은 `BezierSectionLabel(color: .neutralLight)` 재사용, 그룹 divider는 `BezierDivider()` 재사용.
2. **`container=bottomsheet` 미구현**: BezierSwift에는 Figma `BottomSheet`(`1306:200`)에 대응하는 쉘 컴포넌트가 없다(`MasterComponent/` 전수 확인). 해당 variant의 Select 콘텐츠는 `container=page`와 동일한 인라인 리스트이므로, 코드 API의 `BezierSelectContainer`는 `page`/`overlay` 2종만 제공하고 bottom sheet 호스팅은 사용처 책임으로 둔다 (design doc §7 [Mobile] 반응형 "Select가 BottomSheet의 content로 호스팅됨"과 동일 모델).
3. **BaseItem 내부 스타일 주입**: Figma SelectOption은 BaseItem `medium` 기본값 대비 좌우 패딩 10(↔6)·상하 패딩 8(↔6)·corner radius 16(↔8)·center 좌측 인셋 0(↔2)이 다르다. 이를 위해 internal `BezierBaseItemStyle`에 값을 주입한다 — 상하 패딩 축(`verticalPadding`)은 기존 struct에 없어 옵셔널 필드로 추가하되 `nil`이면 기존 `size.verticalPadding`으로 폴백해 기존 소비자(BaseItem·DropdownMenuItem·SectionItem) 동작과 public API를 모두 그대로 둔다.
4. **프레젠테이션 스코프 제외**: 열림/닫힘 상태·앵커 포지셔닝·외부 탭 닫힘은 사용처 책임 (BezierOverlay SPEC §9-1 · BezierDropdownMenu SPEC §9-4와 동일 결정). 선택 상태(`isSelected`)의 단일 선택 보장(하나만 true)도 사용처 책임이다 — Figma는 옵션 단위 BOOLEAN만 정의한다.
5. **centerSlot 높이 24 고정**: Figma는 `state=default`에서 24pt, `pressed`·`disabled`에서 18pt로 centerSlot 프레임 높이가 갈리지만 나머지 지오메트리는 세 state가 완전히 동일하다. 상태에 따라 슬롯 높이가 바뀔 근거가 Figma description·design doc 어디에도 없어 default 값 24pt로 고정 구현한다.
6. **check 아이콘 색 토큰 매핑**: Figma의 check 인스턴스는 변수 바인딩 없이 raw `#000000D9`로 렌더된다(export SVG의 `fill="black" fill-opacity="0.85"`로 확정, `get_variable_defs` 결과 `{}`). 저장소는 semantic 토큰만 사용하므로 같은 값(light `black85` / dark `white80`)을 갖는 아이콘 계열 토큰 `iconNeutralHeavier`로 매핑한다.
7. **state 축은 런타임 상태**: Figma `state`(default/pressed/disabled)는 API 옵션이 아니라 런타임 인터랙션 상태로 구현 — pressed는 터치 추적, disabled는 UIKit `isEnabled` / SwiftUI `.disabled()`.
8. **pressed press-scale**: BaseItem의 press scale 피드백(0.97, 오버슈트 복귀)을 그대로 상속한다 (BaseItem SPEC §7 협의 — Figma 외).
9. **`hasLabel`/`showDivider`/`has*` boolean 표현**: 코드 API는 `labelText: String?`(nil = 미표시)·`showsDivider: Bool`, 슬롯 계열은 옵셔널/`EmptyView` 분기로 표현 (BezierDropdownMenu §9-7과 동일 관례).
10. **`container=page` 루트 라벨의 10pt 인셋 미적용**: Figma에서 page 루트의 `hasLabel` 라벨 인스턴스(`1331:11`)는 x=10·폭 340으로 배치되고 라벨 자신도 좌우 패딩 10을 가져 텍스트가 x=20에 온다. 반면 같은 루트의 옵션은 x=0·폭 360이고 옵션 자신의 좌우 패딩 10으로 텍스트가 x=10에 온다 — 라벨 텍스트만 10pt 더 들어간다. 구현은 라벨을 폭 FILL로 두어 텍스트를 x=10에 정렬한다. 근거: ① 이 루트 라벨은 Figma에서 기본 hidden이고 ② 실제 사용 경로인 `Internal/SelectGroup`의 라벨 인스턴스(`4648:130`)는 폭 FILL이라 옵션 텍스트와 정확히 정렬되며 ③ 라벨과 옵션 텍스트의 좌측 정렬이 어긋나는 것은 시각 결함이다. 그룹 라벨과 Select 라벨이 같은 x에 오도록 통일한다.
11. **그룹 라벨 높이는 min-height 32 + HUG 하나로 통일**: §2대로 Figma는 `Internal/SelectGroup` 내부 라벨 인스턴스(`4648:130`)만 FIXED 32로 오버라이드하고 마스터·page 사용처는 min-height 32 + HUG다. 재사용하는 `BezierSectionLabel`/`SUBezierSectionLabel`은 맥락 구분 없이 min-height 32 + HUG만 제공하며, 라벨이 1줄 고정(ellipsis)이라 두 경우의 렌더 높이가 32pt로 같다. 구분을 코드에 재현하지 않는다.
12. **description 행 높이는 line-height 16 기준 56pt**: Figma 인스턴스 실측 높이는 55pt지만 이는 description 텍스트 노드가 glyph box(15)로 잡힌 값이고, 노드에 바인딩된 `caption/line-height/medium`은 16이다. iOS는 `BTSemanticToken.captionMedium`의 line-height 16을 그대로 쓰므로 행 높이가 56pt가 된다(시뮬레이터 실측 UIKit·SwiftUI 모두 56.0/56.33pt). 형제 컴포넌트 `BezierDropdownMenu` SPEC도 line-height 16 기준(6+24+16+6=52)으로 기재돼 있다.
13. **`leadingType=avatar`와 `custom`의 렌더 경로 공유**: Figma는 두 축을 분리하지만 레이아웃은 둘 다 24×24 슬롯으로 동일하다. 코드도 두 case를 모두 제공해 Figma 축을 보존하되 렌더는 같은 경로를 쓴다 — case 구분은 "무엇을 넣는가"(Avatar / 임의 뷰)의 문서적 구분이다.

## 10. Variant 매트릭스

```text
Select (4870:581, 3):
  container=page       = 1331:3
  container=bottomsheet = 4903:2464
  container=overlay    = 5150:1162

Internal/SelectGroup      = 4648:129   (총 1 — COMPONENT, property만)
Internal/SelectGroupLabel = color=neutral-dark 4371:24, color=neutral-light 4371:26 (총 2)

Internal/SelectOption (4670:92, 12):
  leadingType=none,   state=default|pressed|disabled = 4669:1714 | 4669:1720 | 4669:1726
  leadingType=icon,   state=default|pressed|disabled = 4669:1732 | 4669:1738 | 4669:1744
  leadingType=avatar, state=default|pressed|disabled = 4669:1750 | 4669:1756 | 4669:1762
  leadingType=custom, state=default|pressed|disabled = 4669:1768 | 4669:1774 | 4669:1780
```
