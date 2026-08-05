# 테스트·시각 검증

테스트를 쓰거나 시뮬레이터로 확인할 때만 읽으면 된다. 빌드 명령의 기본 규칙은
[`CLAUDE.md`](../../CLAUDE.md)에 있다.

## 실행

```bash
xcrun simctl list devices booted          # UDID 확인
UDID=<booted-udid>

xcodebuild -scheme BezierSwift -destination "platform=iOS Simulator,id=$UDID" test
```

`swift test`는 UIKit 의존성 때문에 동작하지 않는다. 테스트 타겟은 `BezierSwiftTests` 하나이고
소스는 `Tests/BezierSwiftTests/`에 플랫 구조로 둔다.

## 프레임워크

신규 테스트는 **Swift Testing**(`import Testing`)으로 쓴다. 저장소에 XCTest 파일이 2개
남아 있으나(`ColorUtils*Tests.swift`) 신규 작성 기준은 아니다.

## UIKit 레이아웃 테스트는 `UIWindow`가 필요하다

window 없는 detached 뷰는 제약이 required여도 `frame.width`가 0으로 나오는 아티팩트가 있다.
반드시 `UIWindow`에 붙인 뒤 `window.layoutIfNeeded()`를 호출해야 실제 압축·크기가 측정된다.

```swift
let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: 40))
let window = UIWindow(frame: container.bounds)
window.addSubview(container)
container.addSubview(stack)
// 제약 활성화 후
window.setNeedsLayout()
window.layoutIfNeeded()
```

`container.layoutIfNeeded()`만으로는 부족하다. MOB-6018에서 이 차이 때문에 수정 전후 모두
`frame.width == 0`으로 나와 오판할 뻔했다. 전문은 `BezierBadgeLayoutTests.swift` 참조.

## UIKit을 다루는 Suite는 `@MainActor` + `.serialized`

Swift Testing은 기본 병렬 실행이라 UIView를 백그라운드 스레드에서 만들어 크래시한다
("Main Thread Checker: UI API called on a background thread").

```swift
@Suite("BezierBadge Layout - Compression Resistance", .serialized)
@MainActor
struct BezierBadgeLayoutTests { ... }
```

순수 값·Spec 해석 Suite에는 붙이지 않는다 — 저장소도 UIKit 뷰를 인스턴스화하는 Suite에만
붙이고 있다.

## 시뮬레이터 시각 검증

macOS 화면 캡처·접근성 도구는 쓰지 않는다. 시뮬레이터 자체 기능(`simctl`)과 `idb`가 정확하다.

```bash
xcrun simctl io $UDID screenshot out.png
xcrun simctl io $UDID recordVideo --codec h264 out.mp4   # 백그라운드 실행 후 kill -INT로 finalize
xcrun simctl ui $UDID appearance dark                    # light | dark
idb ui tap --udid $UDID <x> <y>
idb ui describe-all --udid $UDID
```

- **탭 좌표는 pt** = 스크린샷 pixel ÷ scale (iPhone 17 = 402×874, 3x). pixel 좌표를 그대로
  넣으면 화면 밖이라 무시된다
- **SwiftUI `Toggle`·세그먼트는 기본 tap을 무시한다** — `idb ui tap ... --duration 0.05` 필요.
  `NavigationLink` 행은 기본 tap으로 동작
- 라이트/다크 정합, always-dark 컴포넌트의 이중 pin은 코드만으로 검증되지 않는다. 두 모드를
  각각 캡처해 비교할 것
- 애니메이션은 `ffmpeg -ss {t} -frames:v 1`로 프레임을 뽑아 위상을 비교한다
