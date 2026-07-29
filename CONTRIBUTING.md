# Contributing

> 명명·토큰·API 표면·빌드·PR 등 에이전트 작업 규칙은 [`CLAUDE.md`](CLAUDE.md)에 있다. 카탈로그 작성 중 만나는 함정은 [`docs/agent/examples-pitfalls.md`](docs/agent/examples-pitfalls.md) 참조.

## Example App에 새 컴포넌트 카탈로그 등록

V3 컴포넌트(SwiftUI `SU*` + UIKit) 또는 Foundation 토큰을 추가할 때, 시각 검증용 catalog를 `Examples/BezierExamples`에 함께 등록한다.

### 컴포넌트 catalog 추가

1. `Examples/BezierExamples/BezierExamples/Components/{Component}Catalog.swift` 파일 생성. 기존 `ButtonCatalog`/`BadgeCatalog`/`AvatarCatalog` 구조를 참고.

   기본 구조:
   ```swift
   struct {Component}Catalog: View {
     @State private var ... // 변형 컨트롤 state

     var body: some View {
       CatalogScreen(title: "{Component}") {
         self.controls                                      // 단일 컨트롤 묶음
         CatalogSection(.swiftUI) { self.swiftUIPreview }   // SwiftUI 인스턴스
         CatalogSection(.uiKit) { self.uiKitPreview }       // UIKitWrap { ... }
         // (선택) Matrix 섹션
       }
     }
   }
   ```

   - SwiftUI/UIKit 양쪽 섹션이 같은 `@State`를 구독하도록 작성 — 컨트롤은 한 번만.
   - UIKit 컴포넌트는 `UIKitWrap { make } update: { ... }` 패턴으로 임베드. `update` 클로저에서 모든 property를 다시 설정해야 state 변경이 반영됨.

2. `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`의 섹션 배열에 한 줄로 추가. 컴포넌트 세대에 따라 `v3Components` 또는 `legacyComponents` 배열을 고른다:
   ```swift
   .init(id: "{component-id}", title: "{Component}", section: .v3Components, destination: AnyView({Component}Catalog())),
   ```

   **`title` 알파벳순 위치에 삽입한다** — 배열 끝에 붙이면 병렬 PR이 같은 줄에서 충돌한다. 항목을 여러 줄로 펼치지 않는 것도 같은 이유다. `id`는 kebab-case이며 중복되면 `BezierExamplesTests`가 실패한다.

3. 시뮬레이터에서 다음을 확인:
   - [ ] Foundation/Components 사이드바에 새 항목 표시
   - [ ] 모든 변형 컨트롤이 SwiftUI/UIKit 양쪽 preview에 동일하게 반영
   - [ ] 우측 상단 toolbar에서 Light/Dark 토글 시 색상 정합
   - [ ] Dynamic Type 변경 시 텍스트 크기 반영
   - [ ] 배경색 토글로 투명 영역 확인

### Foundation 토큰 catalog 추가

`Examples/BezierExamples/BezierExamples/Foundation/{Token}Catalog.swift` 파일 생성. 기존 `ColorTokenCatalog`/`TypographyCatalog` 패턴 참고. 등록은 위와 같되 `CatalogRegistry`의 `v3Foundation` 배열에 `section: .v3Foundation`으로 추가한다.

## 아키텍처 메모

- **호스트는 SwiftUI**: `RootView`(`NavigationSplitView`)가 진입점. UIKit 컴포넌트는 `UIKitWrap`/`UIKitControllerWrap` representable로 SwiftUI 화면에 임베드.
- **상하 스택**: 같은 컴포넌트의 SwiftUI/UIKit 두 구현은 한 화면에 위/아래로 배치 (토글 없음). 픽셀 정합이 의심되면 두 섹션을 나란히 비교.
- **BezierWindow**: SwiftUI App lifecycle이라도 UIKit Dialog/Toast가 동작해야 하므로 `BezierExamplesApp`의 `onAppear`에서 `BezierSwift.initializeWindow(windowScene:)` 호출.
- **`BezierExamplesComponent`**: `BezierComponentable` 기본 구현. `BCSemanticToken.palette(component:)` 처럼 component를 요구하는 UIKit API 호출 시 `.shared` 인스턴스 사용.
