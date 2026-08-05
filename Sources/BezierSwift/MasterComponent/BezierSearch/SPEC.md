# BezierSearch SPEC

> **SSOT**: [Figma · Mobile-Components / Search (2365:314)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=2365-314)
> **Design spec doc**: [team-design / bezier-v3 / components / Search-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Search-spec.md) · [BaseInput.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseInput.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

SearchIcon이 고정된 단일 행 검색 입력 필드 (Figma component description 1행).

- **배치**: width 기본 fill(부모 폭 채움). 최소 너비 40pt. leadingContent(SearchIcon)는 swap 불가
- **용도 경계**: 검색 외 일반 텍스트 입력에는 TextInput 사용 (Figma description)

## 1. Component Properties

### Search (CS `2365:314`)

| Property | 값 | 비고 |
|---|---|---|
| **state** | `default` / `focused` / `disabled` | 배경·보더·투명도 결정 |
| **hasValue** | `false` / `true` | `false`: `placeholder` 레이어만 표시, `true`: `value` 레이어만 표시 |
| **allowClear** | BOOLEAN, Figma 기본 `true` | 시스템 자동 요소 — cancel-circle-filled 아이콘 20pt. `hasValue=true` + `default`·`focused`에서만 바인딩, `disabled`·`hasValue=false`는 숨김 고정 |
| **cancelButton** | BOOLEAN, 기본 `false` | "Cancel" 텍스트 버튼. SearchField 우측 외부 배치 |
| **placeholder** / **value** | TEXT | 각 텍스트 레이어의 내용 |

- size 축 없음 — 높이 40pt 단일 고정
- variant(appearance) 축 없음

총 instance: state 3 × hasValue 2 = **6개**

자식 배치 순서: `SearchField(SearchIcon → 입력 텍스트 → allowClear) → cancelButton`

## 2. Layout Spec

| Part | 값 |
|---|---|
| 높이 (FIXED) | `40pt` |
| corner radius (SearchField) | `12pt` (`radius/12`) |
| SearchField 좌우 패딩 | `10pt` |
| SearchField 내부 gap | `6pt` |
| SearchIcon (leadingContent) | `20×20pt` |
| allowClear | `20×20pt` |
| 최소 너비 (root) | `40pt` |
| 보더(INNER_SHADOW) 두께 | `1.5pt` (spread) |
| root gap (SearchField ↔ cancelButton) | `8pt` |
| cancelButton 좌우 패딩 | `4pt` |
| cancelButton 높이 | full (root 높이 40pt, 텍스트 수직 중앙) |

- 너비: 기본 fill — 부모 폭을 채움 (Figma description). SearchField가 잔여 폭 전체를 차지하고 cancelButton은 콘텐츠 폭(hug).
- 입력 텍스트는 1줄, 초과분 ellipsis.
- 보더는 Effect `State/*` — `INNER_SHADOW, offset (0,0), radius 0, spread 1.5` (안쪽 1.5pt 라인). 배경·보더·radius는 SearchField 프레임에 적용되며 root는 순수 레이아웃 컨테이너다.

## 3. State 별 컬러 토큰

### Background (SearchField)

| State | Token | Figma Variable | Raw |
|---|---|---|---|
| `default` / `disabled` | `fillGrey` | `color/fill/grey` | `#FBFBFB` |
| `focused` | `fillGreyLight` | `color/fill/grey/light` | `#FDFDFD` |

### Border (SearchField, INNER_SHADOW 1.5pt)

| State | Effect | Token | Figma Variable | Raw |
|---|---|---|---|---|
| `default` / `disabled` | `State/default` | `stateDefault` | `color/state/default` | `#00000026` |
| `focused` | `State/active` | `stateActive` | `color/state/active` | `#000000D9` |

### Text / Icon

| 위치 | Token | Figma Variable | Raw |
|---|---|---|---|
| SearchIcon | `iconNeutral` | `color/icon/neutral` | `#00000066` |
| allowClear 아이콘 | `iconNeutral` | `color/icon/neutral` | `#00000066` |
| placeholder (`hasValue=false`) | `textNeutralLighter` | `color/text/neutral/lighter` | `#00000066` |
| value (`hasValue=true`) | `textNeutral` | `color/text/neutral` | `#000000D9` |
| cancelButton 텍스트 | `textNeutral` | `color/text/neutral` | `#000000D9` |

### Opacity

| State | 값 |
|---|---|
| `disabled` | `opacity/disabled` = 40% (root 전체 — cancelButton 포함) |

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style / Variable |
|---|---|---|
| placeholder / value | `BTSemanticToken.textXLarge(weight: .regular)` | `Typography/text/xlarge` (16 / 400 / lh 24 / ls -0.1) |
| cancelButton 텍스트 | `BTSemanticToken.textMedium(weight: .regular)` | `Typography/text/medium` (14 / 400 / lh 18 / ls 0) |

### Case B — Custom Typography

없음.

## 5. State 별 시각 동작

| State | 변경점 | clear 버튼 (`allowClear=true` 시) | 인터랙션 |
|---|---|---|---|
| `default` (empty) | 기본 — SearchIcon + placeholder | 미표시 | 활성 |
| `default` (with value) | value 텍스트 표시 | **표시** | 활성 |
| `focused` | 배경 `fillGreyLight` + 보더 `State/active` | **표시** (값 있을 때) | 편집 중 |
| `disabled` | 전체 opacity 40% | 미표시 | 비활성 |

- **clear 버튼 노출**: 값이 있으면 `default`·`focused` 모두에서 표시, `disabled`·값 없음은 숨김 고정 — Figma 렌더 조건 `hasValue && (default|focused) && allowClear` (`2450:50` default+hasValue variant에서 표시 확인).

## 6. 디자이너 가이드라인 (Figma component description 인용)

- SearchIcon이 고정된 단일 행 검색 입력 필드. placeholder는 검색 범위 명시 필수 ('검색' 단어만 금지). leadingContent는 swap 불가.
- width: 기본 fill(부모 폭 채움). 비율 지정도 가능하나 Figma는 auto-layout 기능 한계로 표현 불가(FILL/FIXED/HUG만 지원). 최소 너비 40px.
- 검색 외 일반 텍스트 입력에는 TextInput 사용.

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierSearch.swift` |
| SwiftUI 구현 | `SUBezierSearch.swift` |
| 고정 metric·상수 | `BezierSearchSpec.swift` |
| 공유 Input 레이어 (internal) | `../BezierBaseInput/BezierBaseInputSpec.swift` |

## 8. Figma 외 · 협의 사항 (구현 결정 — SSOT 값 아님)

1. **BaseInput 공유 레이어 재사용**: 배경·보더·state 해석은 `BezierBaseInputAppearance`(variant `.primary` 고정), 수치는 `BezierBaseInputMetric.small`(height 40 / radius 12 / leadingContent 20 — Figma 실측과 전항 일치)과 `BezierBaseInputConstant`(`horizontalPadding` 10 / `contentSpacing` 6 / `borderWidth` 1.5 / `minWidth` 40 / `systemElementLength` 20)를 그대로 사용한다. 재구현하지 않는다.
2. **state resolve 재사용**: `BezierBaseInputState.resolve(isEnabled:isReadOnly:hasError:isFocused:)`에 `isReadOnly: false`, `hasError: false`를 고정 전달 — 결과 도메인이 Figma의 default/focused/disabled 3종과 일치한다.
3. **allowClear 코드 기본값 `false`**: team-design Search-spec.md §10이 코드 SSOT(`@default false`)를 권위 기준으로 확정 — Figma BOOLEAN 기본 `true`는 컴포넌트 능력 노출용.
4. **clear 표시 조건 (mobile)**: `allowClear && !text.isEmpty && isEnabled` — TextInput과 달리 focused 조건 없음 (§5). clear 탭 시 값 초기화 (design spec doc §7 Behavior).
5. **SearchIcon 에셋**: `BezierIcon.search` 기존 에셋 사용 (Figma 인스턴스 SVG와 형상 일치 확인 — 원 r=8/20, 핸들 종점 등 path 동형). allowClear는 `BezierIcon.cancelCircleFilled` (TextInput 동일, SVG 형상 일치 확인).
6. **cancelButton API**: Figma BOOLEAN `cancelButton` → UIKit `showsCancelButton` / SwiftUI `showsCancelButton` (UISearchBar.showsCancelButton 관례). Figma 라벨 텍스트는 "Cancel" 고정이나 제품 로컬라이즈가 필요하므로 `cancelButtonTitle`(기본값 `"Cancel"` = Figma 값)로 노출. 탭 시 포커스 해제 + `onCancel` 콜백 — 텍스트 초기화 여부는 소비자 책임 (design spec doc이 동작 미정의).
7. **검색 키보드**: UIKit `returnKeyType` 기본값 `.search`(passthrough로 변경 가능), SwiftUI 내부 `.submitLabel(.search)` — design spec doc §7 "Enter 키 입력 시 검색 실행" 대응. 제출 콜백은 UIKit `onSubmit` 클로저 / SwiftUI 표준 `.onSubmit` modifier 상속.
8. **INNER_SHADOW → 보더 구현**: spread 1.5 / blur 0 / offset (0,0)의 INNER_SHADOW는 안쪽 1.5pt 라인과 동일 — UIKit `layer.borderWidth = 1.5`, SwiftUI `strokeBorder(lineWidth: 1.5)` (TextInput 협의 4와 동일).
9. **UITextField line-height 미적용**: 컨테이너 높이 40pt 고정 + 세로 중앙 정렬로 동일한 시각 결과 — font(16pt) + kern(-0.1)만 적용 (TextInput 협의 5와 동일).
10. **배경·보더 적용 위치**: cancelButton이 SearchField 밖에 있으므로 UIKit은 root가 아닌 내부 fieldView에 배경·보더·radius를 적용하고, disabled opacity만 root 전체에 적용한다 (Figma 구조 동일).

## 9. Variant 매트릭스

총 instance: state 3 × hasValue 2 = **6개**

```text
state=default,  hasValue=false = 2365:186
state=focused,  hasValue=false = 2365:202
state=disabled, hasValue=false = 2365:234
state=default,  hasValue=true  = 2450:50
state=focused,  hasValue=true  = 2450:63
state=disabled, hasValue=true  = 2450:76
```
