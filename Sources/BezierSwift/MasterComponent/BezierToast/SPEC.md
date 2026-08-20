# BezierToast Spec (V3)

> Figma: [🚧 Mobile Components — Toast](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/Mobile-Components?node-id=2090-17)
> Design spec doc: [Toast-spec.md (channel-io/team-design)](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Toast-spec.md)

화면 상단에 일시적으로 표시되는 비방해적 알림 (iOS 네이티브 관례).

- **모양**: rounded rect — corner radius `20` 고정 (Figma `radius/20`)
- **표면 모드**: 반전 (앱 테마의 반대 — 라이트에서 dark 표면, 다크에서 light 표면) + glass (반투명 fill + backdrop blur)
- **위치**: 상단 고정 (`top`)
- **동시 표시**: 1개 (새 Toast가 오면 기존 Toast 즉시 교체)

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **preset** | `success` / `error` / `info` | 아이콘 + 아이콘 색 자동 결정 |

> preset 외 property 없음. size / variant / state 축 없음.

총 instance: `preset × 3 = 3개` (Figma 노출 인스턴스: `2089:2` success / `2089:17` error / `2089:25` info)

---

## 2. Layout

Toast는 size 축이 없다. preset(아이콘 유무)에 따라 수평 padding만 달라진다. 단위 `pt`.

| 항목 | 값 | 비고 |
|---|---|---|
| corner radius | `20` | Figma `radius/20` 변수 바인딩 |
| vertical padding | `12` | 공통 |
| horizontal padding | `14` (info) / `12` (success·error) | 아이콘 유무 분기 |
| icon ↔ text gap | `6` | 아이콘 있는 preset만 |
| icon length | `20 × 20` | success·error |
| text 영역 상하 padding | `1` | 단일행 텍스트 블록 높이 20 (= icon length, lineHeight 18 + 1×2) |
| max width | `460` | HUG + maxWidth |
| min height | `40` | Figma root `min-h` 값. 단일행 실측 높이는 44 (= 12 + 20 + 12) |
| text line limit | `2` | 초과 시 tail truncate |

- 정렬: 아이콘과 텍스트 상단 정렬(cross-axis start), 컨테이너 내부 center. Figma 인스턴스 간 값이 갈리는데(`2089:17` error = start, `2089:2` success = center) 단일행 목업에서는 두 값의 렌더가 동일하다(모두 높이 44). design spec 문서 §6이 web·mobile 공통 `flex-start`로 명시하므로 start로 확정한다
- 좌우 여백(컨테이너 inset)은 표시 컨테이너 책임 (컴포넌트 밖) — design spec §11 기준 `10`

---

## 3. 컬러 토큰

배경/텍스트는 preset 공통. 아이콘 색만 preset별.

### Background / Text (공통)

토큰은 공통이고, 표면이 반전이므로 **앱 테마의 반대쪽 값**이 적용된다.

| Part | Token | Figma Variable | 앱 light → 적용값 | 앱 dark → 적용값 |
|---|---|---|---|---|
| 배경 | `surfaceGlass` | `color/surface/glass` | `#29292de5` (grey800_90) | `#ffffffe5` (white90) |
| 텍스트 | `textNeutral` | `color/text/neutral` | `#ffffffcc` (white80) | `#000000d9` (black85) |

> 배경 fill은 반투명(alpha 0.9) glass이고, Figma `Backdrop/large` 이펙트(BACKGROUND_BLUR, radius `backdrop/60` = 60)가 함께 걸려 있다 — description의 "배경 blur(glass)". 구현 매핑은 §9-2.
>
> **반전 근거** — Figma의 preset 컴포넌트(`2089:2` / `2089:17` / `2089:25`)는 `2. semantic/color` 컬렉션을 `dark-theme` 모드로 pin해 "light 컨텍스트에 놓인 Toast는 dark 표면"이라는 **반전 결과 1개 상태**를 목업으로 고정한 것이다. `get_variable_defs`가 dark쪽 값(`#29292de5` = grey800_90, `#51c371` = green300)을 돌려주는 것이 그 증거다. Figma는 모드가 2개뿐이라 반전 자체를 표현할 수 없으므로 "항상 dark"가 아니라 "반전"으로 읽어야 한다. 구현 매핑은 §9-1.

### Icon (preset별)

| preset | 아이콘 | Token | Figma Variable | 앱 light → 적용값 | 앱 dark → 적용값 |
|---|---|---|---|---|---|
| `success` | `check-circle-filled` | `iconAccentGreen` | `color/icon/accent/green` | `#51c371` (green300) | `#20ab55` (green400) |
| `error` | `error-diamond-filled` | `iconAccentRed` | `color/icon/accent/red` | `#f36868` (red300) | `#e1535d` (red400) |
| `info` | — *(없음)* | — | — | — | — |

> 아이콘 색은 Figma **export SVG** 기준으로 확정한다 — success `shape` path `fill="#51C371"`(= green300, dark pin 상태의 `iconAccentGreen`), error `shape` path `fill="#F36868"`(= red300, dark pin 상태의 `iconAccentRed`). `get_variable_defs`가 함께 반환하는 `color/icon/neutral`·`color/icon/absolute/white`는 아이콘 라이브러리 컴포넌트가 참조하는 변수 목록일 뿐, 이 인스턴스의 실제 렌더 색이 아니다.

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
- 배경 blur(glass): 콘텐츠 위에 올라갈 때 backdrop-blur 이펙트 발동
- 텍스트 최대 2줄 — 긴 메시지는 잘림 처리됨
- placement: top 고정 (web은 bottom-left/right)

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| SwiftUI 셀 | `SUBezierToast.swift` |
| UIKit 셀 | `BezierToast.swift` (`UIView`) |
| preset / layout 정의 | `BezierToastSpec.swift` (`BezierToastPreset`) |
| UIKit 전역 present | `BezierToastManager.swift` |

> 아이콘·컬러·typography 심볼은 §3·§4에 기재된 것을 참조한다.

---

## 9. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정을 여기에 분리 표기한다. SSOT 값이 아니다.

1. **표면 반전 구현**: §3의 반전 판독은 `componentTheme = .inverted`(UIKit) / `palette(_:isInverted: true)`(SwiftUI)로 구현한다. 근거: design spec §7 Behavior — "Toast는 `InvertedThemeProvider`로 감싸져 현재 테마가 반전되어 표시됨. 라이트 모드에서는 다크 배경, 다크 모드에서는 라이트 배경".
2. **backdrop blur 구현**: Figma `Backdrop/large`(BACKGROUND_BLUR, radius 60)는 iOS의 Ultra Thin Material로 구현한다 — SwiftUI `.ultraThinMaterial`(저장소 유틸 `applyBlurEffect(colorScheme:)`), UIKit `UIVisualEffectView`의 `systemUltraThinMaterialLight` / `systemUltraThinMaterialDark`. Toast의 semantic color는 앱 테마와 반전하지만 Material은 뒤 콘텐츠가 속한 앱 테마를 그대로 따른다.

---

## 10. Variant 매트릭스

총 instance: preset × 3 = **3개**

```text
preset=success = 2089:2   (icon: check-circle-filled → iconAccentGreen, padding v12/h12)
preset=error   = 2089:17  (icon: error-diamond-filled → iconAccentRed, padding v12/h12)
preset=info    = 2089:25  (icon 없음, padding v12/h14)
```
