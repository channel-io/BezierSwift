# BezierSwift Example App 통합 Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Linear:** [MOB-4974](https://linear.app/channel/issue/MOB-4974/ios-bezierswift-example-app-통합-swiftuiuikit)
**Branch:** `etc/mob-4974-example-integrate`

**Goal:** `Examples/SwiftUIExample`과 `Examples/UIKitExample` 두 개의 iOS App 타겟을 단일 `BezierExamples` 앱으로 통합하여, V3 컴포넌트의 SwiftUI/UIKit 구현과 Foundation 토큰을 한 앱에서 시각 검증할 수 있는 카탈로그를 제공한다.

**Architecture:** SwiftUI를 호스트로 채택하고 UIKit 컴포넌트는 `UIKitWrap` / `UIKitControllerWrap` representable 어댑터로 SwiftUI 화면에 임베드한다. 컴포넌트 화면은 **상단에 SwiftUI 섹션, 하단에 UIKit 섹션**을 상하 스택으로 배치하여 두 구현을 한 페이지에서 즉시 비교한다 (토글 없음). 전역 `EnvironmentToolbar`로 Light/Dark, Dynamic Type, 배경색을 통제한다. `BezierSwift.xcworkspace`는 유지하되 두 개의 기존 xcodeproj 대신 단일 `Examples/BezierExamples.xcodeproj`만 등록한다.

**Tech Stack:**
- iOS 16+, Swift 5.9
- SwiftUI (`NavigationSplitView` 기반 사이드바)
- UIKit (UIViewRepresentable / UIViewControllerRepresentable bridge)
- BezierSwift V3 컴포넌트, BezierWindow (UIKit Dialog/Toast 의존성)

**Verification approach:** 시각 카탈로그 구축이라 unit test보다 **launch app + 모든 catalog 항목 방문**이 주된 검증이다. Registry/Helper 같은 비주얼 외 유틸리티는 가능한 곳에서 TDD를 적용한다. 각 catalog 화면 작업 후에는 반드시 시뮬레이터에서 실제 화면을 띄워 두 섹션(SwiftUI/UIKit)이 모두 정상 렌더되는지 확인한다.

---

## 결정된 정책 (요구사항 명세)

1. **단일 App 타겟**: 별도 SPM 모듈로 분리하지 않는다.
2. **표시 방식 = (A) 상하 스택만**: SwiftUI 위 / UIKit 아래. 토글 없음.
3. **기존 항목 보존, 패턴은 신규**: 기존 두 example의 모든 catalog 항목을 유실 없이 이관하되, 화면 구조는 새 `CatalogScreen` + `CatalogSection` 패턴으로 다시 작성한다.
4. **Workspace 유지**: `BezierSwift.xcworkspace`는 그대로 두고 example xcodeproj만 단일화한다.

---

## 파일 구조 (최종)

```
Examples/
└── BezierExamples.xcodeproj                          # 단일 App 타겟
    └── BezierExamples/
        ├── App/
        │   ├── BezierExamplesApp.swift               # @main, Scene config
        │   ├── SceneDelegate.swift                   # BezierWindow 초기화
        │   ├── RootView.swift                        # NavigationSplitView
        │   ├── CatalogItem.swift                     # 카탈로그 항목 enum + View 생성
        │   └── CatalogRegistry.swift                 # Foundation/Components 항목 목록
        ├── Shared/
        │   ├── UIKitWrap.swift                       # UIView → SwiftUI
        │   ├── UIKitControllerWrap.swift             # UIViewController → SwiftUI
        │   ├── CatalogEnvironment.swift              # 전역 환경 상태 (ObservableObject)
        │   ├── EnvironmentToolbar.swift              # toolbar items
        │   ├── CatalogScreen.swift                   # 환경 적용된 ScrollView 컨테이너
        │   └── CatalogSection.swift                  # "SwiftUI"/"UIKit" 섹션 헤더
        ├── Foundation/
        │   ├── ColorTokenCatalog.swift               # NEW (BTSemanticToken grid)
        │   ├── TypographyCatalog.swift               # SwiftUI Text + UIKit UILabel
        │   ├── IconCatalog.swift                     # SwiftUI + UIKit 양쪽
        │   └── DimensionCatalog.swift                # NEW (CornerRadius + Elevation)
        ├── Components/
        │   ├── ButtonCatalog.swift
        │   ├── IconButtonCatalog.swift
        │   ├── BadgeCatalog.swift
        │   ├── TagCatalog.swift
        │   ├── AvatarCatalog.swift                   # Avatar + AvatarStatus 한 화면
        │   └── AvatarGroupCatalog.swift
        └── Resources/
            ├── Assets.xcassets                       # SwiftUI Example에서 이관
            └── Info.plist                            # SceneDelegate 등록 포함

# 삭제 대상
Examples/SwiftUIExample/                              # 전체
Examples/UIKitExample/                                # 전체
Examples/Package.swift                                # 빈 SPM 껍데기

# 수정 대상
BezierSwift.xcworkspace/contents.xcworkspacedata     # xcodeproj 참조 갱신
README.md                                             # 실행 안내
CONTRIBUTING.md                                       # 신규 컴포넌트 등록 가이드
```

