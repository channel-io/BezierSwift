# BezierCard SPEC

> **SSOT**: [Figma · Mobile-Components / Card (4990:10601)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=5039-12108)
> **Design spec doc**: [team-design / bezier-v3 / components / Card-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Card-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

단일 주제·엔티티에 관한 콘텐츠를 하나의 독립 묶음으로 구분하는 범용 레이아웃 컨테이너. 배경·테두리·radius·padding만 소유하고 내용은 contentSlot에 위임한다.

## 1. Component Properties

### Card (COMPONENT `4990:10601`)

| Property | 값 | 비고 |
|---|---|---|
| **contentSlot** | SLOT | 내부 콘텐츠 자유 배치 영역 |

variant / state 축 없음 — 단일 COMPONENT (component set 아님).

총 instance: 1개 (`4990:10601`)

## 2. Layout Spec

| Part | 값 |
|---|---|
| 컨테이너 너비 | FIXED (Figma 값 361pt) |
| 컨테이너 높이 | HUG — contentSlot 높이 + 상하 패딩 |
| 패딩 | 상하 `2pt`, 좌우 `4pt` |
| radius | `16pt` (`radius/16`) |
| 테두리 | `1pt` solid |
| overflow | clip (radius 밖 콘텐츠 잘림) |
| contentSlot | FILL × HUG (너비는 패딩 안쪽을 채우고 높이는 자식에 맞춤) |

## 3. 컬러 토큰

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| 배경 | `surface` | `color/surface` | `#FFFFFF` |
| 테두리 | `borderNeutral` | `color/border/neutral` | `#00000014` |

## 4. Typography

이 컴포넌트에 텍스트 없음.

## 5. State 별 시각 동작

Figma CS에 state variant 축 없음 (정적 레이아웃 컨테이너).

## 6. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierCard.swift` |
| SwiftUI 구현 | `SUBezierCard.swift` |
| constant | `BezierCardSpec.swift` |

## 7. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **단일 슬롯 API**: Figma contentSlot(SLOT 1개)을 UIKit은 `content: UIView?` 프로퍼티(BezierBaseItem 슬롯 idiom), SwiftUI는 `@ViewBuilder content`로 표현한다.
2. **너비 거동**: Figma 컨테이너 FIXED(사용처 지정)를 UIKit은 소비자 제약, SwiftUI는 제안 폭 채움(`maxWidth: .infinity`)으로 해석 — `SUBezierSection` card variant와 동형. public resizing API는 두지 않는다(배치는 컨테이너 책임).
3. **componentTheme 지원**: UIKit `BezierComponentable`(normal/inverted) 채택 — `BezierSection`과 동형.
4. **후속 합성**: Form(MOB-6351)이 이 컨테이너를 조합할 예정 — Card는 chrome(배경·테두리·radius·패딩)만 소유하고 콘텐츠 규칙을 부과하지 않는다.

## 8. Variant 매트릭스

```
Card: 단일 COMPONENT = 4990:10601 (variant 없음, 총 1)
```
