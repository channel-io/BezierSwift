# BezierMultiSelect SPEC

> **SSOT**: [Figma · Mobile-Components / MultiSelect (4903:6133)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4903-6133) · [Internal/MultiSelectOption (1352:42)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1352-42) · [Internal/MultiSelectGroup (4648:12419)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4648-12419) · [Internal/MultiSelectGroupLabel (4373:20)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4373-20)
> **Design spec doc**: [team-design / bezier-v3 / components / MultiSelect-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/MultiSelect-spec.md) · [BaseOverlay.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseOverlay.md) · [BaseItem.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseItem.md) · [BaseGroupLabel.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseGroupLabel.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

여러 선택지를 동시에 고르고, 선택된 항목마다 우측 체크 아이콘을 표시하는 복수 선택 리스트 컴포넌트.

## 1. Component Properties

### MultiSelect (CS `4903:6133`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `container` | VARIANT | page | page / bottomsheet / overlay | `BezierMultiSelectContainer` — `page`·`overlay`만 제공. **`bottomsheet`는 Figma에만 있고 코드 API에 없다** (§9-2) |
| `hasLabel` | BOOLEAN | false | on / off | 라벨 유무 (`container=page`에서만 렌더) |
| `content` | SLOT | — | `Internal/MultiSelectGroup` / `Internal/MultiSelectOption` 배치 | content |

> §1~§5는 Figma 거울이라 Figma에 존재하는 variant를 모두 싣는다. **"구현 매핑" 열에 미제공이라고 적힌 값은 코드 API에 없다** — 지원 범위는 §9의 구현 결정이 결정한다.

총 instance: `container(3) = 3개`

### Internal/MultiSelectGroup (COMPONENT `4648:12419`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `hasLabel` | BOOLEAN | false | on / off | 그룹 라벨 유무 (복수 그룹일 때만 켠다) |
| `content` | SLOT (`4648:12422`) | — | `Internal/MultiSelectOption` 배치 | options |

단일 COMPONENT — variant 축 없음. 라벨 텍스트 편집은 내부 `Internal/MultiSelectGroupLabel` 인스턴스(`4648:12420`) 프로퍼티로 (CS 레벨 label TEXT prop 없음). **divider 프로퍼티 없음** — component description이 "구분선 미지원 — 필요 시 외부에 Divider 인스턴스를 배치할 것"으로 명시한다.

### Internal/MultiSelectGroupLabel (CS `4373:20`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `color` | VARIANT | neutral-light | `neutral-dark` (`4373:16`) / `neutral-light` (`4373:18`) | 텍스트 색. `Internal/MultiSelectGroup` 내부 인스턴스도 `neutral-light` |
| `label` | TEXT | "Group Label" | 문자열 | labelText |

총 instance: `color(2) = 2개`

### Internal/MultiSelectOption (CS `1352:42`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `leadingType` | VARIANT | none | none / icon / avatar / custom | `BezierMultiSelectOptionLeading` |
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

### MultiSelect 루트

| container | 값 |
|---|---|
| `page` (`1332:3`) | 세로 스택, gap `0` · padding `0` · overflow clip · 폭 FILL (마스터 목업 폭 `360pt`). `hasLabel` 라벨 → content 순 |
| `bottomsheet` (`4903:6058`) | `BottomSheet`(`1306:200`) 인스턴스 `360×667pt`. 시트 content 슬롯 padding 상 `12pt` / 좌우 `10pt`. content = `Internal/MultiSelectGroup`(`340×144`) + `buttonsArea`(`340×72`) |
| `overlay` (`5150:2921`) | `overlay`(`5078:2253`) 인스턴스 — 폭 `240pt` FIXED · padding `10pt` 균일 · corner radius `32pt`(`radius/32`) · content 폭 `220pt`. **footer 없음** |

`container=page`의 `hasLabel` 라벨은 `Internal/MultiSelectGroupLabel` 인스턴스(`1332:11`)이며 폭 FILL로 배치된다.

`hasLabel`은 **`container=page` variant에만 노출된다** — `1332:3`의 property 타입은 `{ container, hasLabel, content }`인데 `5150:2921`(overlay)은 `{ container }`뿐이고 라벨 노드도 없다. overlay·bottomsheet variant는 대신 `Internal/MultiSelectGroup`을 내장하며 그 그룹이 자기 `hasLabel`을 갖는다.

`container=bottomsheet`의 `buttonsArea`(`0:56`)는 Button 인스턴스 2개(각 `166×44pt`)를 gap `8pt`로 가로 배치하며 영역 padding은 상 `12pt` / 하 `16pt` / 좌우 `0`이다. 이 footer는 이 variant에만 있다 (§9-2).

### Internal/MultiSelectGroup

| Part | 값 |
|---|---|
| 배치 | 세로 스택: GroupLabel(optional) → content, gap `0` |
| 폭 | 마스터 `260pt` (사용처에서 FILL) |

### Internal/MultiSelectGroupLabel

| Part | 값 |
|---|---|
| 높이 | min-height `32pt` + HUG |
| 좌우 패딩 | `10pt` |
| corner radius | `8pt` |
| 폭 | 마스터 `260pt`, 사용처 인스턴스(`1332:11` · `4648:12420`)는 FILL |
| 텍스트 overflow | 1줄, ellipsis (`whitespace-nowrap` + `text-ellipsis`) |

### Internal/MultiSelectOption

| Part | 값 |
|---|---|
| min height | `48pt`. description 시 콘텐츠 기반으로 늘어나며 Figma 인스턴스 실측은 `52pt`(= 6+24+16+6) |
| padding | 상하 `6pt` / 좌우 `10pt` |
| corner radius | `16pt` (루트에 clip 없음 — clip은 `centerContent`에만 있다) |
| 루트 gap | `10pt` (contentWrapper ↔ check 아이콘), 세로 중앙 정렬 |
| labelWrapper gap | `10pt` (leading ↔ centerContent) — `leadingType≠none`일 때만 |
| labelRow gap | `4pt` (label ↔ centerSlot) |
| leading | `24×24pt` 정방형 (icon / avatar / custom 공통) |
| centerContent 좌측 인셋 | `0` |
| centerContent | overflow clip |
| centerSlot | 폭 HUG × 높이 FIXED `24pt`, 세로 중앙 |
| check 아이콘 | `20×20pt`, 세로 중앙 (`isSelected=true`일 때만) |
| description 들여쓰기 | `leadingType≠none`이면 `34pt`(= 24 + 10), `none`이면 `0` |
| label overflow | truncation 설정 없음 — 폭 FILL + `word-break: break-word`. 같은 파일의 `Internal/MultiSelectGroupLabel` 텍스트가 `whitespace-nowrap` + `text-ellipsis`를 갖는 것과 대비된다 (구현은 1줄 truncate — §9-12) |

`leadingType=custom` variant만 `labelRow`·`centerSlot` 레이어가 없고 `centerContent`가 label을 직속으로 담는다 — 나머지 9개 variant(`none`/`icon`/`avatar` × 3 state)에만 `labelRow`가 있다 (§9-6).

## 3. 컬러 토큰 (Figma 사용처 기준)

### MultiSelect / overlay (container=overlay)

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| overlay 배경 | `surfaceHighest` | `color/surface/highest` | `#FFFFFF` |
| overlay shadow | `elevationLarge` | `color/elevation/large` | `#00000038` |

`container=page`에는 컬러 레이어 없음 — 순수 레이아웃 컨테이너.

### Internal/MultiSelectGroupLabel

| color | Token | Figma Variable | Raw |
|---|---|---|---|
| `neutral-light` | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| `neutral-dark` | `textNeutral` | `color/text/neutral` | `#000000D9` |

### Internal/MultiSelectOption

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| label 텍스트 | `textNeutral` | `color/text/neutral` | `#000000D9` |
| description 텍스트 | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| leading 아이콘 (leadingType=icon) | `iconNeutralHeavy` | `color/icon/neutral/heavy` | `#00000099` |
| check 아이콘 (isSelected) | `iconNeutralHeavier` | `color/icon/neutral/heavier` | `#000000D9` |

두 아이콘 색은 export SVG로 교차 확인했다 — check `fill="black" fill-opacity="0.85"`, leading `fill="black" fill-opacity="0.6"`.

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

## 5. State 별 시각 동작 (Internal/MultiSelectOption)

| State | 시각 변화 | 인터랙션 |
|---|---|---|
| `default` | 배경 없음 | 활성 |
| `pressed` | 배경 `fillNeutralLighter` | 활성 (탭 진행 중) |
| `disabled` | 본체 opacity 0.4, 배경 없음 | 입력 차단 |

`isSelected`는 state와 독립된 BOOLEAN 축이며, true일 때 trailing에 check 아이콘이 추가된다 (세 state 모두에서 동작). **여러 항목이 동시에 `isSelected=true`일 수 있다.**

MultiSelect / Internal/MultiSelectGroup / Internal/MultiSelectGroupLabel에는 state variant 축 없음 (정적 컨테이너).

## 6. Elevation

| Effect Style | 구성 |
|---|---|
| `Elevation/Mobile/3` (container=overlay의 overlay 인스턴스) | DROP_SHADOW · color `color/elevation/large` · offset (0, `elevation/4` = 4) · blur `elevation/20` = 20 · spread 0 |

`container=page`·`container=bottomsheet`의 MultiSelect 루트 자체에는 elevation 없음 (bottomsheet의 그림자는 `BottomSheet` 쉘 소유).

## 7. 디자이너 가이드라인 (Figma component description 인용)

### MultiSelect (`4903:6133`)

- MultiSelect 옵션 목록을 BottomSheet 또는 Overlay로 띄워서 제공하거나, 인라인으로 배치한다.
- `container`: page(인라인 목록 직접 배치) / bottomsheet(BottomSheet로 present) / overlay(앵커형 팝오버로 present — backdrop 없는 floating 카드).
- `hasLabel`: 그룹 레이블 표시 여부. `content`: 옵션 목록 슬롯 (MultiSelectOption 사용).
- "bottomsheet·overlay 사용 시 모두 variant 자체에 Cancel/Save 2버튼 footer가 네이티브로 내장되어 있다(DL-098). Cancel=선택 취소, Save=선택 일괄 반영." — 이 문장은 `container=overlay` variant(`5150:2921`)의 실제 레이어 구조와 어긋난다. overlay variant에는 footer 노드가 없다 (§9-3).

### container=page (`1332:3`) · container=overlay (`5150:2921`) variant description

- "MultiSelectGroupLabel과 MultiSelectItem 리스트를 묶는 복수 선택 컨테이너. 항목 탭 시 Checkbox 토글. Sheet 내 사용 시 확인 버튼으로 일괄 반영. 단일 선택 컨텍스트에서 사용 금지. 항목 탭 즉시 반영 금지." — "Checkbox 토글"은 CS 레벨 description이 명시한 `DL-011 reversal`(leading Checkbox 폐기, trailing checkIcon으로 일원화)과 어긋나며 레이어에도 Checkbox가 없다 (§9-3).

### Internal/MultiSelectGroup (`4648:12419`)

- Used within MultiSelect only. Do not place standalone. MultiSelect 옵션을 카테고리별로 묶는 그룹 컨테이너. 내부에 MultiSelectGroupLabel 인스턴스 + content SLOT을 포함한다.
- `hasLabel`: 그룹 라벨 표시 여부 (기본 false, 복수 그룹일 때만 켠다).
- 구분선 미지원 — 필요 시 외부에 Divider 인스턴스를 배치할 것.
- 단일 그룹일 때는 MultiSelectGroup 없이 MultiSelectOption을 직접 나열할 것.

### Internal/MultiSelectGroupLabel (`4373:20`)

- Used within MultiSelect only. Do not place standalone. MultiSelect의 오버레이 그룹 헤더. label: string만 받으며 슬롯 없음.
- `color`: neutral-light(기본) / neutral-dark. `label`: 그룹 헤더 텍스트.
- 안티패턴: content ReactNode · help · trailingContent 불가 — 필요 시 SectionLabel 사용.

### Internal/MultiSelectOption (`1352:42`)

- Used within MultiSelect only. Do not place standalone. MultiSelect 내 복수 선택 항목. 우측 checkIcon(selected=true 시 자동)으로 선택 상태 표시. Checkbox leading 폐기(DL-011 reversal).
- `leadingType`: none / icon / avatar / custom.
- `state`: Figma 전용 프로퍼티(코드 prop 아님). default / pressed / disabled.
- `selected`: false / true — trailing checkIcon 자동 제어.
- `hasDescription`: true 시 하단 보조 텍스트 표시.

### overlay (`5078:2253` — container=overlay가 내장하는 쉘)

- width: content SLOT에 맞춰 HUG, min 160 / max 280px 클램프 · position 기본 bottom-start, 트리거와 8px 간격, 화면 밖이면 flip, 가장자리 마진 16px (코드 구현 참고용) · backdrop 없음 · 외부 탭 시 닫힘 · 드래그 딜미스 없음.
- Mobile Select/MultiSelect의 container=overlay variant가 backdrop 없는 앵커형 팝오버로 옵션 목록을 표시할 때 이 셸을 내장한다.

> **폭 값 충돌 아님 — 대상이 다르다.** 위 `HUG 160~280px`는 **쉘 컴포넌트 단독(`5078:2253`)의 description 문구**다. `container=overlay`(`5150:2921`)가 실제로 내장한 인스턴스는 §2 실측대로 **폭 `240pt` FIXED**(content `220pt`)이고, 구현 계약도 이쪽이다(`BezierOverlayConstant.width = 240`). 이 절은 description 인용이므로, 레이아웃 값이 §2와 다를 때는 **§2 실측이 우선한다** (§9-15).

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 컨테이너 | `BezierMultiSelect.swift` |
| UIKit 그룹 | `BezierMultiSelectGroup.swift` |
| UIKit 옵션 | `BezierMultiSelectOption.swift` |
| SwiftUI 컨테이너 | `SUBezierMultiSelect.swift` |
| SwiftUI 그룹 | `SUBezierMultiSelectGroup.swift` |
| SwiftUI 옵션 | `SUBezierMultiSelectOption.swift` |
| container / leading / constant | `BezierMultiSelectSpec.swift` |

> 재사용 심볼 실재 확인: `BezierOverlay` / `SUBezierOverlay` + `BezierOverlayConstant`(width 240 · padding 10 · cornerRadius 32 · elevation `.mEv3` · backgroundColor `.surfaceHighest`), `BezierBaseItem` / `SUBezierBaseItem` + `BezierBaseItemStyle`(레이아웃·pressed 배경·press scale·disabled opacity) + `BezierBaseItemConstant`(slotSpacing 10 · titleRowSpacing 4) + `BezierBaseItemSize.medium`(minHeight 48 · verticalPadding 6 · leadingLength 24), `BezierSectionLabel` / `SUBezierSectionLabel` + `BezierSectionLabelColor.neutralLight` + `BezierSectionConstant`(labelHeight 32 · labelHorizontalPadding 10 · labelCornerRadius 8 · labelTypography `.textMedium(weight: .bold)`), `BCSemanticToken`(.textNeutral / .textNeutralLighter / .iconNeutralHeavy / .iconNeutralHeavier / .fillNeutralLighter / .surfaceHighest), `BTSemanticToken`(.textXLarge / .captionMedium / .textMedium), `BOGlobalToken.disabled` = 0.4, `BezierIcon.check`.

## 9. Figma 외 · 협의 사항 (구현 결정)

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **컴포지션 구조 (MOB-6354 핸드오프)**: MultiSelectOption은 `BezierBaseItem`/`SUBezierBaseItem`을 소유(composition)해 구현한다 (상속 금지 — 채널 정석). 오버레이 패널은 `BezierOverlay`/`SUBezierOverlay` 재사용, 그룹 라벨은 `BezierSectionLabel(color: .neutralLight)` 재사용.
2. **`container=bottomsheet` 미구현**: BezierSwift에는 Figma `BottomSheet`(`1306:200`)에 대응하는 쉘 컴포넌트가 없다(`MasterComponent/` 전수 확인). 해당 variant의 MultiSelect 콘텐츠는 `container=page`와 동일한 인라인 리스트이므로, 코드 API의 `BezierMultiSelectContainer`는 `page`/`overlay` 2종만 제공하고 bottom sheet 호스팅과 §2의 Cancel/Save `buttonsArea` 재현은 사용처 책임으로 둔다 (`BezierSelect` SPEC §9-2와 동일 결정).
3. **stale description 미반영**: §7이 인용한 Figma description 중 "overlay에도 Cancel/Save footer 내장", "항목 탭 시 Checkbox 토글", "항목 탭 즉시 반영 금지"는 같은 파일의 레이어 구조와 어긋난다 — overlay variant(`5150:2921`)에는 footer 노드가 없고, 12개 option variant 어디에도 Checkbox 노드가 없다(trailing `icon/check` 20×20뿐). 구현은 레이어 구조를 따른다. design doc도 DL-011(Checkbox 폐기)·DL-103(overlay는 footer 없이 탭 즉시 토글)으로 같은 방향이다.
4. **BaseItem 내부 스타일 주입**: Figma MultiSelectOption은 BaseItem `medium` 기본값 대비 좌우 패딩 10(↔6)·corner radius 16(↔8)·center 좌측 인셋 0(↔2)이 다르다. 이를 위해 internal `BezierBaseItemStyle`에 값을 주입한다. 상하 패딩 6은 `BezierBaseItemSize.medium.verticalPadding`과 우연히 같지만 §2의 Figma 실측값을 코드에 명시하기 위해 함께 주입한다 — 폴백에 의존하면 BaseItem 기본값이 바뀔 때 이 컴포넌트가 조용히 따라간다.
5. **프레젠테이션·선택 상태 스코프 제외**: 열림/닫힘 상태·앵커 포지셔닝·외부 탭 닫힘은 사용처 책임 (BezierOverlay SPEC §9-1 · BezierSelect SPEC §9-4와 동일 결정). 선택 집합(`isSelected` 조합)의 보관·토글도 사용처 책임이다 — Figma는 옵션 단위 BOOLEAN만 정의한다. 단일 선택 컴포넌트와 달리 "하나만 true" 제약이 없다.
6. **centerSlot을 4개 leading 유형 전부에 제공**: Figma는 `hasCenterSlot`/`centerSlot`을 CS 레벨 프로퍼티로 정의하면서도 레이어는 `leadingType=custom` 9→12번째 variant를 제외한 9개에만 `labelRow`를 뒀다(§2). 코드는 leading 유형과 무관하게 하나의 렌더 경로를 쓰므로 네 유형 모두에서 centerSlot이 동작한다. leading 유형별로 슬롯 지원을 갈라 놓을 근거가 description·design doc 어디에도 없다.
7. **state 축은 런타임 상태**: Figma `state`(default/pressed/disabled)는 API 옵션이 아니라 런타임 인터랙션 상태로 구현 — pressed는 터치 추적, disabled는 UIKit `isEnabled` / SwiftUI `.disabled()`. Figma option description도 "state: Figma 전용 프로퍼티(코드 prop 아님)"로 명시한다.
8. **pressed press-scale**: BaseItem의 press scale 피드백(0.97, 오버슈트 복귀)을 그대로 상속한다 (BaseItem SPEC §7 협의 — Figma 외).
9. **`hasLabel`/`has*` boolean 표현**: 코드 API는 `labelText: String?`(nil = 미표시)로, 슬롯 계열은 옵셔널/`EmptyView` 분기로 표현 (BezierSelect §9-9 · BezierDropdownMenu §9-7과 동일 관례).
10. **그룹 divider API 미제공**: `Internal/MultiSelectGroup`에는 divider 프로퍼티가 없고 description이 "필요 시 외부에 Divider 인스턴스를 배치할 것"으로 지시한다. `BezierMultiSelectGroup`도 divider 프로퍼티를 두지 않으며, 구분선이 필요하면 사용처가 `BezierDivider`/`SUBezierDivider`를 형제로 배치한다. 형제 컴포넌트 `BezierSelectGroup`이 `showsDivider`를 갖는 것은 그쪽 Figma 그룹(`4648:129`)이 `showDivider` 프로퍼티를 갖기 때문이며, 이 컴포넌트에 이식할 근거가 아니다.
11. **`leadingType=avatar`와 `custom`의 렌더 경로 공유**: Figma는 두 축을 분리하지만 레이아웃은 둘 다 24×24 슬롯으로 동일하다. 코드도 두 case를 모두 제공해 Figma 축을 보존하되 렌더는 같은 경로를 쓴다 — case 구분은 "무엇을 넣는가"(`BezierAvatar` 인스턴스 / 임의 뷰)의 문서적 구분이다. Figma `leadingType=avatar`의 leading은 `Avatar` 컴포넌트 인스턴스(size 24)이므로 사용처는 `.avatar(_:)`에 `BezierAvatar`/`SUBezierAvatar`를 넣는다.
12. **label은 1줄 truncate**: §2대로 Figma MultiSelectOption의 label 텍스트에는 truncation 설정이 없어 폭이 부족하면 여러 줄로 흐른다. 구현은 `BezierBaseItem`/`SUBezierBaseItem`의 title 렌더(`numberOfLines = 1` · `.lineLimit(1)` + tail truncate)를 그대로 상속해 1줄로 자른다. 근거: ① 선택 목록의 행 높이가 항목 텍스트 길이에 따라 들쭉날쭉해지면 스캔이 어렵다 ② 형제 그룹 라벨은 같은 Figma 파일에서 명시적으로 nowrap+ellipsis다 ③ BaseItem은 공유 레이어라 이 컴포넌트를 위해 title 줄 수 정책을 바꾸지 않는다. description은 BaseItem이 `numberOfLines = 0`으로 wrap하며 이는 Figma의 wrap 거동과 일치한다.
13. **`labelText`는 `container=.page`에서만 렌더**: §2대로 Figma `hasLabel`은 page variant에만 노출되고 overlay variant에는 라벨 노드 자체가 없다. 코드의 `labelText`는 두 container에 공통 프로퍼티로 두되(container를 런타임에 바꿀 수 있어야 하므로) 렌더는 `.page`에서만 한다. `.overlay`에서 라벨이 필요하면 Figma가 그 맥락에서 쓰는 경로 — `BezierMultiSelectGroup`/`SUBezierMultiSelectGroup`의 `labelText` — 를 쓴다. doc comment에 이 조건을 명시해 조용한 no-op이 되지 않게 했다.
14. **centerSlot 고정 높이 클리핑**: Figma는 centerSlot을 높이 FIXED 24pt로 두지만 clip 속성은 부모 `centerContent`에만 있다(§2). 구현은 슬롯 컨테이너 자체에 24pt 고정 + 클리핑을 걸어 초과 콘텐츠가 행 높이를 밀지 않게 한다 — 고정 높이를 실제로 강제하는 수단이며, SwiftUI `.frame(height:)`는 단독으로는 초과 콘텐츠를 넘치게 그린다.
15. **overlay 폭은 §2 실측 240pt 고정**: §7이 인용한 쉘 description은 폭을 `HUG · min 160 / max 280px`로 적지만, 이는 `overlay`(`5078:2253`) 컴포넌트 단독의 일반 계약이다. MultiSelect가 내장한 인스턴스(`5150:2921`)는 §2 실측대로 `240pt` FIXED이고 `BezierOverlay`도 `BezierOverlayConstant.width = 240`으로 이미 고정돼 있어, 구현은 240pt를 따른다. 앵커 폭에 맞춰 늘어나는 HUG 오버레이가 필요해지면 `BezierOverlay` 쪽 결정 사항이지 이 컴포넌트에서 갈라질 값이 아니다.

## 10. Variant 매트릭스

```text
MultiSelect (4903:6133, 3):
  container=page        = 1332:3
  container=bottomsheet = 4903:6058
  container=overlay     = 5150:2921

Internal/MultiSelectGroup      = 4648:12419  (총 1 — COMPONENT, property만)
Internal/MultiSelectGroupLabel = color=neutral-dark 4373:16, color=neutral-light 4373:18 (총 2)

Internal/MultiSelectOption (1352:42, 12):
  leadingType=none,   state=default|pressed|disabled = 4675:90  | 4675:102 | 4675:114
  leadingType=icon,   state=default|pressed|disabled = 4675:126 | 4675:144 | 4675:162
  leadingType=avatar, state=default|pressed|disabled = 4676:102 | 4676:128 | 4676:152
  leadingType=custom, state=default|pressed|disabled = 4676:176 | 4676:190 | 4676:204
```