---

## Chunk 1: 프로젝트 셋업 & Skeleton

목표: 새 단일 xcodeproj를 만들고, 빈 NavigationSplitView가 시뮬레이터에서 정상 동작하는 상태까지 도달.

### Task 1.1: 새 BezierExamples xcodeproj 생성

**Files:**
- Create: `Examples/BezierExamples.xcodeproj/` (Xcode UI로 생성)
- Create: `Examples/BezierExamples/BezierExamples/` (소스 루트)

기존 `SwiftUIExample.xcodeproj`를 직접 rename하면 pbxproj 내부의 target name·bundle id·scheme이 꼬이기 쉽다. **신규 생성을 권장**.

- [ ] **Step 1: Xcode에서 새 iOS App 프로젝트 생성**

  Xcode → File → New → Project → iOS → App
  - Product Name: `BezierExamples`
  - Interface: `SwiftUI`
  - Language: `Swift`
  - Bundle Identifier: `com.channel.io.BezierExamples` (기존 SwiftUIExample의 prefix 따라감)
  - Storage: `None`
  - 저장 위치: `Examples/` (생성 시 `Examples/BezierExamples/` 폴더 안에 xcodeproj와 소스가 생성됨)
  - Deployment Target: `iOS 16.0` (생성 후 General 탭에서 설정)

- [ ] **Step 2: BezierSwift 라이브러리를 패키지 의존성으로 추가**

  BezierExamples 프로젝트 선택 → Package Dependencies → `+` → "Add Local..." → `BezierSwift` 루트 폴더 선택 → `BezierSwift` 라이브러리를 `BezierExamples` 타겟에 link.

- [ ] **Step 3: 시뮬레이터에서 기본 앱 실행 확인**

  Scheme: `BezierExamples` / Destination: iPhone 15 (또는 사용 가능한 iOS 16+ 시뮬레이터)
  Run → 기본 "Hello, World!" 화면이 뜨는지 확인.

- [ ] **Step 4: Commit**

  ```bash
  rtk git add Examples/BezierExamples
  rtk git commit -m "[MOB-4974] BezierExamples 단일 iOS App 타겟 생성"
  ```

### Task 1.2: SceneDelegate 도입 (BezierWindow 초기화)

UIKit 컴포넌트의 Dialog/Toast가 동작하려면 `BezierSwift.initializeWindow(windowScene:)`이 필요하다. SwiftUI App 라이프사이클이라도 `UIApplicationDelegateAdaptor`를 통해 Scene 구성에 SceneDelegate를 끼워야 한다.

**Files:**
- Modify: `Examples/BezierExamples/BezierExamples/BezierExamplesApp.swift`
- Create: `Examples/BezierExamples/BezierExamples/App/AppDelegate.swift`
- Create: `Examples/BezierExamples/BezierExamples/App/SceneDelegate.swift`
- Modify: `Examples/BezierExamples/BezierExamples/Info.plist`

- [ ] **Step 1: AppDelegate / SceneDelegate 생성**

  `App/AppDelegate.swift`:
  ```swift
  import UIKit

  final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
      _ application: UIApplication,
      configurationForConnecting connectingSceneSession: UISceneSession,
      options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
      let config = UISceneConfiguration(name: "Default", sessionRole: connectingSceneSession.role)
      config.delegateClass = SceneDelegate.self
      return config
    }
  }
  ```

  `App/SceneDelegate.swift`:
  ```swift
  import UIKit
  import SwiftUI
  import BezierSwift

  final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var bezierWindow: UIWindow?

    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
      guard let windowScene = scene as? UIWindowScene else { return }
      self.window = UIWindow(windowScene: windowScene)
      self.window?.rootViewController = UIHostingController(rootView: RootView())
      self.window?.makeKeyAndVisible()
      self.bezierWindow = BezierSwift.initializeWindow(windowScene: windowScene)
    }
  }
  ```

- [ ] **Step 2: BezierExamplesApp에 AppDelegate adaptor 연결**

  `BezierExamplesApp.swift`:
  ```swift
  import SwiftUI

  @main
  struct BezierExamplesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
      WindowGroup { EmptyView() } // SceneDelegate가 rootViewController를 만든다
    }
  }
  ```

  (SwiftUI WindowGroup과 SceneDelegate가 충돌하지 않도록 EmptyView 사용. SceneDelegate가 만든 hosting controller가 실제 root)

