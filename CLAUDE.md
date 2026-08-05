# BezierSwift

Channel 디자인 시스템의 iOS 라이브러리. 컴포넌트 1종을 **UIKit + SwiftUI 쌍**으로 제공한다.
SPM 단일 패키지, iOS 16+, 외부 의존성 없음. 소비자는 `ch-desk-ios`.

이 문서는 에이전트 작업 규칙이다. 사람 대상 기여 절차(Examples 카탈로그 등록 등)는
[`CONTRIBUTING.md`](CONTRIBUTING.md)에 있다.

## 저장소 구조

```text
Sources/BezierSwift/
  MasterComponent/{Component}/   컴포넌트 1종 = 1 디렉토리
  Foundation/Color/{V1,V3}/      BCSemanticToken(V3) · SemanticColor(V1)
  Foundation/Typography/{V1,V3}/ BTSemanticToken(V3) · BezierFont(V1)
  Icons/BezierIcon.swift         아이콘 enum
  Util/                          BezierPressFeedback, ColorUtils
Examples/BezierExamples/         시각 검증 앱 (별도 xcodeproj)
Tests/BezierSwiftTests/          단위 테스트
```

## 명명 규칙

- SwiftUI `SUBezier*` / UIKit `Bezier*`(prefix 없음) / V1 잔존 `LegacyBezier*`
- 컴포넌트 1종 = `MasterComponent/{Bezier{Name}}/` 아래 4파일
  - `{Name}.swift` — UIKit 구현
  - `SU{Name}.swift` — SwiftUI 구현
  - `{Name}Spec.swift` — size/variant enum과 상수
  - `SPEC.md` — Figma 실측 SSOT ([`docs/spec-template.md`](docs/spec-template.md) 형식)
- enum case의 약어는 전부 대문자 — `headingXLarge`, `textXXSmall` (Swift API Design Guidelines)

**예외 (V1 시절 네이밍이라 규칙과 어긋남 — 새 코드에서 따라하지 말 것)**
`BezierDialog`·`LegacyBezierButton`·`LegacyBezierToast`는 파일명이 `Bezier*`지만 UIKit이
아니라 SwiftUI `View`다.

**SPEC.md 불요 대상** — 누락이 아니므로 새로 만들지 말 것
`BezierBaseInput`(internal 공유 레이어, `BezierTextInput/SPEC.md`가 커버) ·
`BezierDialog`·`LegacyBezier*`(V1 잔존)

## 토큰 규칙 (위반 시 리뷰 반려)

- **Semantic 토큰만 사용·노출한다** — 색은 `BCSemanticToken`, 타이포는 `BTSemanticToken`.
  Global 토큰(`BCGlobalToken`은 public, `BTGlobalToken`은 internal)은 Semantic의 내부
  구현 세부사항이다. 컴포넌트 구현과 public API 표면에 쓰지 않는다
- **`fill*` 토큰은 alpha가 내장돼 있다** — 추가 opacity를 곱하지 말 것.
  SPEC의 "fill-neutral-heavy (opacity 0.15)"는 토큰 자체의 속성 설명이지 곱할 값이 아니다.
  곱하면 SwiftUI `.opacity()`(곱셈)와 UIKit `.withAlphaComponent()`(고정)가 서로 다른
  결과를 내 두 구현이 어긋난다
- **아이콘은 `BezierIcon` enum을 우선 사용한다** — Figma의 raw asset(SVG)도 SSOT의
  일부다. SF Symbol로 임의 대체하면 SSOT 위반. 매칭 자산이 없으면 Figma export를 추가한다

## API 표면 규칙

- **배치는 컨테이너 책임** — public `resizing`/`isFullWidth` 류 프로퍼티를 만들지 않는다.
  UIKit은 스택·제약이 intrinsic size를 이기므로 무수정으로 해결되고, SwiftUI 내부에서
  stretch가 필요하면 internal init 오버로드로만 처리해 public 표면을 바꾸지 않는다
- **public 심볼에는 `///` doc comment 필수.** 선택 축 enum은 선언부에 대응하는 Figma
  property를 적고, 각 case에 "언제 쓰는지"(Selection Rules)를 1~2줄 적는다.
  Figma에 대응이 없는 축은 "코드 전용 축"으로 명시한다 — 억지 매핑보다 낫다

## 주석 정책

주석은 **비정상 코드**(회피 hack·workaround·비자명한 invariant)의 *왜*를 설명할 때만 단다.
SPEC 참조(`// SPEC §5`)·동작 설명·정상 코드의 의도는 주석이 아니라 PR description으로 쓴다.
public API의 `///` doc comment는 이 정책의 예외로 필수다.

## 빌드·테스트

```bash
xcrun simctl list devices booted          # UDID 확인 (없으면 simctl boot)
UDID=<booted-udid>

xcodebuild -scheme BezierSwift -destination "platform=iOS Simulator,id=$UDID" clean build
xcodebuild -scheme BezierSwift -destination "platform=iOS Simulator,id=$UDID" test
xcodebuild -project Examples/BezierExamples/BezierExamples.xcodeproj -scheme BezierExamples \
           -destination "platform=iOS Simulator,id=$UDID" clean build
```

- **`swift test` 불가** — UIKit 의존성 때문에 링크되지 않는다. 반드시 `xcodebuild`
- **destination은 booted UDID(`id=`)로 지정** — `name=`은 SPM 스킴에서 tvOS/visionOS
  placeholder까지 끌어들여 "Unable to find a device"로 실패한다
- **최종 검증은 clean build** — incremental cache가 타입 회귀를 가린다
- **판정은 원본 출력의 `BUILD SUCCEEDED`로** — 래퍼(`rtk` 등)의 요약은 destination 에러를
  성공으로 오판한 전례가 있다. `... 2>&1 | grep -E "error:|BUILD SUCCEEDED|BUILD FAILED"`
- doc comment/주석만 바꾼 작업은 빌드 대신 `git diff`로 검증한다(추가분이 전부 `///`이고
  삭제가 0이면 코드 무변경이 증명된다). 컴파일에 영향이 없어 빌드는 우회 증명일 뿐이다

## 상세 문서 (해당 작업을 할 때만 읽을 것)

| 문서 | 언제 |
|---|---|
| [`docs/agent/uikit-pitfalls.md`](docs/agent/uikit-pitfalls.md) | UIKit 컴포넌트 구현 |
| [`docs/agent/swiftui-pitfalls.md`](docs/agent/swiftui-pitfalls.md) | SwiftUI 컴포넌트 구현 |
| [`docs/agent/examples-pitfalls.md`](docs/agent/examples-pitfalls.md) | Examples 카탈로그 작성 |
| [`docs/agent/testing.md`](docs/agent/testing.md) | 테스트 작성·시뮬레이터 검증 |
| [`docs/spec-template.md`](docs/spec-template.md) | SPEC.md 작성 |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | 카탈로그 등록 절차·Examples 아키텍처 |
