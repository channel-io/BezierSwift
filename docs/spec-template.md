# SPEC.md 작성 템플릿

컴포넌트 디렉토리의 `SPEC.md`는 **Figma SSOT의 거울**이다. Figma에 직접 매핑되는 정보만
담고, 디자인 일반론·추측·다른 컴포넌트와의 횡적 비교는 넣지 않는다. 구현 결정은 §9에
분리해 적는다.

단위는 `pt`. SPEC.md가 필요 없는 대상(internal 공유 레이어·V1 잔존)은
[`CLAUDE.md`](../CLAUDE.md)의 "SPEC.md 불요 대상" 참조.

---

````markdown
# {ComponentName} SPEC

> **SSOT**: [Figma · Mobile-Components / {Component} ({node-id})]({Figma URL}) — component key `{key}`
> **Design spec doc**: [team-design / bezier-v3 / components / {Component}-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/{Component}-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

{한 줄 컴포넌트 설명. Figma component description의 1행을 그대로 가져오기 권장.}

## 1. Component Properties

Figma 컴포넌트가 정의하는 property와 옵션은 다음이 전부다.

| Property | 값 | 비고 |
|---|---|---|
| **size** | `xxx` / `yyy` | {역할} |
| **variant** | `aaa` / `bbb` | {역할} |
| **state** | `default` / `pressed` / `disabled` / `loading` | {역할} |

총 instance: `... × ... = N개` (Figma 노출 인스턴스 수와 일치 확인)

> Figma에 단일값으로만 존재하는 property는 단일값으로 적는다. "primary는 코드 지원분" 같은
> 회피 표현 금지. COMPONENT_SET이 아니라 단일 COMPONENT면 "variant 축 없음"으로 명시한다.

## 2. Layout Spec

| Size | Height | Padding | Icon | Spacing |
|---|---|---|---|---|
| xxx | N | N | N | N |

- {계산 공식, 예: `iconLength = height - padding × 2`}
- {cornerRadius 형태 — 고정값 / 높이의 절반 등}
- {min-width·hug/fill 동작}

## 3. 컬러 토큰

### Background

| Variant | Token | Figma Variable | Raw |
|---|---|---|---|
| `aaa` | `tokenName` | `color/...` | `#......` |
| `bbb` | — *(transparent)* | — | — |

### Foreground

| Variant | Token | Figma Variable | Raw |
|---|---|---|---|

> Figma 변수에 정의돼 있지만 이 컴포넌트가 쓰지 않는 변수는 적지 않는다(노이즈).
> 컬러 레이어가 전혀 없으면 "없음 — 순수 레이아웃 컨테이너" 한 줄로 처리한다.

## 4. Typography

텍스트가 없으면 "이 컴포넌트에 텍스트 없음" 한 줄로 처리하고 표는 생략한다.

### Case A — Typography Token 사용

| 위치 | Token | Figma Style 이름 |
|---|---|---|

### Case B — Custom Typography (토큰 미적용)

5요소를 모두 적는다. iOS는 `letter-spacing`에 `NSAttributedString.Key.kern`이 필요하다.

| 위치 | Font | Size | Weight | Line Height | Letter Spacing | Custom 사유 |
|---|---|---|---|---|---|---|

> Custom typography는 디자이너의 *의도된 결정*이어야 한다. Figma에 사유가 없으면 디자이너 확인 필요.

## 5. State 별 시각 동작

| State | Variant A | Variant B | 인터랙션 |
|---|---|---|---|
| `default` | 기본 | 기본 | 활성 |
| `pressed` | ... | ... | 활성 |
| `disabled` | opacity X | opacity X | 비활성 |
| `loading` | ... | ... | 비활성 (입력 차단) |

state 축이 없으면 "Figma에 state variant 축 없음"으로 명시한다.

## 6. {선택 섹션}

컴포넌트에 해당할 때만 둔다 — `Loading Indicator` / `Elevation` / `Close Icon` /
`회전 애니메이션` / `Status Overlay 배치` / `인터랙션` 등.

## 7. 디자이너 가이드라인 (Figma component description 인용)

Figma description에 적힌 디자이너 의도를 그대로 옮긴다. 일반론을 임의로 추가하지 않는다.

- {bullet}

## 8. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `{Name}.swift` |
| SwiftUI 구현 | `SU{Name}.swift` |
| size / variant 정의 | `{Name}Spec.swift` |

> 심볼은 실재해야 한다 — prefix를 추측해서 적지 말고 코드 트리를 grep해 확인한 뒤 옮긴다.
> 코드에 SSOT와 어긋나는 정의가 있으면 그건 코드의 정리 대상이지 SPEC에 반영할 근거가 아니다.

## 9. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정을 여기에 분리 표기한다. SSOT 값이 아니다.

1. **{결정 이름}**: {내용과 근거. team-design spec의 해당 절을 인용할 것}

## 10. Variant 매트릭스

총 instance: ... × ... = **N개**

```text
{Property combination} = {Node ID}
... (전체 또는 패턴 + 일부 샘플)
```
````

---

## 자주 빠지는 함정

| 함정 | 회피책 |
|---|---|
| 코드의 enum/상수를 "코드 지원분"으로 SPEC에 포함 | Figma에 없으면 적지 마라. SPEC은 Figma의 거울이지 코드의 거울이 아니다 |
| 미사용 Figma Variable을 "참고로" 기재 | SSOT 영역 밖. 노이즈다 |
| 심볼명을 추측해서 표기 | grep으로 실재 확인 후 기재 |
| pressed/active 거동을 한 줄로 뭉뚱그림 | variant마다 다를 수 있다. 분기를 명시 |
| "보통 ~한다", "~이기 때문이다" 같은 추측·일반론 | 사실만 적는다 |
| 다른 컴포넌트 상수와의 "일관성" 메모 | 다른 컴포넌트는 별개 SSOT. 횡적 참조 금지 |
| 단일값 property를 다중값처럼 기재 | Figma에 `semantic = secondary`만 있으면 SPEC도 단일값 |
| 아이콘 색을 `get_variable_defs` 결과로 판단 | 그건 아이콘 라이브러리가 참조하는 변수 전부다. 실제 렌더색은 export SVG의 `fill`/`fill-opacity`로 확정 |
