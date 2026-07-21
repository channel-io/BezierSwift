# BezierToast Spec (V3)

> Figma: [🚧 Mobile Components — Toast](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/Mobile-Components?node-id=2090-17)
> Design spec doc: [Toast-spec.md (channel-io/team-design)](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Toast-spec.md)

화면 상단에 일시적으로 표시되는 비방해적 알림 (iOS 네이티브 관례).

- **모양**: pill (완전 캡슐, radius = height / 2)
- **표면 모드**: 항상 dark (라이트/다크 무관, 항상 어두운 표면)
- **위치**: 상단 고정 (`top`)
- **동시 표시**: 1개 (새 Toast가 오면 기존 Toast 즉시 교체)

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **preset** | `success` / `error` / `info` | 아이콘 + (아이콘 색) 자동 결정 |

> preset 외 property 없음. size / variant / state 축 없음.

총 instance: `preset × 3 = 3개` (Figma 노출 인스턴스: `2089:2` success / `2089:17` error / `2089:25` info)

---

## 2. Layout

Toast는 size 축이 없다. preset(아이콘 유무)에 따라 수평 padding만 달라진다. 단위 `pt`.

| 항목 | 값 | 비고 |
|---|---|---|
| corner radius | `height / 2` (pill) | Figma `rounded-[9999px]` |
| vertical padding | `10` | 공통 |
| horizontal padding | `14` (info) / `12` (success·error) | 아이콘 유무 분기 |
| icon ↔ text gap | `6` | 아이콘 있는 preset만 |
| icon length | `20 × 20` | success·error |
| max width | `460` | HUG + maxWidth |
| min height | `40` | 아이콘 유무에 따른 높이 변동 방지 |
| text line limit | `2` | 초과 시 tail truncate |

- 정렬: 아이콘과 텍스트 상단 정렬 (아이콘 top 기준), 컨테이너 내부 center
- 좌우 여백(컨테이너 inset)은 표시 컨테이너 책임 (컴포넌트 밖)

---

## 3. 컬러 토큰

배경/텍스트는 preset 공통. 아이콘 색만 preset별.

### Background / Text (공통)

| Part | Token | Figma Variable | Raw (dark) |
|---|---|---|---|
| 배경 | `fillGreyHeavier` | `color/fill/grey/heavier` | `#313135` |
| 텍스트 | `textNeutral` | `color/text/neutral` | `#ffffffcc` |

> 배경 fill은 `color/fill/grey/heavier`(불투명). Figma에는 `Backdrop/small`(BACKGROUND_BLUR radius 6) 이펙트와 description "배경 blur(glass)"도 함께 존재하나, 바인딩된 배경 fill은 불투명이다.
>
> Toast는 항상 dark 표면이므로 Figma가 노출한 dark 값을 적용한다.

### Icon (preset별)

| preset | 아이콘 | Figma 바인딩 | Raw |
|---|---|---|---|
| `success` | `check-circle-filled` | `color/icon/neutral` + `color/icon/absolute/white` + `color/icon/neutral/heavy` (복합) | `#ffffff66` + `#ffffff` + `#ffffff99` |
| `error` | `error-diamond-filled` | `color/icon/neutral/heavy` | `#ffffff99` |
| `info` | — *(없음)* | — | — |

---

## 4. Typography

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|
| 메시지 텍스트 | `textMedium(weight: .bold)` | `Typography/text/medium-bold` |

> Figma `Typography/text/medium-bold` = Inter / Bold(700) / size 14 / lineHeight 18 / letterSpacing 0. `BTSemanticToken.textMedium(weight: .bold)`이 정확 매칭 (fontSize 14 / lineHeight 18). `labelMedium`은 lineHeight 20이라 불일치.

---

## 5. State 별 시각 동작

Figma 컴포넌트는 정적 목업이며 state 축이 없다. 아래 런타임 거동은 **design spec 문서** 및 Figma description 기준.

| State | 트리거 | 동작 | 근거 |
|---|---|---|---|
| enter | present 호출 | 상단에서 슬라이드 다운 + 페이드 인 | design spec §5 |
| visible | 표시 중 | 정지 (pass-through) | design spec §7 |
| exit | 3초 경과 또는 교체 | 페이드 아웃 | Figma description "3초 자동해제" |

- 자동 해제: 3초 (design spec `autoDismissTime` 기본 3.0)
- 동시 1개: 새 Toast가 오면 기존 Toast 즉시 교체 (design spec §11 "최대 동시 표시 수: 1")
- 텍스트 최대 2줄 잘림 (Figma description)

---

## 6. Loading Indicator

이 컴포넌트에 로딩 인디케이터 없음.

---

## 7. 디자이너 가이드라인 (Figma 컴포넌트 description 인용)

- 화면 상단에 일시적으로 표시되는 비방해적 알림 (iOS 네이티브 관례)
- 3초 후 자동 해제 — 사용자가 반드시 확인해야 하는 오류는 Banner 사용
- 텍스트 최대 2줄 — 긴 메시지는 잘림 처리
- placement: top 고정 (web은 bottom-left/right)

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| SwiftUI 셀 | `SUBezierToast.swift` |
| UIKit 셀 | `BezierToast.swift` (`UIView`) |
| preset / layout 정의 | `BezierToastSpec.swift` (`BezierToastPreset`) |
| UIKit 전역 present | `BezierToastManager.swift` |

> 위 파일은 구현 예정(신규). 아이콘·컬러·typography 심볼은 §3·§4에 기재된 것을 참조한다.

---

## 9. Variant 매트릭스

총 instance: preset × 3 = **3개**

```
preset=success = 2089:2   (icon: check-circle-filled, h-padding 12)
preset=error   = 2089:17  (icon: error-diamond-filled, h-padding 12)
preset=info    = 2089:25  (icon 없음, h-padding 14)
```