- [ ] **Step 3: Info.plist에 SceneDelegate 등록**

  `Info.plist`의 `UIApplicationSceneManifest` → `UISceneConfigurations` → `UIWindowSceneSessionRoleApplication` 배열에 다음 항목 추가:
  ```xml
  <dict>
    <key>UISceneConfigurationName</key>
    <string>Default</string>
    <key>UISceneDelegateClassName</key>
    <string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
  </dict>
  ```

- [ ] **Step 4: 빌드 & 실행 — 아직 RootView가 없어 컴파일 실패가 정상. 다음 task에서 RootView 추가.**

### Task 1.3: RootView + 빈 NavigationSplitView

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/App/RootView.swift`
- Create: `Examples/BezierExamples/BezierExamples/App/CatalogItem.swift`
- Create: `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`

- [ ] **Step 1: CatalogItem 정의**

  ```swift
  import SwiftUI

  enum CatalogSection: String, CaseIterable, Identifiable {
    case foundation = "Foundation"
    case components = "Components"
    var id: String { rawValue }
  }

  struct CatalogItem: Identifiable, Hashable {
    let id: String                 // 라우팅용 안정 키
    let title: String
    let section: CatalogSection
    let destination: AnyView

    static func == (lhs: CatalogItem, rhs: CatalogItem) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
  }
  ```

  *주의:* `AnyView` 사용은 카탈로그 항목 수가 제한적(< 30)이고 화면 전환마다 새로 만들어지는 패턴이라 성능 영향 없음.

- [ ] **Step 2: CatalogRegistry — 처음엔 빈 배열**

  ```swift
  enum CatalogRegistry {
    static let all: [CatalogItem] = []

    static func items(in section: CatalogSection) -> [CatalogItem] {
      all.filter { $0.section == section }
    }
  }
  ```

- [ ] **Step 3: RootView**

  ```swift
  import SwiftUI

  struct RootView: View {
    @State private var selection: CatalogItem?

    var body: some View {
      NavigationSplitView {
        List(selection: $selection) {
          ForEach(CatalogSection.allCases) { section in
            Section(section.rawValue) {
              ForEach(CatalogRegistry.items(in: section)) { item in
                NavigationLink(value: item) { Text(item.title) }
              }
            }
          }
        }
        .navigationTitle("BezierExamples")
      } detail: {
        if let item = selection {
          item.destination
        } else {
          ContentUnavailableView("Select an item", systemImage: "sidebar.left")
        }
      }
    }
  }
  ```

- [ ] **Step 4: 시뮬레이터 실행 — 빈 사이드바 + "Select an item" 화면 확인**

- [ ] **Step 5: Commit**

  ```bash
  rtk git add Examples/BezierExamples
  rtk git commit -m "[MOB-4974] SceneDelegate + RootView NavigationSplitView 스켈레톤"
  ```

### Task 1.4: Workspace 업데이트 (기존 xcodeproj 제거 전 단계)

이 단계에서는 새 xcodeproj **추가만** 하고, 기존 두 xcodeproj 삭제는 Chunk 6에서 한다 (롤백 가능성 확보).

**Files:**
- Modify: `BezierSwift.xcworkspace/contents.xcworkspacedata`

- [ ] **Step 1: workspace에 BezierExamples.xcodeproj 추가**

  `<FileRef location = "group:Examples/UIKitExample/UIKitExample.xcodeproj">` 옆에 한 줄 추가:
  ```xml
  <FileRef location = "group:Examples/BezierExamples/BezierExamples.xcodeproj"></FileRef>
  ```

- [ ] **Step 2: Xcode에서 workspace 열어 세 xcodeproj 모두 표시되는지 확인**

  ```bash
  open BezierSwift.xcworkspace
  ```

- [ ] **Step 3: Commit**

  ```bash
  rtk git add BezierSwift.xcworkspace
  rtk git commit -m "[MOB-4974] workspace에 BezierExamples.xcodeproj 등록"
  ```

---

## Chunk 2: Shared Infrastructure

목표: UIKit bridge, 환경 toolbar, 공통 레이아웃 컴포넌트를 만들고 더미 항목으로 wiring 검증.

### Task 2.1: UIKitWrap / UIKitControllerWrap

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Shared/UIKitWrap.swift`
- Create: `Examples/BezierExamples/BezierExamples/Shared/UIKitControllerWrap.swift`

- [ ] **Step 1: UIKitWrap 작성**

  ```swift
  import SwiftUI
  import UIKit

  struct UIKitWrap<V: UIView>: UIViewRepresentable {
    private let make: () -> V
    private let update: (V) -> Void

    init(_ make: @escaping () -> V, update: @escaping (V) -> Void = { _ in }) {
      self.make = make
      self.update = update
    }

    func makeUIView(context: Context) -> V { make() }
    func updateUIView(_ uiView: V, context: Context) { update(uiView) }
  }
  ```

