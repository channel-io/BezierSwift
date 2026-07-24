# BezierSectionItem SPEC

> **SSOT**: [Figma · Mobile-Components / Internal/SectionItem (4762:196)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4762-196) · [Internal/SectionItemAccessory (5230:51815)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=5230-51815)
> **Design spec doc**: [team-design / bezier-v3 / components / Section-spec.md §13](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Section-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

Section 내부 리스트 아이템(Mobile) (Figma component description 1행).

## 1. Component Properties

### Internal/SectionItem (CS `4762:196`)

| Property | 값 | 비고 |
|---|---|---|
| **size** | `small` / `medium`(기본) / `large` | 행 높이·leading 크기·description 구조 결정 |
| **leadingType** | `none` / `icon` / `avatar` / `custom` | leading 콘텐츠 유형 |
| **state** | `default` / `pressed` / `disabled` | |
| **content** | TEXT (기본 "Label") | 레이블 (custom 제외) |
| **hasDescription** | BOOLEAN, 기본 `false` | custom 미지원 |
| **description** | TEXT (기본 "Description text") | 보조 설명 (custom 제외) |
| **hasCenterSlot** | BOOLEAN, 기본 `false` | custom 미지원 |
| **centerSlot** | SLOT (높이 24) | label 우측 인라인 슬롯 (custom 제외) |
| **leadingIconSource** | SLOT | icon variant의 leading |
| **leadingContent** | SLOT | custom variant의 leading (avatar variant는 Avatar 인스턴스) |
| **centerContent** | SLOT | custom variant 전용 — label 대신 자유 콘텐츠 (기본 placeholder는 Label 텍스트) |
| **hasAccessory** | BOOLEAN, 기본 `false` | |
| **accessorySource** | INSTANCE_SWAP, 기본 `navigation` | SectionItemAccessory 7종 |

총 instance: leadingType 4 × state 3 × size 3 = **36개**

### Internal/SectionItemAccessory (CS `5230:51815`)

| Property | 값 |
|---|---|
| **type** | `navigation`(기본) / `outlink` / `toggle` / `select` / `multiselect` / `display` / `custom` |
| **content** | SLOT | custom variant 전용 자유 콘텐츠 |

총 instance: **7개**

## 2. Layout Spec

### SectionItem 공통

| Part | 값 |
|---|---|
| 루트 | 가로 배치, 세로 중앙 정렬, gap `10pt`, cornerRadius `0` |
| 좌우 패딩 | `10pt` |
| labelRow | label ↔ centerSlot gap `4pt`, centerSlot 높이 `24pt` |
| accessory 영역 | 높이 `32pt` 고정, 행 우측 끝, 세로 중앙 |
| 텍스트(label) | 1줄 (whitespace-nowrap) |

### size 별

| size | min-height | 상하 패딩 | leading (icon/avatar) | leading (custom) | description 구조 |
|---|---|---|---|---|---|
| `small` | `40pt` | `6pt` | `24×24` | `20×20` | de-nest (행 전체 아래) |
| `medium` | `48pt` | `8pt` | `24×24` | `20×20` | de-nest (행 전체 아래) |
| `large` | `52pt` | `6pt` | `36×36` | `36×36` | nested (centerContent 안, labelRow와 gap `2pt`) |

### description 좌측 인덴트 (de-nest 구조: small/medium)

| leadingType | 인덴트 |
|---|---|
| `none` | `0` |
| `icon` | `34pt` |
| `avatar` | `34pt` |
| `custom` | — (description 미지원) |

large(nested)는 인덴트 없음 (centerContent 좌측 정렬).

### custom variant 구조 (flat)

루트 직속: leadingContent SLOT → centerContent SLOT(flex-1, 세로 중앙). contentWrapper/labelWrapper 없음.

### Accessory type 별

| type | 구성 | 치수 |
|---|---|---|
| `navigation` | `icon/chevron-small-right` | 아이콘 `24×24` |
| `outlink` | `icon/arrow-right-up-small` | 아이콘 `24×24` |
| `select` | 값 텍스트 + `icon/chevron-updown`, gap `6pt`, 좌우 패딩 `4pt` | 아이콘 `16×16` |
| `multiselect` | 콤마 나열 텍스트("Value1, Value2") + `icon/chevron-updown`, gap `6pt`, 좌우 패딩 `4pt` | 아이콘 `16×16` |
| `display` | 값 텍스트만, 좌우 패딩 `4pt` | — |
| `toggle` | Switch 인스턴스(비인터랙티브 상태 표시) | `50×28`, track radius `14`, thumb `24×24` (top `2`, left off `2` / on `24`) |
| `custom` | 자유 SLOT | 높이 컨테이너 채움 |

## 3. Color

### SectionItem

| 역할 | Token | Figma Variable | Raw |
|---|---|---|---|
| label 텍스트 | `textNeutral` | `color/text/neutral` | `#000000D9` |
| description 텍스트 | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| leading 아이콘 (icon variant 기본) | `iconNeutralHeavy` | `color/icon/neutral/heavy` | `#00000099` |
| └ 실측 편차 | — | icon variant 9개 중 기본 variant(icon/default/medium)만 `color/icon/neutral/heavy`, 나머지 8개는 `color/icon/neutral`(#00000066)로 실측됨 | — |
| pressed 배경 | `fillNeutralLighter` | `color/fill/neutral/lighter` | rgba(0,0,0,0.03) |
| disabled | opacity `0.4` | — | — |

### destructive (Figma component description 명시 — 코드 전용 boolean, variant 축 아님)

| 역할 | Token |
|---|---|
| leading 아이콘 | `color/icon/accent/red` |
| label 텍스트 | `color/text/red` |

### Accessory

| 역할 | Token | Figma Variable | Raw |
|---|---|---|---|
| 값 텍스트 (select/multiselect/display) | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| 아이콘 (chevron-small-right / chevron-updown / arrow-right-up-small) | `iconNeutral` | `color/icon/neutral` | `#00000066` |
| toggle track (off) | `fillNeutralHeavy` | `color/fill/neutral/heavy` | `#00000026` |
| toggle track (on) | `fillNeutralHeaviest` | `color/fill/neutral/heaviest` | rgba(0,0,0,0.85) |
| toggle thumb | `iconInverseHeavier` | `color/icon/inverse/heavier` | `#FFFFFF` |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| label | `BTSemanticToken.textXLarge(weight: .regular)` | `Typography/text/xlarge` (16 / 400 / lh 24 / ls −0.1) |
| description | `BTSemanticToken.captionMedium(weight: .regular)` | `Typography/caption/medium` (12 / 400 / lh 16 / ls 0) |
| accessory 값 텍스트 | `BTSemanticToken.textLarge(weight: .regular)` | `Typography/text/large` (15 / 400 / lh 20 / ls −0.1) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

| State | 변경점 |
|---|---|
| `default` | 기본 |
| `pressed` | 루트 배경 `fillNeutralLighter` |
| `disabled` | 루트 전체 opacity `0.4`, 상호작용 차단 |

## 6. 디자이너 가이드라인 (Figma component description 인용)

### Internal/SectionItem

- Used within Section / CollapsibleSection only. Do not place standalone.
- size: small(40dp, leadingContent 24x24) / medium(48dp, 기본) / large(52dp, leadingContent 36x36, description nest 구조) — 전 variant 공통 적용
- leadingType=custom: leadingContent(SLOT)+centerContent(SLOT) flat 구조. hasDescription/centerSlot 미지원
- cornerRadius: 전 variant 0dp (DL-113)
- trigger(display/navigate/outlink/select/multiselect/toggle/action)는 코드 prop이며 Figma variant 축이 아니다
- trailingAccessory: hasAccessory + accessorySource(7종, 기본값 navigation). custom은 자유 SLOT — 허용: Text+Badge/StatusIndicator 등 HORIZONTAL 조합, 금지: focusable 요소
- 단일 탭 타겟 불변식(Mobile): trailing에 Button/IconButton/Link/TextField 등 포커서블 컨트롤 배치 금지 — toggle의 Switch도 독립 컨트롤이 아닌 상태 표시자
- destructive: 코드 전용 boolean(기본 false). true 시 leading 아이콘 color/icon/accent/red, title color/text/red
- description은 비권장 — 정말 필요할 때만

### Internal/SectionItemAccessory

- Used within SectionItem only. Do not place standalone. 인터랙티브 컨트롤 없음(단일 탭 타겟 불변식).
- trigger→기본 accessory는 이름이 대부분 1:1 대응(navigate→navigation, select→select, multiselect→multiselect, outlink→outlink, toggle→toggle, action/display→display)

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierSectionItem.swift` |
| SwiftUI 구현 | `SUBezierSectionItem.swift` |
| size / accessory / constant 정의 | `BezierSectionItemSpec.swift` |
| accessory 뷰 (UIKit, internal) | `BezierSectionItemAccessoryView.swift` |

아이콘 자산: `BezierIcon.chevronSmallRight` / `BezierIcon.arrowRightUpSmall` / `BezierIcon.chevronUpdown` (모두 실재 확인).

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **leadingType 코드 표현**: Figma variant 축을 코드에서는 `BezierSectionItemLeading` enum(`none` / `icon(BezierIcon)` / `avatar(뷰·View)` / `custom(뷰·View)`)으로 표현 — 단일 클래스/뷰가 4종을 흡수한다. custom일 때 `centerContent` 슬롯이 nil이면 `content` 텍스트를 기본 표시(Figma custom centerContent SLOT의 기본 placeholder가 Label 텍스트인 것과 대응).
2. **trigger enum 스코프 제외**: trigger는 코드 prop(Figma 축 아님)이나, 탭 시맨틱(즉시저장·롤백·토스트)은 앱 영역이므로 이번 구현은 `onTap` 클로저 + `accessory` 직접 지정 API로 제공한다. trigger→accessory 기본값 파생은 소비자/후속 몫.
3. **accessory 코드 표현**: `BezierSectionItemAccessory` enum — `navigation` / `outlink` / `select(value:)` / `multiselect(values:)` (콤마 결합 표시) / `display(value:)` / `toggle(isOn:)` / `custom(콘텐츠)`. 전부 비인터랙티브 표시자 (단일 탭 타겟 불변식).
4. **toggle 표시자**: Switch 컴포넌트(`1095:19`)가 BezierSwift에 아직 없어, accessory 내부에 Switch의 Figma 실측값(50×28·radius 14·track off `fillNeutralHeavy`/on `fillNeutralHeaviest`·thumb 24 흰색, top 2, left 2/24)으로 비인터랙티브 시각을 직접 그린다. thumb 그림자 실측: offset (0, 2), blur 4, black 25% (thumb 벡터의 drop-shadow 필터). BezierSwitch 컴포넌트가 생기면 교체 대상.
5. **description 인덴트 적용 규칙**: 구현은 de-nest 인덴트를 "leading 표시 시 34 / 없음(none) 0"으로 적용한다 (§2 표와 동일 — icon·avatar 공통 34).
6. **BezierBaseItem 미재사용**: 좌우 패딩(6↔10)·radius(8↔0)·상하 패딩 축·description 배치 구조(de-nest/nested)가 BaseItem과 달라 코드 재사용 대신 동일 컨벤션의 독립 구현으로 간다.
7. **press scale 적용**: Figma pressed state는 배경 fill 변화만 정의하나, BaseItem과 동일한 press scale 피드백(콘텐츠 0.97 축소 → release 오버슈트 복귀, reduce motion 시 비활성)을 협의로 적용한다 (2026-07-24). 구현은 internal 유틸 `BezierPressFeedback`(`Util/BezierPressFeedback.swift`) — public 승격·BaseItem 마이그레이션은 MOB-6471.
8. **state 코드 매핑**: pressed → UIKit `isHighlighted` / SwiftUI ButtonStyle `isPressed`, disabled → `isEnabled`/`.disabled()`. `onTap == nil`이면 비인터랙티브(pressed 없음).
9. **leading 아이콘 색 heavy 고정**: §3의 실측 편차(기본 variant만 heavy, 8개 variant는 neutral)에 대해 구현은 `iconNeutralHeavy`를 전 state·size에 고정 적용한다 — 근거: defaultVariant가 heavy이고, §5의 state 정의(배경/opacity만 변경)와 team-design Section-spec.md §13의 토큰 기재가 heavy를 지지.

## 9. Variant 매트릭스

```
SectionItem: leadingType(none/icon/avatar/custom) × state(default/pressed/disabled) × size(small/medium/large) = 36
  대표: icon/default/medium = 4762:151, icon/pressed/medium = 4762:159, icon/disabled/medium = 4762:167,
        icon/default/small = 5265:16148, icon/default/large = 5266:613,
        custom/default/medium = 4762:175, avatar/default/medium = 4906:253
Accessory: navigation = 5230:51761, outlink = 5238:15987, toggle = 5230:51769, select = 5230:51773,
           multiselect = 5238:15981, display = 5263:11526, custom = 5431:670
```
