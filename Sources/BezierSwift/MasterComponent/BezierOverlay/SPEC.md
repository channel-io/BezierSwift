# BezierOverlay SPEC

> **SSOT**: [Figma · Mobile-Components / overlay (5078:2253)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=5078-2253) (canvas `Overlay` = 5078:2181)
> **Design spec doc**: [team-design / bezier-v3 / components / Overlay-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Overlay-spec.md) · [BaseOverlay.md §Mobile 임베딩 패턴](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/BaseOverlay.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

DropdownMenu·Select·MultiSelect 등 목적형 오버레이로 표현할 수 없는 floating UI를 구성하는 범용 레이아웃 컨테이너(escape hatch) (Figma component description 1행).

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **content** | SLOT (`5215:13008`) | 내부 콘텐츠 영역. 자식 구조는 사용처가 자유롭게 정의 |

variant / state / boolean 축 없음 — 단일 스타일 정적 컨테이너.

총 instance: 1개 (`overlay` = `5078:2253`)

## 2. Layout Spec

| Part | 값 |
|---|---|
| container 폭 | `240pt` FIXED |
| container 높이 | auto (HUG — 콘텐츠 기반. 마스터 실측 164pt) |
| padding | `10pt` (상하좌우 균일) |
| gap | `0pt` |
| corner radius | `32pt` (`radius/32`) |
| content SLOT | 폭 `220pt` (= 240 − 10×2) — 마스터 실측 220×144pt (144pt는 placeholder 높이) |
| clipsContent | 없음 (루트 프레임 overflow clip 미적용) |

## 3. 컬러 토큰

| 영역 | Token | Figma Variable | Raw |
|---|---|---|---|
| container 배경 | `surfaceHighest` | `color/surface/highest` | `#FFFFFF` |
| shadow 색 | `elevationLarge` | `color/elevation/large` | `#00000038` |

## 4. Typography

이 컴포넌트에 텍스트 없음.

## 5. State 별 시각 동작

Figma CS에 state variant 축 없음 (정적 컨테이너).

## 6. Elevation

| Effect Style | 구성 |
|---|---|
| `Elevation/Mobile/3` | DROP_SHADOW · color `color/elevation/large` · offset (0, `elevation/4` = 4) · blur `elevation/20` = 20 · spread 0 (단일 레이어) |

## 7. 디자이너 가이드라인 (Figma component description 인용)

- DropdownMenu·Select·MultiSelect 등 목적형 오버레이로 표현할 수 없는 floating UI를 구성하는 범용 레이아웃 컨테이너(escape hatch). Mobile Select/MultiSelect의 container=overlay variant가 backdrop 없는 앵커형 팝오버로 옵션 목록을 표시할 때 이 셸을 내장한다.
- width: content SLOT에 맞춰 HUG, min 160 / max 280px 클램프
  - (실측 불일치: 현재 노드는 폭 `240pt` FIXED · SLOT `220pt` 고정 — description의 width 항목만 노드 실측과 어긋난다. 판정은 §9-5 참조)
- max-height: 고정값 없음 — 뷰포트·트리거 위치·세이프 에어리어 기준 동적 fit, 초과 시 내부 스크롤 (코드 구현 참고용, Figma 레이어로 표현 불가)
- position: 기본 bottom-start, 트리거와 8px 간격, 화면 밖이면 flip, 가장자리 마진 16px (코드 구현 참고용)
- backdrop 없음 · 외부 탭 시 닫힘 · 드래그 딜미스 없음 (BottomSheet와 구분)
- 드롭다운 선택 목록에는 DropdownMenu·Select·MultiSelect를 직접 사용한다.

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierOverlay.swift` |
| SwiftUI 구현 | `SUBezierOverlay.swift` |
| 상수 정의 | `BezierOverlaySpec.swift` |

## 9. Figma 외 · 협의 사항 (구현 결정)

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **스코프 = 시각 셸 + content 슬롯**. §7의 position(bottom-start·8pt 간격·flip·가장자리 16pt)·외부 탭 닫힘·max-height 동적 fit은 description이 "코드 구현 참고용, Figma 레이어로 표현 불가"로 명시한 프레젠테이션 거동이며, 열림/닫힘·포지셔닝 로직은 사용처 책임(Overlay-spec §7)이므로 본 컴포넌트 스코프에서 제외한다. 후속 DropdownMenu/Select 패널이 이 셸을 조합해 프레젠테이션을 구성한다.
2. **content 슬롯 API**: UIKit은 `content: UIView?` 프로퍼티(교체형 단일 슬롯), SwiftUI는 `@ViewBuilder content` — Figma의 단일 SLOT 구조에 대응.
3. **Elevation은 기존 `BezierElevation.mEv3` 재사용** — 정의(semanticColor `.elevationLarge`, y 4, blur 20)가 Figma `Elevation/Mobile/3`과 동일.
4. **폭 240pt는 내부 고정** — public resizing/width API를 노출하지 않는다 (배치는 컨테이너 책임 원칙).
5. **description width 불일치 처리**: §7의 "HUG min160/max280" 항목은 노드 실측(FIXED 240pt · SLOT 220pt)과 어긋난다. 구현은 노드 실측을 따른다. (description이 stale하다는 근거는 외부 저장소 team-design Overlay-spec에서 확인한 사항으로, Figma 안에서는 검증 불가)
6. **cornerRadius 클램프**: 카드 높이가 64pt(= 32×2) 미만이면 radius를 높이/2로 클램프한다. CALayer·UIBezierPath·RoundedRectangle 모두 radius > 높이/2에서 렌즈형 아티팩트를 그리는 반면 Figma는 렌더 시 자동 클램프하므로, 클램프가 Figma 렌더 결과와 일치한다.
7. **빈 슬롯 최소 높이**: content가 비어도 패딩 합(20pt) 높이의 카드를 유지한다 — Figma auto-layout 프레임이 자식 없이도 패딩을 유지하는 동작과 동일 (UIKit `heightAnchor ≥ 20`, SwiftUI는 VStack 래핑으로 EmptyView 소거 방지).

## 10. Variant 매트릭스

```
overlay = 5078:2253  (총 1 — variant 축 없음)
```