- [ ] **Step 2: UIKitControllerWrap 작성**

  ```swift
  import SwiftUI
  import UIKit

  struct UIKitControllerWrap<VC: UIViewController>: UIViewControllerRepresentable {
    private let make: () -> VC
    private let update: (VC) -> Void

    init(_ make: @escaping () -> VC, update: @escaping (VC) -> Void = { _ in }) {
      self.make = make
      self.update = update
    }

    func makeUIViewController(context: Context) -> VC { make() }
    func updateUIViewController(_ uiViewController: VC, context: Context) { update(uiViewController) }
  }
  ```

- [ ] **Step 3: 빌드 확인 (사용처 없으므로 컴파일만 통과)**

- [ ] **Step 4: Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples/Shared
  rtk git commit -m "[MOB-4974] UIKitWrap / UIKitControllerWrap 어댑터"
  ```

### Task 2.2: CatalogEnvironment + EnvironmentToolbar

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Shared/CatalogEnvironment.swift`
- Create: `Examples/BezierExamples/BezierExamples/Shared/EnvironmentToolbar.swift`

- [ ] **Step 1: CatalogEnvironment**

  ```swift
  import SwiftUI

  enum CatalogBackground: String, CaseIterable, Identifiable {
    case system, white, black, gray
    var id: String { rawValue }

    var color: Color {
      switch self {
      case .system: return Color(.systemBackground)
      case .white:  return .white
      case .black:  return .black
      case .gray:   return Color(.systemGray5)
      }
    }
  }

  final class CatalogEnvironment: ObservableObject {
    @Published var colorScheme: ColorScheme? = nil   // nil = system
    @Published var dynamicTypeSize: DynamicTypeSize = .large
    @Published var background: CatalogBackground = .system
  }
  ```

- [ ] **Step 2: EnvironmentToolbar (ToolbarContent)**

  ```swift
  import SwiftUI

  struct EnvironmentToolbar: ToolbarContent {
    @ObservedObject var env: CatalogEnvironment

    var body: some ToolbarContent {
      ToolbarItemGroup(placement: .topBarTrailing) {
        Menu {
          Picker("Color Scheme", selection: $env.colorScheme) {
            Text("System").tag(ColorScheme?.none)
            Text("Light").tag(ColorScheme?.some(.light))
            Text("Dark").tag(ColorScheme?.some(.dark))
          }
          Picker("Background", selection: $env.background) {
            ForEach(CatalogBackground.allCases) { bg in
              Text(bg.rawValue.capitalized).tag(bg)
            }
          }
          Picker("Dynamic Type", selection: $env.dynamicTypeSize) {
            Text("XS").tag(DynamicTypeSize.xSmall)
            Text("M").tag(DynamicTypeSize.large)
            Text("XL").tag(DynamicTypeSize.xLarge)
            Text("XXL").tag(DynamicTypeSize.xxLarge)
            Text("AX1").tag(DynamicTypeSize.accessibility1)
            Text("AX3").tag(DynamicTypeSize.accessibility3)
          }
        } label: {
          Image(systemName: "slider.horizontal.3")
        }
      }
    }
  }
  ```

- [ ] **Step 3: RootView에 CatalogEnvironment 주입**

  `RootView.swift`:
  ```swift
  @StateObject private var env = CatalogEnvironment()
  // ...
  NavigationSplitView {
    // ...
  } detail: {
    Group {
      if let item = selection { item.destination }
      else { ContentUnavailableView("Select an item", systemImage: "sidebar.left") }
    }
    .environmentObject(env)
  }
  ```

- [ ] **Step 4: Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples
  rtk git commit -m "[MOB-4974] CatalogEnvironment + EnvironmentToolbar"
  ```

### Task 2.3: CatalogScreen + CatalogSection

`CatalogScreen`은 환경(`CatalogEnvironment`)을 ScrollView 본문에 일괄 적용하고 `EnvironmentToolbar`를 자동으로 부착하는 공통 컨테이너. `CatalogSection`은 "SwiftUI"/"UIKit" 헤더가 붙은 카드형 섹션.

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Shared/CatalogScreen.swift`
- Create: `Examples/BezierExamples/BezierExamples/Shared/CatalogSection.swift`

- [ ] **Step 1: CatalogScreen**

  ```swift
  import SwiftUI

  struct CatalogScreen<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    @EnvironmentObject private var env: CatalogEnvironment

    var body: some View {
      ScrollView {
        VStack(alignment: .leading, spacing: 24) {
          content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
      }
      .background(env.background.color)
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .preferredColorScheme(env.colorScheme)
      .dynamicTypeSize(env.dynamicTypeSize)
      .toolbar { EnvironmentToolbar(env: env) }
    }
  }
  ```

