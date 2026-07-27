# BezierDropdownMenu SPEC

> **SSOT**: [Figma · Mobile-Components / DropdownMenu (2070:19)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=2070-19) · [Internal/DropdownMenuItem (4676:12682)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4676-12682) · [Internal/DropdownMenuGroup (4648:12424)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4648-12424) · [Internal/DropdownMenuGroupLabel (4648:113)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4648-113)
> **Design spec doc**: [team-design / bezier-v3 / components / DropdownMenu-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/DropdownMenu-spec.md) · [BaseOverlay.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseOverlay.md) · [BaseItem.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseItem.md) · [BaseGroupLabel.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseGroupLabel.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

명시적인 트리거 뒤에 액션 목록을 감췄다가, 항목을 선택하면 곧바로 그 액션을 실행하는 컨텍스트 메뉴 컴포넌트.

## 1. Component Properties

### DropdownMenu (COMPONENT `2070:19`)

| Property | 값 | 비고 |
|---|---|---|
| **trigger** | SLOT (`2372:442`) | 임의 트리거 배치 (overlay 밖, 기본 콘텐츠 IconButton 인스턴스는 슬롯 예시). 코드 API에서의 생략(옵셔널) 처리는 §9-10 협의 참조 |
| **content** | SLOT (overlay 내부 `content`) | DropdownMenu 항목 영역. 기본 콘텐츠 Internal/DropdownMenuGroup |

variant / state / boolean 축 없음 — 단일 정적 COMPONENT (열림 상태 1종만 정의).

총 instance: 1개 (`DropdownMenu` = `2070:19`)

### Internal/DropdownMenuItem (CS `4676:12682`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `variant` | VARIANT | neutral | neutral / destructive | `BezierDropdownMenuItemVariant` |
| `leadingType` | VARIANT | — | none / icon / custom | `BezierDropdownMenuItemLeading` (`.none` / `.icon` / `.custom`) |
| `state` | VARIANT | default | default / pressed / disabled | 인터랙션 상태 (§6) |
| `content` | TEXT | "Label" | 문자열 | title |
| `hasDescription` | BOOLEAN | false | on / off | description 유무 |
| `description` | TEXT | "Description text" | 문자열 | description |
| `hasCenterSlot` | BOOLEAN | true | on / off | centerSlot 유무 (기본 슬롯은 빈 placeholder, 폭 ≈0) |
| `centerSlot` | SLOT | — | 임의 콘텐츠 | centerSlot |
| `hasTrailingContent` | BOOLEAN | false | on / off | trailing 유무 |
| `trailingContent` | SLOT | — | 임의 콘텐츠 | trailingContent |
| `leadingIconSource` | INSTANCE_SWAP | — | 아이콘 인스턴스 (leadingType=icon) | `.icon(BezierIcon)` |
| `leadingContent` | SLOT | — | 임의 콘텐츠 (leadingType=custom) | `.custom(뷰)` |

총 instance: `variant(2) × leadingType(3) × state(3) = 18개`

> `leadingType=custom`도 Mobile CS 실측상 `centerContent`(label·centerSlot·description)를 그대로 유지하고 leading 슬롯(24×24)만 자유 콘텐츠로 개방한다 (`5215:12087` 등 실측 — leadingContent가 SLOT).

### Internal/DropdownMenuGroup (COMPONENT `4648:12424`)

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `hasLabel` | BOOLEAN | false | on / off | 그룹 라벨 유무 (복수 그룹일 때만 켠다) |
| `showDivider` | BOOLEAN | false | on / off | 그룹 하단 구분선 |
| `content` | SLOT (`4648:12427`) | — | Internal/DropdownMenuItem 배치 | items |

라벨 텍스트 편집은 내부 `Internal/DropdownMenuGroupLabel` 인스턴스 프로퍼티로 (CS 레벨 label TEXT prop 없음).

### Internal/DropdownMenuGroupLabel (CS `4648:113`)

| Property | 값 | 비고 |
|---|---|---|
| **color** | `neutral-light` (`4648:109`) / `neutral-dark` (`4648:111`) | 텍스트 색. Group 내 기본값 neutral-light |
| **label** | TEXT ("Group Label") | 라벨 텍스트 |

## 2. Layout Spec

### DropdownMenu 루트 (`2070:19`)

| Part | 값 |
|---|---|
| 루트 배치 | 세로 스택: trigger → overlay, gap `4pt` |
| 루트 폭 | `240pt` FIXED |
| trigger 슬롯 행 | 폭 FILL(240pt), 콘텐츠 우측 정렬(justify-end), 높이 HUG |
| overlay | `overlay`(`5078:2253`) 인스턴스 — 폭 `240pt` FIXED · padding `10pt` 균일 · corner radius `32pt`(`radius/32`) · content 폭 `220pt` |

### Internal/DropdownMenuItem

| Part | 값 |
|---|---|
| min height | `40pt` (description 시 콘텐츠 기반 `52pt` = 6+24+16+6) |
| padding | 상하 `6pt` / 좌우 `10pt` |
| corner radius | `16pt` (`radius/16`), overflow clip |
| 루트 gap | `10pt` (contentWrapper ↔ trailingContent), 세로 중앙 정렬 |
| labelWrapper gap | `10pt` (leading ↔ centerContent) |
| labelRow gap | `4pt` (label ↔ centerSlot) |
| leading | `24×24pt` 정방형 (icon / custom 공통) |
| centerSlot | 폭 HUG × 높이 `24pt` FIXED, 세로 중앙 (초과 콘텐츠 clip은 §9-9 협의) |
| trailingContent | 높이 `24pt` FIXED, 세로 중앙 (마스터 placeholder 100×24 — 슬롯 콘텐츠 폭은 소비 측 결정) |
| description 들여쓰기 | leading 있으면 `34pt`(= 24 + 10), 없으면 `0` |
| label overflow | 1줄 ellipsis (Figma nowrap — 구현은 truncate) |

### Internal/DropdownMenuGroup

| Part | 값 |
|---|---|
| 배치 | 세로 스택: GroupLabel(optional) → content → divider(optional), gap `0` |
| divider | `Divider` 인스턴스 — 선 `1pt` × 폭 FILL, 좌우 인셋 `6pt`, 상하 여백 `6pt` (총 높이 13pt) |

### Internal/DropdownMenuGroupLabel

| Part | 값 |
|---|---|
| 최소 높이 | `32pt` |
| 좌우 패딩 | `10pt` |
| corner radius | `8pt` |
| 텍스트 overflow | 1줄, ellipsis |

## 3. 컬러 토큰 (Figma 사용처 기준)

### DropdownMenu 루트 / overlay

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| overlay 배경 | `surfaceHighest` | `color/surface/highest` | `#FFFFFF` |
| overlay shadow | `elevationLarge` | `color/elevation/large` | `#00000038` |

### Internal/DropdownMenuItem — variant × state

| 위치 | variant=neutral | variant=destructive |
|---|---|---|
| label 텍스트 | `textNeutral` (`color/text/neutral`, `#000000D9`) | `textAccentRed` (`color/text/accent/red`, `#E1535D`) |
| leading 아이콘 (leadingType=icon) | `iconNeutralHeavy` (`color/icon/neutral/heavy`, `#00000099`) | `iconAccentRed` (`color/icon/accent/red`, `#E1535D`) |
| description 텍스트 | `textNeutralLighter` (`color/text/neutral/lighter`, `#00000066`) | 동일 (variant 무관 고정) |

| state | 배경 | 기타 |
|---|---|---|
| default | 없음 (투명) | — |
| pressed | `fillNeutralLighter` (`color/fill/neutral/lighter`, `#00000008`) | — |
| disabled | 없음 | 본체 opacity `opacity/disabled` = 0.4 |

### Internal/DropdownMenuGroup

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| divider 선 | `borderNeutral` | `color/border/neutral` | `#00000014` |

### Internal/DropdownMenuGroupLabel

| color | Token | Figma Variable | Raw |
|---|---|---|---|
| `neutral-light` | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| `neutral-dark` | `textNeutral` | `color/text/neutral` | `#000000D9` |

## 4. Typography

### Case A — Typography Token 사용 (전부 토큰)

| 위치 | Token (`BTSemanticToken`) | Figma Style |
|---|---|---|
| item label | `.textXLarge(weight: .regular)` | `Typography/text/xlarge` (Inter Regular, size 16, lineHeight 24, letterSpacing `text/letter-spacing/tight` −0.1) |
| item description | `.captionMedium(weight: .regular)` | `Typography/caption/medium` (Inter Regular, size 12, lineHeight 16, letterSpacing `caption/letter-spacing` 0) |
| group label | `.textMedium(weight: .bold)` | `Typography/text/medium-bold` (Inter Bold, size 14, lineHeight 18, letterSpacing `text/letter-spacing` 0) |

### Case B — Custom Typography

없음 (모든 텍스트가 토큰 사용).

## 5. Elevation

| Effect Style | 구성 |
|---|---|
| `Elevation/Mobile/3` (overlay) | DROP_SHADOW · color `color/elevation/large` · offset (0, `elevation/4` = 4) · blur `elevation/20` = 20 · spread 0 |

## 6. State 별 시각 동작 (Internal/DropdownMenuItem)

| State | 시각 변화 | 인터랙션 |
|---|---|---|
| `default` | 배경 없음 | 활성 |
| `pressed` | 배경 `fillNeutralLighter` | 활성 (탭 진행 중) |
| `disabled` | 본체 opacity 0.4, 배경 없음 | 입력 차단 |

DropdownMenu / DropdownMenuGroup / DropdownMenuGroupLabel에는 state variant 축 없음 (정적 컨테이너).

## 7. 디자이너 가이드라인 (Figma component description 인용)

> DropdownMenu 마스터(`2070:19`)의 component description은 공란 — 인용 항목 없음 (trigger가 SLOT이라는 것은 §1의 구조 실측).

### Internal/DropdownMenuItem

- Used within DropdownMenu only. Do not place standalone.
- `leadingType=icon`: `leadingIconSource`로 아이콘 교체 / `leadingType=custom`: leadingContent SLOT에 임의 콘텐츠 배치.
- `variant=destructive`: 삭제·초기화 등 파괴적 액션 전용.
- `hasTrailingContent`(옵션): true 시 우측 콘텐츠 영역 표시 (단축키·배지 등).
- `hasCenterSlot`(옵션): true 시 label 옆 centerSlot에 부가 콘텐츠(배지 등) 표시.
- `hasDescription`(옵션): true 시 label 아래 보조 설명 텍스트 표시 (권장하지 않음 — 식별력 저하 방지, 꼭 필요할 때만).

### Internal/DropdownMenuGroup

- Used within DropdownMenu only. Do not place standalone. DropdownMenu 오버레이 내 항목을 카테고리별로 묶는 그룹 컨테이너.
- `hasLabel`: 그룹 라벨 표시 여부 (기본 false, 복수 그룹일 때만 켠다).
- `showDivider`: true 시 그룹 하단에 구분선 표시.
- 단일 그룹일 때는 DropdownMenuGroup 없이 DropdownMenuItem을 직접 나열할 것.

### overlay (`5078:2253` — 내장 쉘)

- position: 기본 bottom-start, 화면 밖이면 flip, 가장자리 마진 16px (코드 구현 참고용) · backdrop 없음 · 외부 탭 시 닫힘.

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 메뉴 컨테이너 | `BezierDropdownMenu.swift` |
| UIKit 메뉴 그룹 | `BezierDropdownMenuGroup.swift` |
| UIKit 메뉴 아이템 | `BezierDropdownMenuItem.swift` |
| SwiftUI 메뉴 컨테이너 | `SUBezierDropdownMenu.swift` |
| SwiftUI 메뉴 그룹 | `SUBezierDropdownMenuGroup.swift` |
| SwiftUI 메뉴 아이템 | `SUBezierDropdownMenuItem.swift` |
| variant / leading / constant | `BezierDropdownMenuSpec.swift` |

> 재사용 심볼 실재 확인: `BezierOverlay` / `SUBezierOverlay` / `BezierOverlayConstant`(width 240 · padding 10 · cornerRadius 32 · elevation `.mEv3`), `BezierBaseItem` / `SUBezierBaseItem`(레이아웃·pressed·press scale·disabled), `BezierSectionLabel` / `SUBezierSectionLabel` + `BezierSectionLabelColor.neutralLight`(그룹 라벨 — 레이아웃·타이포·색 Figma GroupLabel과 동일), `BezierDivider` / `SUBezierDivider`(sideIndent·parallelIndent 기본 true = 6/6 인셋), `BCSemanticToken`(.textNeutral / .textAccentRed / .textNeutralLighter / .iconNeutralHeavy / .iconAccentRed / .fillNeutralLighter / .surfaceHighest / .borderNeutral), `BTSemanticToken`(.textXLarge / .captionMedium / .textMedium), `BOGlobalToken.disabled` = 0.4, `BezierIcon`.

## 9. Figma 외 · 협의 사항 (구현 결정)

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **컴포지션 구조 (MOB-6355 핸드오프)**: DropdownMenuItem은 `BezierBaseItem`/`SUBezierBaseItem`을 소유(composition)해 구현한다 (상속 금지). 오버레이 패널은 `BezierOverlay`/`SUBezierOverlay` 재사용, 그룹 라벨은 `BezierSectionLabel(color: .neutralLight)` 재사용, 그룹 divider는 `BezierDivider()` 재사용.
2. **BaseItem 내부 스타일 주입**: Figma DropdownMenuItem은 BaseItem 대비 좌우 패딩 10(↔6)·corner radius 16(↔8)·center 좌측 인셋 0(↔2)·small에서 description 지원(↔미지원)·label 색 variant 분기가 다르다. 이를 위해 BaseItem에 **internal** 스타일 주입(`BezierBaseItemStyle`)을 추가한다 — public API 불변 (배치·스타일 커스터마이즈의 public 노출 금지 원칙 유지).
3. **description + leading 동시 사용 시 leading 세로 정렬**: Figma는 de-nest 구조(leading이 label 행에 정렬, y=6). 구현은 BaseItem nest 구조를 따라 leading이 행 전체 세로 중앙(y=14)에 온다 — BaseItem composition 협의(#1)에 따른 의도적 수용. label·description·trailing의 x/y 좌표는 Figma와 동일하며, 차이는 이 8pt 하나뿐이다 (description 자체가 Figma 가이드라인상 비권장 구성).
4. **프레젠테이션 스코프 제외**: 열림/닫힘 상태·앵커 포지셔닝·외부 탭 닫힘은 사용처 책임 (BezierOverlay SPEC §9-1과 동일 결정 — Figma도 열림 상태 1종의 정적 구조만 정의). trigger 슬롯은 Figma 구조(트리거-패널 한 세트, gap 4)를 그대로 제공한다.
5. **state 축은 런타임 상태**: Figma `state`(default/pressed/disabled)는 API 옵션이 아니라 런타임 인터랙션 상태로 구현 — pressed는 터치 추적, disabled는 UIKit `isEnabled` / SwiftUI `.disabled()`.
6. **pressed press-scale**: BaseItem의 press scale 피드백(0.97, 오버슈트 복귀)을 그대로 상속한다 (BaseItem SPEC §7 협의 — Figma 외).
7. **`hasLabel`/`showDivider`/`has*` boolean 표현**: 코드 API는 UIKit `labelText: String?`(nil = 미표시)·`showsDivider: Bool`, 슬롯 계열은 옵셔널/`EmptyView` 분기로 표현 (BezierSection §8-5와 동일 관례).
8. **그룹 divider 배치**: Figma 모델 그대로 Group의 `showsDivider`로 그룹 최하단에 표시한다 (web 코드의 형제 `<DropdownMenuSeparator>` 모델과 다름 — Mobile Figma가 SSOT).
9. **trailing/centerSlot 높이 24 고정**: Figma 슬롯이 FIXED 24 높이이므로 구현은 높이 24 컨테이너(초과 시 clip)로 감싼다. 콘텐츠는 소비 측 책임 (인터랙티브 컨트롤 배치 금지 가이드는 design doc 참조).
10. **trigger 슬롯 생략(옵셔널)**: 코드 API에서 trigger는 옵셔널 — 생략하면 트리거 행 없이 패널만 표시하고, 화면의 기존 요소를 트리거로 외부 제어한다 (출처: design doc DropdownMenu-spec.md §3 Mobile "trigger — Optional" + MOB-6355 핸드오프. Figma 노드 description에는 없는 협의 사항).

## 10. Variant 매트릭스

```
DropdownMenu           = 2070:19                       (총 1 — 축 없음)
Internal/DropdownMenuItem (4676:12682, 18):
  variant=neutral,     leadingType=none,   state=default|pressed|disabled = 4676:12586 | 4676:12590 | 4676:12594
  variant=neutral,     leadingType=icon,   state=default|pressed|disabled = 4676:12598 | 4676:12604 | 4676:12610
  variant=neutral,     leadingType=custom, state=default|pressed|disabled = 4676:12616 | 4676:12621 | 4676:12626
  variant=destructive, leadingType=none,   state=default|pressed|disabled = 4676:12631 | 4676:12635 | 4676:12639
  variant=destructive, leadingType=icon,   state=default|pressed|disabled = 4676:12643 | 4676:12649 | 4676:12655
  variant=destructive, leadingType=custom, state=default|pressed|disabled = 4676:12661 | 4676:12666 | 4676:12671
Internal/DropdownMenuGroup      = 4648:12424           (총 1 — property만)
Internal/DropdownMenuGroupLabel = color=neutral-light 4648:109, color=neutral-dark 4648:111 (총 2)
```
