# BezierEmoji SPEC

> **SSOT**: [Figma · Mobile-Components / Emoji (3462:25)](https://www.figma.com/design/46idSffz5wpiLD5ykWUFZY/%F0%9F%9A%A7-Mobile-Components?node-id=3462-25)
> **Design spec doc**: [team-design / bezier-v3 / components / Emoji-spec.md](https://github.com/channel-io/team-design/blob/main/bezier-v3/components/Emoji-spec.md) (보조 참조 — 값 충돌 시 Figma 파일 우선)

채널톡 이모지 에셋을 지정된 크기로 표시하는 이미지 컴포넌트 (Figma component description 1행).

## 1. Component Properties

| Property | 값 | 비고 |
|---|---|---|
| **size** | `16` / `20` / `24` / `30` / `36` / `42` / `48` / `60` / `72` / `90` / `120` | 컨테이너 정사각 한 변 길이 (pt) |

총 instance: size 11개 (§9 매트릭스 참조)

> Figma COMPONENT_SET의 default variant는 `size=16`이나, design spec doc §4가 "올바른 기본값은 24 (Figma 수정 필요)"로 명시 — 코드 기본값은 `.size24` (§8.5).

## 2. Size 별 Spec

| size | Container (pt) | 콘텐츠 |
|---|---|---|
| `16` | 16×16 | 이모지 이미지를 컨테이너 크기에 맞춰 표시 |
| `20` | 20×20 | 〃 |
| `24` | 24×24 | 〃 |
| `30` | 30×30 | 〃 |
| `36` | 36×36 | 〃 |
| `42` | 42×42 | 〃 |
| `48` | 48×48 | 〃 |
| `60` | 60×60 | 〃 |
| `72` | 72×72 | 〃 |
| `90` | 90×90 | 〃 |
| `120` | 120×120 | 〃 |

- 패딩 없음, corner radius 없음, border 없음.
- 컨테이너는 고정 크기 (Figma variant가 고정 w/h — 축소·확장 속성 없음).

## 3. Variant 별 컬러 토큰

컬러 토큰 없음 — `get_variable_defs` 결과 공집합. 콘텐츠는 CDN 이미지 원본 색상 그대로 렌더된다 (design spec doc §6: "색상 바인딩이 없는 것은 Figma 구조상 정상이며 스펙 오류가 아니다").

## 4. Typography

이 컴포넌트에 텍스트 없음.

> Figma 각 variant 내부의 😊 TEXT 노드는 실제 텍스트가 아니라 이미지 플레이스홀더다 — component description 명시: "Figma에서는 CDN 이미지를 로드할 수 없어 유니코드 이모지(😊) 플레이스홀더로 표시. 실제 구현은 background-image 방식." 따라서 플레이스홀더의 폰트 수치는 구현 대상이 아니다.

## 5. State 별 시각 동작

Figma CS에 state variant 축 없음 (비인터랙티브 정적 컴포넌트).

## 6. 디자이너 가이드라인 (Figma component description 인용)

- 채널톡 이모지 에셋을 지정된 크기로 표시하는 이미지 컴포넌트.
- size: 16 / 20 / 24 / 30 / 36 / 42 / 48 / 60 / 72 / 90 / 120 (숫자 = px 크기)
- Figma에서는 CDN 이미지를 로드할 수 없어 유니코드 이모지(😊) 플레이스홀더로 표시. 실제 구현은 background-image 방식.

## 7. 매핑되는 코드 심볼

| 정의 | 파일 |
|---|---|
| UIKit 구현 | `BezierEmoji.swift` |
| SwiftUI 구현 | `SUBezierEmoji.swift` |
| size enum / CDN 상수 | `BezierEmojiSpec.swift` |
| 이미지 로더 (internal) | `BezierEmojiImageLoader.swift` |

## 8. Figma 외 · 협의 사항

Figma에 없는 구현 아키텍처 결정은 아래에 분리 표기한다. SSOT 값이 아니다.

1. **렌더 소스 = 채널톡 CDN 이미지** (design spec doc §7 Behavior):
   - `name` → URL 자동 결정: `{baseURL}/asset/emoji/images/{해상도}/{name}.png`
   - 프로덕션 `https://cf.channel.io`, 개발 `https://cf.exp.channel.io`
   - 에셋 해상도: size ≥ 60 → `160`, 미만 → `80` (design spec doc §4)
2. **CDN 환경 전역 설정**: 라이브러리는 소비자 앱의 환경을 알 수 없으므로 `BezierEmojiCDN.environment` 전역 설정(기본 `.production`)으로 분기한다. web도 개발/프로덕션 환경별 CDN URL을 분기한다 (design spec doc §7).
3. **이미지 로딩 = 내장 `URLSession` + `NSCache`** (internal `BezierEmojiImageLoader`): BezierSwift는 zero-dependency 패키지 — 외부 이미지 라이브러리를 도입하지 않는다. 로드 실패 시 빈 영역 유지 (web의 broken image 대응, design spec doc §5). 같은 이모지가 목록에 여러 번 렌더되는 것이 정상 사용 패턴이므로, 로더는 URL별 in-flight 요청을 공유해 중복 다운로드를 막는다.
4. **접근성**: web `role="img"` + `aria-description={name}` → iOS `accessibilityTraits = .image` + `accessibilityLabel = name`.
5. **기본값**: `size` 기본 `.size24` (§1 비고 — design spec doc §4 "올바른 기본값은 24").
6. **`imageUrl` prop 미도입**: web에서 deprecated (design spec doc §9 anti-pattern) — iOS는 처음부터 도입하지 않는다.
7. **스코프**: 인터랙션·state·placeholder 이미지 없음. 임의 이미지 표시는 비지원 (채널톡 이모지 에셋 전용).
8. **고정 크기 유지**: 컨테이너는 레이아웃 압박에도 축소되지 않는다 — web 구현 `flex-shrink: 0`의 대응 (design spec doc §6).
9. **콘텐츠 스케일링**: 이미지를 컨테이너 크기에 맞춰 표시한다 — web 구현이 CSS `background-size`로 조정하는 것의 대응 (design spec doc §7). iOS는 `scaleAspectFit`/`scaledToFit()` (에셋이 정사각 PNG이므로 컨테이너를 가득 채운다).

## 9. Variant 매트릭스

총 instance: size 11개

```
size=16  = 3462:3
size=20  = 3462:5
size=24  = 3462:7
size=30  = 3462:9
size=36  = 3462:11
size=42  = 3462:13
size=48  = 3462:15
size=60  = 3462:17
size=72  = 3462:19
size=90  = 3462:21
size=120 = 3462:23
```