- [ ] **Step 2: CatalogSection**

  ```swift
  import SwiftUI

  enum CatalogVariant: String {
    case swiftUI = "SwiftUI"
    case uiKit = "UIKit"
  }

  struct CatalogSection<Content: View>: View {
    let variant: CatalogVariant
    @ViewBuilder let content: () -> Content

    var body: some View {
      VStack(alignment: .leading, spacing: 12) {
        Text(variant.rawValue)
          .font(.system(size: 11, weight: .semibold))
          .foregroundStyle(.secondary)
          .textCase(.uppercase)
        VStack(alignment: .leading, spacing: 12) { content() }
          .padding(12)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .stroke(Color.secondary.opacity(0.2))
          )
      }
    }
  }
  ```

- [ ] **Step 3: 더미 항목으로 wiring 검증 — CatalogRegistry에 임시 "Hello" 항목 추가**

  ```swift
  static let all: [CatalogItem] = [
    CatalogItem(
      id: "hello",
      title: "Hello",
      section: .foundation,
      destination: AnyView(
        CatalogScreen(title: "Hello") {
          CatalogSection(variant: .swiftUI) { Text("SwiftUI side") }
          CatalogSection(variant: .uiKit) {
            UIKitWrap {
              let label = UILabel()
              label.text = "UIKit side"
              return label
            }
          }
        }
      )
    ),
  ]
  ```

- [ ] **Step 4: 시뮬레이터 실행 — Hello 항목 선택 시 두 섹션이 보이고, 우측 상단 메뉴로 Dark/Background/Dynamic Type을 토글하면 화면이 반응하는지 확인**

- [ ] **Step 5: 검증 후 임시 Hello 항목 제거 후 Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples
  rtk git commit -m "[MOB-4974] CatalogScreen + CatalogSection + 환경 wiring 검증"
  ```

---

## Chunk 3: Foundation Catalogs

목표: Color, Typography, Icon, Dimension 4개 catalog 화면을 만들고 사이드바에 등록. 각 catalog는 SwiftUI/UIKit 양쪽 섹션을 모두 포함.

### Task 3.1: IconCatalog

이미 양쪽 example에 구현이 있으니 그대로 이관 + CatalogSection으로 감싼다.

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Foundation/IconCatalog.swift`
- Modify: `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`

- [ ] **Step 1: IconCatalog 작성 — 기존 `BezierIconCatalogView.swift` 로직(SwiftUI)과 `BezierIconCatalogViewController.swift`(UIKit)를 한 화면에 상하로 배치**

  파일 헤더만 예시 (전체 코드는 기존 두 파일을 통합):
  ```swift
  import SwiftUI
  import BezierSwift

  struct IconCatalog: View {
    var body: some View {
      CatalogScreen(title: "Icon") {
        CatalogSection(variant: .swiftUI) { SwiftUIIconGrid() }
        CatalogSection(variant: .uiKit) {
          UIKitControllerWrap { BezierIconCatalogViewControllerEmbedded() }
            .frame(height: 600)
        }
      }
    }
  }
  ```
  - SwiftUI 측: `BezierIconCatalogView`의 LazyVGrid 로직을 `SwiftUIIconGrid` 서브뷰로 옮김 (검색바는 카탈로그 전체 화면이 아니라 섹션 내부에만 두기 어려우므로 일단 검색 기능은 생략하고 전체 grid만)
  - UIKit 측: 기존 `BezierIconCatalogViewController`를 그대로 사용하되 collection view 높이를 정해서 임베드 (전체 스크롤은 외부 ScrollView가 담당하므로 collection view 내부 스크롤 비활성)

  *기존 검색 기능을 유지하고 싶다면 항목 위로 검색 텍스트필드를 두고 두 섹션이 공유하도록 추후 보강.*

- [ ] **Step 2: CatalogRegistry에 IconCatalog 등록**

  ```swift
  CatalogItem(id: "icon", title: "Icon", section: .foundation,
              destination: AnyView(IconCatalog()))
  ```

- [ ] **Step 3: 시뮬레이터 실행 — 사이드바에서 Icon 선택, 두 섹션에 모두 아이콘 grid가 보이는지 확인**

- [ ] **Step 4: Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples
  rtk git commit -m "[MOB-4974] IconCatalog (SwiftUI + UIKit)"
  ```

### Task 3.2: TypographyCatalog

SwiftUI 측은 기존 `TypographyTokenCatalogView`를 그대로 이관. UIKit 측은 새로 작성 (각 typo token으로 `UILabel`을 렌더).

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Foundation/TypographyCatalog.swift`
- Modify: `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`

