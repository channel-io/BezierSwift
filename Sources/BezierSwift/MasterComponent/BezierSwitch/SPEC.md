# BezierSwitch SPEC

> **SSOT**: [Figma · Mobile-Components / Switch (1095:19)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=1095-19)
> **Design spec doc**: [team-design / bezier-v3 / components / Switch-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Switch-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

ON/OFF 설정 토글. 라벨 없음 — 라벨은 항상 외부(ListItem·행)가 소유 (Figma component description 1행).

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **checked** | `on` / `off` | thumb 위치·트랙 색 결정 |
| **state** | `default` / `disabled` | disabled는 루트 opacity 처리 |
| **hasError** | `false` / `true` | 트랙 외곽 warning ring 표시 |

총 instance: 6개 — `checked(2) × state(2)`의 `hasError=false` 4개 + `checked(2) × state=default`의 `hasError=true` 2개. `state=disabled × hasError=true` 조합은 CS에 없음.

크기 축 없음 (단일 사이즈). 텍스트 라벨 슬롯 없음.

## 2. Layout Spec

| Part | 값 | Figma Variable |
|---|---|---|
| 트랙 | `50×28pt`, radius `14pt` (pill) | `radius/14` |
| thumb | `24×24pt` 원형, 트랙 인셋 `2pt` | — |
| thumb 위치 | off: leading `2pt` / on: leading `24pt` (= 50 − 2 − 24) | — |
| thumb 그림자 | offset `(0, 2)`, blur `4` (Gaussian stdDeviation `2`), black `25%` | — |
| error ring (`_ring`) | 트랙 외곽 `3pt` 확장 프레임 `56×34pt`, stroke `1.5pt` (프레임 안쪽), pill radius | — |

- thumb 그림자 실측 근거: Figma export SVG 필터 — `feOffset dy=2` + `feGaussianBlur stdDeviation=2` + alpha `0.25`.

## 3. 컬러 토큰

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| 트랙 (checked=off) | `fillNeutralHeavy` | `color/fill/neutral/heavy` | `#00000026` |
| 트랙 (checked=on) | `fillNeutralHeaviest` | `color/fill/neutral/heaviest` | `#000000D9` |
| thumb | `iconInverseHeavier` | `color/icon/inverse/heavier` | `#FFFFFF` |
| error ring | `stateWarning` | `color/state/warning` | `#E67F2B` |
| thumb 그림자 | — *(raw black 25%, SVG 필터 값)* | — | `#000000` 25% |

| 효과 | 값 | Figma Variable |
|---|---|---|
| disabled opacity | `40%` → `0.4` | `opacity/disabled` |

## 4. Typography

이 컴포넌트에 텍스트 없음.

## 5. State 별 시각 동작

| State | 변경점 | 인터랙션 |
|---|---|---|
| `checked=off` | 트랙 `fillNeutralHeavy`, thumb 좌측 (leading 2pt) | 활성 |
| `checked=on` | 트랙 `fillNeutralHeaviest`, thumb 우측 (leading 24pt) | 활성 |
| `state=disabled` | 루트 opacity `0.4` | 비활성 (입력 차단) |
| `hasError=true` | 트랙 외곽 `stateWarning` ring 표시 | 활성 (CS에는 `state=default` 조합만 존재) |

pressed variant 없음 (CS에 press 시각 상태 미정의).

## 6. 디자이너 가이드라인 (Figma 인용)

Component description (Switch `1095:19`):

- ON/OFF 설정 토글. 라벨 없음 — 라벨은 항상 외부(ListItem·행)가 소유. 모바일에서 단독 라벨 스위치는 쓰지 않음. 설정 리스트는 ListItem + 라벨리스 Switch 조합 사용. 즉시 반영 설정 전용(저장 버튼 없음). 폼 일괄 제출 ON/OFF는 Checkbox 사용.

Canvas 디자이너 노트 (`5000:12406`):

- "스위치는 거의 Item이나 FormField에 넣어서 쓸거라 라벨 안만들었어요"

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierSwitch.swift` |
| SwiftUI 구현 | `SUBezierSwitch.swift` |
| 상수 / 토큰 매핑 | `BezierSwitchSpec.swift` |

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **API 표면**: UIKit `BezierSwitch: UIControl` — `isOn` / `setOn(_:animated:)` / `hasError` / `isEnabled`, 값 변경 시 `.valueChanged` 이벤트 발송. SwiftUI `SUBezierSwitch(isOn: Binding<Bool>, hasError: Bool = false)` — disabled는 `.disabled()` 환경으로 제어.
2. **라벨·배치는 컨테이너 책임**: size/label/full-width 류 public API 없음 (단일 사이즈 라벨리스 컴포넌트).
3. **`disabled × hasError` 조합**: CS에 없음 — 구현은 두 효과를 중첩 적용 (ring 유지 + opacity 0.4).
4. **thumb 슬라이드 애니메이션**: Mobile CS에 모션 정의 없음 — UIKit·SwiftUI 공통 easeInOut 0.2s (`UIView.animate` / `.easeInOut(duration:)`), 두 패러다임 시각 일치 목적. Reduce Motion 활성 시 애니메이션 생략(즉시 전환).
5. **그림자 단위 변환**: Figma blur `4`는 CSS blur radius — `CALayer.shadowRadius` / SwiftUI `.shadow(radius:)`는 Gaussian stdDeviation 기준이므로 `2` 적용.
6. **error ring 렌더**: UIKit은 별도 ring 뷰(`layer.border`, 트랙 밖 −3pt 확장) — CALayer border는 프레임 안쪽으로 그려져 CSS `border-box`와 동일. SwiftUI는 `Capsule().strokeBorder` overlay.

## 9. Variant 매트릭스

총 instance: **6개**

```
checked=on,  state=default,  hasError=false = 1095:7
checked=off, state=default,  hasError=false = 1095:10
checked=on,  state=disabled, hasError=false = 1095:13
checked=off, state=disabled, hasError=false = 1095:16
checked=off, state=default,  hasError=true  = 4864:251
checked=on,  state=default,  hasError=true  = 4864:254
```
