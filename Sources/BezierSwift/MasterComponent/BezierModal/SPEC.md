# BezierModal Spec

> Figma: [🚧 Mobile Components — Modal](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=5325-11895&m=dev)
> Linear: [MOB-6343](https://linear.app/channel/issue/MOB-6343/bezierswift-v3-modal-confirmmodal-컴포넌트-구현)

화면 중앙에 떠서 뒤 배경을 차단하는 surface 컨테이너. 내부는 `customContent` 슬롯 하나로, 임의 콘텐츠를 담는다.

- **모양**: 라운드 사각형 (radius/32 = 32pt), 하방 drop shadow (§3 Effect 참조)
- **역할**: 순수 컨테이너 — 자체 텍스트/버튼/아이콘 없음 (Figma 인스턴스 주석 `modal (그냥 순수한 컨테이너)`, node 4803:1042)
- **Modal vs Overlay** (Figma Modal 페이지 노트, node 5325:11901): 모달은 뒤가 차단되고 센터에 뜸 / 오버레이는 뒤가 차단되지 않고 트리거 근처에 뜸

---

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **customContent** | slot (children) | 컨테이너 내부를 채우는 유일한 슬롯. node 5325:11867 |

- Variant property 없음 (단일 컴포넌트, component set 아님)
- State property 없음 (default/pressed/active/disabled/loading 분기 없음)
- 텍스트 node 없음, asset(아이콘/이미지) node 없음

총 instance: **1개** (단일 컴포넌트)

---

## 2. Layout Spec

| 항목 | 값 |
|---|---|
| Width | 320pt |
| Max Width | 480pt |
| Height (Figma master) | 220pt — `customContent` 슬롯이 패딩 제외 잔여 영역(288×184)을 채움 |
| Padding Top | 20pt |
| Padding Bottom | 16pt |
| Padding Horizontal | 16pt |
| Corner Radius | `radius/32` = 32pt |
| Overflow | clip (라운드 경계로 콘텐츠 클리핑) |
| 정렬 | 세로 스택, 가로 center |
| customContent 슬롯 | 폭 full (패딩 제외), flex-grow 1, min-height 1pt |

---

## 3. 컬러 토큰

### Background

| 대상 | Figma Variable | Raw |
|---|---|---|
| 컨테이너 배경 | `color/surface/higher` | `#FFFFFF` |

### Shadow (Effect)

| 대상 | Figma Style | 구성 |
|---|---|---|
| 컨테이너 그림자 | `Elevation/Mobile/3` | DROP_SHADOW, color `color/elevation/large` (`#00000038`), offset (0, `elevation/4` = 4), blur `elevation/20` = 20, spread 0 |

Border 없음. 텍스트/아이콘 컬러 없음 (콘텐츠는 슬롯 주입).

---

## 4. Typography

이 컴포넌트에 텍스트 없음.

---

## 5. State 별 시각 동작

해당 없음. Modal 컨테이너 자체는 인터랙션 state property가 없다.

---

## 6. Loading Indicator

해당 없음.

---

## 7. 디자이너 가이드라인 (Figma 캔버스 노트 인용)

- "모달: 뒤가 차단되고 센터에 뜸 / 오버레이: 뒤가 차단되지 않고 트리거 근처에 뜸" (Modal 페이지, node 5325:11901)
- "modal (그냥 순수한 컨테이너)" (ConfirmModal 페이지의 Modal 인스턴스 주석, node 4803:1042)
- "컨펌모달이 모달을 레퍼런싱하게 고쳐놔야댐" (Modal 페이지, node 5325:11903) — ConfirmModal이 Modal 컨테이너를 재사용하는 구조를 뒷받침

---

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierModal.swift` *(MOB-6343에서 신설)* |
| SwiftUI 구현 | `SUBezierModal.swift` *(MOB-6343에서 신설)* |
| Layout 상수 정의 | `BezierModalSpec.swift` *(MOB-6343에서 신설)* |
| 배경 토큰 | `BCSemanticToken.surfaceHigher` (`Sources/BezierSwift/Foundation/Color/V3/BCSemanticToken.swift`) |
| 그림자 | `BezierElevation.mEv3` (`Sources/BezierSwift/Foundation/Boxing/BezierElevation.swift`) — (.elevationLarge, x 0, y 4, blur 20) |
| Corner radius | `BezierCornerRadius.round32` (`Sources/BezierSwift/Foundation/Boxing/BezierCornerRadius.swift`) |

> **협의 사항 (MOB-6343)**: "Modal을 컨테이너 개념으로 만들고 ConfirmModal이 Modal을 상속하거나 그 안에 컨텐츠를 채우거나 하자" — 구현체의 높이는 Figma master의 고정 220pt가 아니라 주입된 콘텐츠 크기를 따른다(hug). ConfirmModal(별도 spec)이 이 컨테이너를 재사용한다.

---

## 9. Variant 매트릭스

총 instance: **1개**

```text
Modal = 5325:11895
└─ customContent (slot) = 5325:11867
```