- [ ] **Step 1: SwiftUI 섹션 — 기존 TypographyTokenCatalogView를 `SwiftUITypographySection` 서브뷰로 이관**

- [ ] **Step 2: UIKit 섹션 — 동일 토큰 enum을 순회하며 `UILabel` 생성. BezierSwift의 UIKit 측 폰트 적용 API(`applyBezierFontStyle` 대응 UIKit 메서드) 확인 후 사용**

  UIKit 측 폰트 API 위치: `Sources/BezierSwift/Foundation/Typography/V3` 하위 탐색 후 사용. (구체 API명은 코드 확인 시점에 결정 — `Font.bezierFont(style:)` 같은 UIFont 헬퍼가 있을 것)

- [ ] **Step 3: TypographyCatalog 컴포지션**

  ```swift
  struct TypographyCatalog: View {
    var body: some View {
      CatalogScreen(title: "Typography") {
        CatalogSection(variant: .swiftUI) { SwiftUITypographySection() }
        CatalogSection(variant: .uiKit) { UIKitWrap { TypographyUIKitStack() } }
      }
    }
  }
  ```

- [ ] **Step 4: 시뮬레이터 실행 — 모든 typo 토큰이 SwiftUI/UIKit 양쪽에서 동일한 시각 결과를 내는지 확인**

- [ ] **Step 5: Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples
  rtk git commit -m "[MOB-4974] TypographyCatalog (SwiftUI + UIKit)"
  ```

### Task 3.3: ColorTokenCatalog (신규)

`BTSemanticToken`의 모든 색상 토큰을 swatch + token name + (light/dark) 로 시각화.

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Foundation/ColorTokenCatalog.swift`
- Modify: `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`

- [ ] **Step 1: BTSemanticToken 토큰 목록 파악**

  ```bash
  rtk grep -r "extension BTSemanticToken" /Users/bonoogi/Projects/BezierSwift.etc-example-integrate/Sources/BezierSwift/Foundation/Color/V3
  ```

  토큰을 category (foreground/background/border 등)로 그룹화하는 enum/구조체가 있는지 확인.

- [ ] **Step 2: SwiftUI 섹션 — 토큰 그룹별 swatch grid (`Color(token:)` API 사용)**

  카드 형태로: 48×48 swatch + 토큰 이름 + hex 값

- [ ] **Step 3: UIKit 섹션 — 동일 토큰을 `UIColor(token:)`(또는 BezierSwift UIKit 측 API)로 `UIView`에 적용해 grid 표시**

- [ ] **Step 4: Dark mode 토글로 토큰 변경 확인 (EnvironmentToolbar의 colorScheme 사용)**

- [ ] **Step 5: 등록 + Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples
  rtk git commit -m "[MOB-4974] ColorTokenCatalog (신규, SwiftUI + UIKit)"
  ```

### Task 3.4: DimensionCatalog (CornerRadius + Elevation)

기존 SwiftUI Example의 `BezierElevationTestView`를 이관 + CornerRadius 토큰 시각화 추가.

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Foundation/DimensionCatalog.swift`
- Modify: `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`

- [ ] **Step 1: BezierCornerRadius / BezierElevation enum case 파악**

  ```bash
  rtk read Sources/BezierSwift/Foundation/Boxing/BezierCornerRadius.swift
  rtk read Sources/BezierSwift/Foundation/Boxing/BezierElevation.swift
  ```

- [ ] **Step 2: SwiftUI 섹션 — CornerRadius 토큰별 사각형 grid + Elevation 토큰별 그림자 카드 grid**

- [ ] **Step 3: UIKit 섹션 — 동일 토큰으로 `UIView` 모서리/그림자 적용**

- [ ] **Step 4: 등록 + Commit**

  ```bash
  rtk git add Examples/BezierExamples/BezierExamples
  rtk git commit -m "[MOB-4974] DimensionCatalog (CornerRadius + Elevation)"
  ```

---

## Chunk 4: Component Catalogs (Button 계열)

각 컴포넌트별 catalog는 기존 두 Test 화면(SwiftUI + UIKit)의 항목을 모두 보존하되, `CatalogScreen` + `CatalogSection` 패턴으로 재작성한다. 컨트롤 UI(Picker/Toggle 등 변형 선택자)는 **SwiftUI 측에 한 번만** 두고 양쪽 섹션의 표시 변형을 공통 `@State`로 동기화한다 — 컨트롤이 양쪽에 중복되면 화면이 어지러우므로.

