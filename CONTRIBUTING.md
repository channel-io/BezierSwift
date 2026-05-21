# Contributing

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

2. `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`의 `all` 배열에 `CatalogItem` 추가. `section`은 컴포넌트 세대에 따라 `.v3Components` 또는 `.legacyComponents` 선택:
   ```swift
   CatalogItem(
     id: "{component-id}",
     title: "{Component}",
     section: .v3Components,
     destination: AnyView({Component}Catalog())
   ),
   ```

3. 시뮬레이터에서 다음을 확인:
   - [ ] Foundation/Components 사이드바에 새 항목 표시
   - [ ] 모든 변형 컨트롤이 SwiftUI/UIKit 양쪽 preview에 동일하게 반영
   - [ ] 우측 상단 toolbar에서 Light/Dark 토글 시 색상 정합
   - [ ] Dynamic Type 변경 시 텍스트 크기 반영
   - [ ] 배경색 토글로 투명 영역 확인

### Foundation 토큰 catalog 추가

`Examples/BezierExamples/BezierExamples/Foundation/{Token}Catalog.swift` 파일 생성. 기존 `ColorTokenCatalog`/`TypographyCatalog` 패턴 참고. `CatalogRegistry.all`에 `section: .v3Foundation`으로 등록.

## 아키텍처 메모

- **호스트는 SwiftUI**: `RootView`(`NavigationSplitView`)가 진입점. UIKit 컴포넌트는 `UIKitWrap`/`UIKitControllerWrap` representable로 SwiftUI 화면에 임베드.
- **상하 스택**: 같은 컴포넌트의 SwiftUI/UIKit 두 구현은 한 화면에 위/아래로 배치 (토글 없음). 픽셀 정합이 의심되면 두 섹션을 나란히 비교.
- **BezierWindow**: SwiftUI App lifecycle이라도 UIKit Dialog/Toast가 동작해야 하므로 `BezierExamplesApp`의 `onAppear`에서 `BezierSwift.initializeWindow(windowScene:)` 호출.
- **`BezierExamplesComponent`**: `BezierComponentable` 기본 구현. `BCSemanticToken.palette(component:)` 처럼 component를 요구하는 UIKit API 호출 시 `.shared` 인스턴스 사용.
