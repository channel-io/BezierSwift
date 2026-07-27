# BezierCheckbox SPEC

> **SSOT**: [Figma · Mobile-Components / Checkbox (4838:126)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=4838-126)
> **Design spec doc**: [team-design / bezier-v3 / components / Checkbox-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Checkbox-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)
>
> 모든 수치/토큰은 Figma `Checkbox` 심볼 세트(4838:126)에 실재한다. §7 인터랙션은 Figma에 state variant가 없어 별도 협의 결정으로 분리 표기한다.

## 1. Component Overview

- **이름**: Checkbox
- **설명**: 입력·동의용 체크박스. 라벨 필수 — 라벨이 곧 체크 대상.
- **가이드라인** (Figma component description 인용):
  - 폼 입력·약관 동의에 사용. 다중 선택(라벨 없는 리스트 선택)에는 쓰지 않음 — 그 경우 ListItem 선택 패턴 사용.
  - circle·green·blue 미제공(웹 정렬). 입력/동의 전용 성격.
  - `checked`: unchecked / checked / indeterminate(하위 항목 일부 선택 — 「전체 선택」 헤더 체크박스용, DL-089)
  - `state`: default / disabled
  - `hasError`: false / true (에러 시 3px gap 링, DES-18873)
  - 터치 타깃(DL-094): 시각 박스는 22 유지, 터치 가능 영역(행 높이)은 40으로 확대(상하 8 패딩).

## 2. Component Properties

Figma `Checkbox`(4838:126) property 정의 전수.

| Figma property key | Type | Default | 옵션 / 값 | 구현 매핑 |
|---|---|---|---|---|
| `checked` | VARIANT | unchecked | unchecked / checked / indeterminate | `BezierCheckboxChecked` |
| `state` | VARIANT | default | default / disabled | `isEnabled` |
| `hasError` | VARIANT | false | false / true | `hasError` |
| `label` | TEXT | "Label" | 문자열 | `label` |

총 instance: **9개** — `checked` 3종 × {default+hasError=false, default+hasError=true, disabled+hasError=false}. **disabled+hasError 조합 variant는 Figma에 없다** (에러 링은 default state에서만 정의).

> 라벨 정책: 라벨 필수 — `hasLabel` boolean 없음, `label` TEXT 단독 제공 (Figma description "라벨 필수 — 라벨이 곧 체크 대상". DL-083 태그 출처는 design spec doc).

## 3. Layout — Figma 실측

단위 iOS `pt`. 심볼 세트 4838:126의 variant 실측 (각 variant 71×40).

| 요소 | 값 |
|---|---|
| row | H 배치, box↔label gap **8**, 상하 padding **8**, 좌우 padding 0, 세로 중앙 정렬 |
| row 높이 | **40** (= label line-height 24 + 상하 8) — 터치 타깃 (DL-094) |
| box | **22×22**, corner radius **10** (`radius/10`) |
| box border (unchecked) | **2** (inside stroke) |
| check/hyphen 아이콘 | **18×18**, box 중앙 |
| error ring (`_ring`) | **28×28**, box 중심 정렬(box 외곽에서 사방 **3** gap), stroke **1.5**, corner radius **13** |
| label | HUG (row 폭 = 콘텐츠 폭) |

### Anatomy

```text
Checkbox (H, items-center, gap 8, py 8, 높이 40)
  ├─ indicator (22×22, radius 10)
  │    ├─ _ring (28×28, radius 13, stroke 1.5)        [hasError=true 만]
  │    └─ icon/check-bold 또는 icon/hyphen-bold (18×18) [checked/indeterminate 만]
  └─ label (text/xlarge, HUG)
```

## 4. Color 토큰 (Figma 사용처 기준)

| 위치 | 조건 | Token (`BCSemanticToken`) | Figma Variable | Raw (light) |
|---|---|---|---|---|
| box 배경 | unchecked (default·hasError) | `.fillGreyLight` | `color/fill/grey/light` | `#fdfdfd` |
| box border | unchecked 전 상태 (2pt) | `.borderNeutralHeavy` | `color/border/neutral/heavy` | `rgba(0,0,0,0.15)` |
| box 배경 | unchecked + disabled | `.fillNeutralHeavy` | `color/fill/neutral/heavy` | `rgba(0,0,0,0.15)` |
| box 배경 | checked / indeterminate (전 상태) | `.fillNeutralHeaviest` | `color/fill/neutral/heaviest` | `rgba(0,0,0,0.85)` |
| check/hyphen 아이콘 | checked / indeterminate | `.iconInverseHeavier` | `color/icon/inverse/heavier` | `#ffffff` |
| error ring | hasError=true (default state만) | `.stateWarning` | `color/state/warning` | `#e67f2b` |
| label 텍스트 | 전 상태 | `.textNeutral` | `color/text/neutral` | `rgba(0,0,0,0.85)` |