### Task 4.1: ButtonCatalog

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Components/ButtonCatalog.swift`
- Modify: `Examples/BezierExamples/BezierExamples/App/CatalogRegistry.swift`

- [ ] **Step 1: 기존 두 Button 화면 구조 분석**
  - SwiftUI: `Examples/SwiftUIExample/SwiftUIExample/TestViews/BezierButtonTestView.swift`
  - UIKit: `Examples/UIKitExample/UIKitExample/BezierButtonTestViewController.swift`

  공통 변형 축: size / variant / semantic / title / leadingIcon / trailingIcon / isLoading / isEnabled

- [ ] **Step 2: 단일 `@State` 묶음으로 변형 선택 컨트롤 (SwiftUI Form-like) 작성**

  ```swift
  struct ButtonCatalog: View {
    @State private var size: BezierButtonSize = .medium
    @State private var variant: BezierButtonVariant = .filled
    @State private var semantic: BezierButtonSemantic = .primary
    @State private var title: String = "Label"
    @State private var hasLeadingIcon = false
    @State private var hasTrailingIcon = false
    @State private var isLoading = false
    @State private var isEnabled = true

    var body: some View {
      CatalogScreen(title: "Button") {
        controls
        CatalogSection(variant: .swiftUI) { swiftUIPreview }
        CatalogSection(variant: .uiKit) { uiKitPreview }
        CatalogSection(variant: .swiftUI) { swiftUIFullCatalogGrid }
        CatalogSection(variant: .uiKit) { uiKitFullCatalogGrid }
      }
    }
    // ... controls, previews
  }
  ```

  - "Preview" 카드 2개 (SwiftUI/UIKit) 각각 단일 인스턴스 렌더
  - "Full Catalog" 섹션 2개 (size × variant × semantic 매트릭스) 각각 SwiftUI/UIKit 렌더

- [ ] **Step 3: UIKit preview/grid는 `UIKitWrap`으로 임베드. state 바뀌면 `update` 클로저에서 button property 갱신**

- [ ] **Step 4: 시뮬레이터에서 모든 변형 토글 → SwiftUI/UIKit가 동일한 시각 결과 확인**

- [ ] **Step 5: Commit**

  ```bash
  rtk git commit -m "[MOB-4974] ButtonCatalog"
  ```

### Task 4.2: IconButtonCatalog

Task 4.1과 동일 패턴. 변형 축은 size / variant / semantic / icon / isEnabled.

- [ ] **Step 1:** 기존 두 IconButton 화면 분석 → 변형 축 확정
- [ ] **Step 2:** Catalog 작성 (single controls + SwiftUI/UIKit dual section)
- [ ] **Step 3:** Registry 등록 + 시뮬레이터 검증
- [ ] **Step 4:** Commit `[MOB-4974] IconButtonCatalog`

### Task 4.3: BadgeCatalog

- [ ] **Step 1:** 기존 두 Badge 화면 분석
- [ ] **Step 2:** Catalog 작성 (variant / size / count 등 축)
- [ ] **Step 3:** Registry 등록 + 시뮬레이터 검증
- [ ] **Step 4:** Commit `[MOB-4974] BadgeCatalog`

### Task 4.4: TagCatalog

- [ ] **Step 1:** 기존 두 Tag 화면 분석
- [ ] **Step 2:** Catalog 작성
- [ ] **Step 3:** Registry 등록 + 시뮬레이터 검증
- [ ] **Step 4:** Commit `[MOB-4974] TagCatalog`

---

## Chunk 5: Component Catalogs (Avatar 계열)

### Task 5.1: AvatarCatalog (Avatar + AvatarStatus 통합 화면)

`BezierAvatarStatus`는 별도 카탈로그 항목이 없고 기존에도 `BezierAvatarTestView`에 함께 들어있다. 한 화면에 두 컴포넌트의 SwiftUI/UIKit 섹션을 모두 둔다.

**Files:**
- Create: `Examples/BezierExamples/BezierExamples/Components/AvatarCatalog.swift`

- [ ] **Step 1:** 기존 Avatar 화면 + AvatarStatus 사용처 파악
- [ ] **Step 2:** 한 화면 구조: Avatar 변형 컨트롤 → SwiftUI Avatar / UIKit Avatar / SwiftUI AvatarStatus / UIKit AvatarStatus 4개 섹션
- [ ] **Step 3:** Registry 등록 + 시뮬레이터 검증 (특히 cornerRadius 0.42 squircle이 양쪽에서 동일하게 보이는지 — memory: `project_avatar_corner_radius`)
- [ ] **Step 4:** Commit `[MOB-4974] AvatarCatalog`

### Task 5.2: AvatarGroupCatalog

- [ ] **Step 1:** 기존 두 AvatarGroup 화면 분석
- [ ] **Step 2:** Catalog 작성 (count / size / overlap 등 축)
- [ ] **Step 3:** Registry 등록 + 시뮬레이터 검증
- [ ] **Step 4:** Commit `[MOB-4974] AvatarGroupCatalog`

---

## Chunk 6: Cleanup & Documentation

### Task 6.1: 기존 example 폴더 삭제

- [ ] **Step 1: 새 BezierExamples 앱이 모든 카탈로그 항목을 정상 표시하는지 최종 확인 (전체 sidebar 항목 클릭 일주)**

- [ ] **Step 2: 기존 두 example 폴더 삭제**

  ```bash
  rm -rf Examples/SwiftUIExample
  rm -rf Examples/UIKitExample
  rm Examples/Package.swift
  ```

- [ ] **Step 3: workspace에서 두 xcodeproj 참조 제거**

  `BezierSwift.xcworkspace/contents.xcworkspacedata`에서 다음 두 줄 삭제:
  ```xml
  <FileRef location = "group:Examples/UIKitExample/UIKitExample.xcodeproj"></FileRef>
  <FileRef location = "group:Examples/SwiftUIExample/SwiftUIExample.xcodeproj"></FileRef>
  ```

- [ ] **Step 4: Xcode에서 workspace 열어 빌드 — `BezierExamples` scheme만 남고 정상 빌드되는지 확인**

  ```bash
  open BezierSwift.xcworkspace
  ```

- [ ] **Step 5: Commit**

  ```bash
  rtk git add -A
  rtk git commit -m "[MOB-4974] 기존 SwiftUIExample / UIKitExample 폴더 및 빈 Examples/Package.swift 제거"
  ```

### Task 6.2: README / CONTRIBUTING 업데이트

**Files:**
- Modify: `README.md`
- Modify: `CONTRIBUTING.md`

- [ ] **Step 1: README.md에 Example 실행 안내 섹션 추가**

  ```markdown
  ## Examples

  `BezierSwift.xcworkspace`를 Xcode에서 열고 `BezierExamples` scheme을 선택해 실행하세요. SwiftUI/UIKit 양쪽 V3 컴포넌트와 Foundation 토큰을 한 화면에서 시각 검증할 수 있습니다.
  ```

- [ ] **Step 2: CONTRIBUTING.md에 신규 컴포넌트 추가 시 catalog 등록 가이드 추가**

  체크리스트 형태로:
  - [ ] 컴포넌트 SwiftUI/UIKit 구현
  - [ ] `Examples/BezierExamples/BezierExamples/Components/{Component}Catalog.swift` 생성
  - [ ] `CatalogRegistry.all`에 항목 추가
  - [ ] 시뮬레이터에서 다크모드/Dynamic Type 환경에서 시각 검증

- [ ] **Step 3: Commit**

  ```bash
  rtk git add README.md CONTRIBUTING.md
  rtk git commit -m "[MOB-4974] README / CONTRIBUTING — Example 통합 안내"
  ```

### Task 6.3: PR 생성

- [ ] **Step 1: develop으로 PR 생성 (base 브랜치 = develop, cross-fork PR)**

  Memory `project_v3_branch_remote`에 따라 base는 `develop`. 본 PR은 V3 직접 종속은 아니지만 V3 예제 인프라이므로 동일 컨벤션 적용.

  ```bash
  rtk gh pr create --base develop --title "[MOB-4974] BezierSwift Example App 통합 (SwiftUI + UIKit)" --body "..."
  ```

- [ ] **Step 2: PR body에 다음 포함**
  - Linear 링크 (MOB-4974)
  - Before/After 폴더 구조 다이어그램
  - 시뮬레이터 스크린샷 (사이드바, 컴포넌트 한 화면의 SwiftUI/UIKit 섹션, 환경 toolbar 사용 예)
  - Test plan 체크리스트 (전 catalog 일주, Dark/Light/Dynamic Type/배경 토글 검증)

---

## 검증 체크리스트 (전체 작업 완료 후)

- [ ] `BezierSwift.xcworkspace`에 단일 `BezierExamples.xcodeproj`만 등록되어 있다
- [ ] 사이드바 Foundation 섹션: Color / Typography / Icon / Dimension 4개 항목
- [ ] 사이드바 Components 섹션: Button / IconButton / Badge / Tag / Avatar / AvatarGroup 6개 항목
- [ ] 모든 catalog 화면이 SwiftUI 섹션 → UIKit 섹션 순으로 두 섹션을 표시한다
- [ ] EnvironmentToolbar로 Light/Dark, Dynamic Type, 배경색을 토글하면 전체 화면에 반영된다
- [ ] BezierWindow 의존 Dialog/Toast가 사용되는 경우(예: Button onTap에서 dialog 띄우는 식의 데모가 있다면) 정상 표시된다
- [ ] `Examples/SwiftUIExample` / `Examples/UIKitExample` / `Examples/Package.swift`가 모두 삭제되었다
- [ ] README / CONTRIBUTING이 신규 구조를 반영한다
