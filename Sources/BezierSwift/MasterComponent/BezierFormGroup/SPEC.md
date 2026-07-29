# BezierFormGroup SPEC

> **SSOT**: [Figma · Mobile-Components / FormGroup (5071:692)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=5071-692) — component key `b35c73ce1d4571e4222b4f0c59828db013f9f112`
> **Design spec doc**: [team-design / bezier-v3 / components / FormGroup-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/FormGroup-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

체크박스·스위치 등 독립 상태 컨트롤 여러 개를 묶을 때의 간격·정렬을 정의하는 레이아웃 그룹 컴포넌트 (Figma component description 1행).

## 1. Component Properties

단일 COMPONENT (COMPONENT_SET 아님) — variant/property 축 없음.

| Property | 값 | 비고 |
|---|---|---|
| **content** | SLOT | Checkbox 인스턴스 전용 (`preferredValues` = Checkbox CS `4838:126`, `allowPreferredValuesOnly: true`) |

총 instance: 단일 COMPONENT `5071:692` 1개

## 2. Layout Spec

| Part | 값 |
|---|---|
| 루트 (FormGroup) | 세로 오토레이아웃, HUG×HUG, 좌측 정렬, 패딩 없음 — `content` 슬롯 하나만 포함 |
| `content` SLOT | 세로 오토레이아웃, itemSpacing `4pt`, HUG×HUG, 좌측 정렬, 패딩 없음 |

기본 슬롯 콘텐츠 실측: Checkbox 인스턴스 3개 (각 높이 40pt, y = 0/44/88 → 간격 4pt, 전체 166×128pt).

## 3. 컬러 토큰

없음 — FormGroup 자체 레이어(루트·`content`)에는 fill·border·shadow·radius가 하나도 없다. 순수 레이아웃 컨테이너.

## 4. Typography

이 컴포넌트에 텍스트 없음 (Figma 텍스트 노드는 전부 자식 Checkbox 인스턴스 내부 소유).

## 5. State 별 시각 동작

Figma에 state variant 축 없음 — FormGroup 자체는 시각 상태가 없는 정적 컨테이너다. disabled/hasError 등은 각 자식 Checkbox가 개별 표현한다.

## 6. 디자이너 가이드라인 (Figma component description 인용)

- 체크박스·스위치 등 독립 상태 컨트롤 여러 개를 묶을 때의 간격·정렬을 정의하는 레이아웃 그룹 컴포넌트.
- 라벨은 소유하지 않는다 — 그룹 전체를 설명하는 라벨이 필요하면 상위 FormField의 FormLabel을 사용한다.
- 📱 Mobile 스코프(DL-090): 자식은 Checkbox(DL-084) 전용 — 입력·동의 그룹 목적. 「전체 선택」 indeterminate 헤더(DL-089)도 이 스코프에 포함. 다중선택 리스트(ListItem trailing check)는 대상 아님 — ListItem/MultiSelect 사용.
- direction: vertical 고정(DL-092) — 내부(bezier-compose·cht-desk-android·cht-desk-ios 전수 조사, 가로 배치 0건) + 업계(Material Design 3·Apple HIG 모두 세로 리스트 컨벤션) 근거로 확정. horizontal은 web 전용.
- spacing: 4dp(최종 확정, DL-094) — 40dp 터치 타깃 자체 패딩(16dp 시각 여백)과 별개로, 인접 타깃 간 최소 간격(Google 접근성 가이드 「8dp 이상」 권장의 절반)을 확보하기 위한 명시적 gap. FormGroup-spec.md §4/§6 참조.
- content: SLOT — Checkbox 인스턴스만 추가/삭제 가능(restrict to Checkbox).

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierFormGroup.swift` |
| SwiftUI 구현 | `SUBezierFormGroup.swift` |
| constant | `BezierFormGroupSpec.swift` |

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **자식 API는 뷰 일반형**: Figma SLOT은 Checkbox 전용으로 제한되지만, 코드 API는 `UIView` 배열(UIKit) / `@ViewBuilder`(SwiftUI)로 받고 Checkbox 타입 하드 의존을 두지 않는다. Checkbox 전용 스코프는 doc comment로 안내한다.
2. **spacing 노출**: team-design spec §10 [Mobile]이 `spacing` prop(기본 4dp)을 제안 — 코드도 `spacing` 파라미터(기본값 `BezierFormGroupConstant.contentSpacing` = 4pt)로 노출한다. direction은 vertical 고정이라 prop을 만들지 않는다(동 §10).
3. **접근성 그룹핑**: 웹 `role="group"` 대응(team-design spec §3 [Mobile]) — UIKit은 `shouldGroupAccessibilityChildren = true`, SwiftUI는 `.accessibilityElement(children: .contain)` 적용. 라벨은 렌더링하지 않는다.
4. **상태 비소유**: 선택 상태(value/onChange 류) prop을 만들지 않는다 — 각 자식 컨트롤이 자기 상태를 소유한다 (team-design spec §9 Anti-pattern #1).
5. **componentTheme 미보유**: 자체 컬러 레이어가 없어 `BezierComponentable`을 채택하지 않는다. 자식 Checkbox의 테마는 소비자가 각 자식에 직접 지정한다.