- **disabled**: 행 전체 opacity `opacity/disabled` = **0.4** + unchecked box 배경이 `fillGreyLight` → `fillNeutralHeavy`로 변경 (checked/indeterminate box 배경은 유지).
- checked/indeterminate box는 border 없음.
- hasError는 링 표시 외에 box/label 색을 바꾸지 않는다.

## 5. Typography

### Case A — Typography Token 사용 (전부 토큰)

| 위치 | Token (`BTSemanticToken`) | Figma Style |
|---|---|---|
| label | `.textXLarge(weight: .regular)` | `Typography/text/xlarge` (Inter Regular, size 16, lineHeight 24, letterSpacing `text/letter-spacing/tight` −0.1) |

### Case B — Custom Typography

없음 (모든 텍스트가 토큰 사용).

## 6. State 별 시각 동작 (Figma variant 전수)

| checked | state | hasError | box 배경 | border | 아이콘 | ring | row opacity | 노드 |
|---|---|---|---|---|---|---|---|---|
| unchecked | default | false | fillGreyLight | 2 borderNeutralHeavy | — | — | 1 | 4833:122 |
| checked | default | false | fillNeutralHeaviest | — | check-bold | — | 1 | 4833:125 |
| indeterminate | default | false | fillNeutralHeaviest | — | hyphen-bold | — | 1 | 5051:66064 |
| unchecked | default | true | fillGreyLight | 2 borderNeutralHeavy | — | stateWarning | 1 | 4837:122 |
| checked | default | true | fillNeutralHeaviest | — | check-bold | stateWarning | 1 | 4837:126 |
| indeterminate | default | true | fillNeutralHeaviest | — | hyphen-bold | stateWarning | 1 | 5051:66082 |
| unchecked | disabled | false | fillNeutralHeavy | 2 borderNeutralHeavy | — | — | 0.4 | 4834:118 |
| checked | disabled | false | fillNeutralHeaviest | — | check-bold | — | 0.4 | 4834:121 |
| indeterminate | disabled | false | fillNeutralHeaviest | — | hyphen-bold | — | 0.4 | 5051:66073 |

- 아이콘 asset: `icon/check-bold` (checked) / `icon/hyphen-bold` (indeterminate) — 18×18, `color/icon/inverse/heavier`.

## 7. 인터랙션 (Figma 외 · 협의 결정)

> ⚠️ 아래는 Figma `Checkbox` 노드에 **없다** (pressed/hover variant 부재). 출처: design-team `Checkbox-spec.md` §7 Behavior + 구현 협의(MOB-6344).

- 탭 시 토글: `unchecked → checked`, `checked → unchecked`, `indeterminate → checked` (웹 `onCheckedChange(true)` 정렬).
- 상태 변경은 `onCheckedChange` 콜백으로 통지. 행 전체(라벨 포함)가 터치 타깃.
- pressed 시각 피드백 없음 (Figma에 pressed variant 없음 — 웹 hover는 포인터 전용이라 미이식).
- disabled: 입력 차단 + §4 disabled 시각.
- hasError + disabled 동시 지정 시: Figma에 해당 variant가 없어 disabled 시각을 우선하고 링은 표시하지 않는다.

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierCheckbox.swift` (`UIControl`, `BezierComponentable`) |
| SwiftUI 구현 | `SUBezierCheckbox.swift` |
| checked 축 / 상수 / 토큰 매핑 | `BezierCheckboxSpec.swift` (`BezierCheckboxChecked`, `BezierCheckboxConstant`) |

> 사용 토큰 실재 확인: `.fillGreyLight` / `.borderNeutralHeavy` / `.fillNeutralHeavy` / `.fillNeutralHeaviest` / `.iconInverseHeavier` / `.stateWarning` / `.textNeutral`(`BCSemanticToken`), `.textXLarge`(`BTSemanticToken`), `BOGlobalToken.disabled`=0.4, `BezierIcon.checkBold` / `BezierIcon.hyphenBold`(번들 asset — Figma `icon/check-bold`·`icon/hyphen-bold`와 동일 글리프 확인).

## 9. Figma 참조 노드

- 심볼 세트 frame: `4838:126` (canvas `4833:114`)
- variant 노드: §6 표 참조 (9개 전수)
