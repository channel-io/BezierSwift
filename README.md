# Bezier-swift
Swift components from Bezier Design System.

## Install

## Channel Sans

BezierSwift의 일반 텍스트 컴포넌트는 Channel Sans 0.1.2를 사용합니다. 앱에서도 별도 폰트 파일을 추가하지 않고 같은 폰트를 사용할 수 있습니다.

```swift
import BezierSwift

let uiFont = ChannelSans.uiFont(ofSize: 16, weight: .bold)
let swiftUIFont = ChannelSans.font(size: 16, weight: .bold)
let bundledFontURL = ChannelSans.fontURL
```

폰트 생성 시 자동 등록됩니다. 직접 등록 여부를 확인하려면 `ChannelSans.register()`를 사용하세요. 자세한 토큰 사용법은 [Typography 가이드](Sources/BezierSwift/Foundation/Typography/README.md)에 있습니다.

## Examples

`Examples/BezierExamples/BezierExamples.xcodeproj`를 Xcode에서 열어 실행하세요. (라이브러리 본체만 작업할 때는 루트의 `Package.swift`를 열면 됩니다.) 사이드바는 다음 세 그룹으로 나뉩니다:

- **V3 · Foundation**: Color Token · Typography · Icon · Dimension
- **V3 · Components**: Button · IconButton · Badge · Tag · Avatar · AvatarGroup (각 화면은 SwiftUI 섹션 위, UIKit 섹션 아래로 배치)
- **Legacy · Components**: Legacy Button (SwiftUI only)

우측 상단 toolbar로 Light/Dark · 배경색 · Dynamic Type을 토글할 수 있습니다.

## Contribute
See [contribution guide](CONTRIBUTING.md).

## Maintainers
This package is mainly contributed by Channel Corp. Although feel free to contribution, or raise concerns!
