import SwiftUI
import UIKit
import BezierSwift

struct ColorTokenCatalog: View {
  var body: some View {
    CatalogScreen(title: "Color Token") {
      // 170개 × (SwiftUI + UIKit) = 340개 스와치다. CatalogScreen의 VStack은 lazy하지 않아
      // 그룹 전체를 한꺼번에 레이아웃하고, 그러면 스킴을 바꿀 때 UIKit 뷰 update가 전부
      // 재실행돼 화면이 수 초 비어 있다. 보이는 그룹만 처리하도록 여기서 한 겹 감싼다.
      LazyVStack(alignment: .leading, spacing: 24) {
        ForEach(ColorTokenGroup.all) { group in
          VStack(alignment: .leading, spacing: 8) {
            Text(group.title)
              .font(.system(size: 13, weight: .semibold))
              .foregroundStyle(.secondary)
              .textCase(.uppercase)
            CatalogSection(.swiftUI) {
              SwiftUISwatchGrid(tokens: group.tokens)
            }
            CatalogSection(.uiKit) {
              UIKitSwatchGrid(tokens: group.tokens)
            }
          }
        }
      }
    }
  }
}

// MARK: - Group definition

private struct ColorTokenSpec: Identifiable {
  let token: BCSemanticToken
  let name: String
  let segments: [String]
  var id: String { self.name }

  init(_ token: BCSemanticToken) {
    let segments = TokenName.segments(token)
    self.token = token
    self.segments = segments
    self.name = segments.joined(separator: "-")
  }
}

private struct ColorTokenGroup: Identifiable {
  let title: String
  let tokens: [ColorTokenSpec]
  var id: String { self.title }

  /// 그룹이 이보다 커지면 세그먼트를 한 단계 더 써서 쪼갠다. 지금은 `fill` 83개만 걸린다.
  private static let maxTokensPerGroup = 48

  static let all: [ColorTokenGroup] = Self.grouped(
    BCSemanticToken.allCases.map(ColorTokenSpec.init),
    depth: 1
  )

  private static func grouped(_ specs: [ColorTokenSpec], depth: Int) -> [ColorTokenGroup] {
    var keysInOrder: [String] = []
    var buckets: [String: [ColorTokenSpec]] = [:]

    for spec in specs {
      let key = spec.segments.prefix(depth).joined(separator: " ")
      if buckets[key] == nil {
        keysInOrder.append(key)
      }
      buckets[key, default: []].append(spec)
    }

    return keysInOrder.flatMap { key -> [ColorTokenGroup] in
      let bucket = buckets[key] ?? []
      let hasDeeperSegment = bucket.contains { $0.segments.count > depth }
      if bucket.count > Self.maxTokensPerGroup, hasDeeperSegment {
        return Self.grouped(bucket, depth: depth + 1)
      }
      return [ColorTokenGroup(title: key.capitalized, tokens: bucket)]
    }
  }
}

// MARK: - SwiftUI grid

private struct SwiftUISwatchGrid: View {
  let tokens: [ColorTokenSpec]
  @Environment(\.colorScheme) private var colorScheme

  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(self.tokens) { spec in
        VStack(alignment: .leading, spacing: 6) {
          RoundedRectangle(cornerRadius: 6)
            .fill(self.colorScheme == .dark ? spec.token.dark.color : spec.token.light.color)
            .frame(height: 44)
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color.secondary.opacity(0.25))
            )
          Text(spec.name)
            .font(.system(size: 10))
            .lineLimit(2)
            .foregroundStyle(.secondary)
        }
      }
    }
  }
}

// MARK: - UIKit grid

private struct UIKitSwatchGrid: View {
  let tokens: [ColorTokenSpec]

  private let columns = [GridItem(.adaptive(minimum: 140), spacing: 12)]

  var body: some View {
    LazyVGrid(columns: self.columns, spacing: 12) {
      ForEach(self.tokens) { spec in
        VStack(alignment: .leading, spacing: 6) {
          UIKitSizedWrap({
            let view = UIView()
            view.layer.cornerRadius = 6
            view.layer.borderWidth = 1
            return view
          }, update: { (view: UIView) in
            view.backgroundColor = spec.token.palette(BezierExamplesComponent.shared)
            // CGColor는 dynamic UIColor를 만든 시점의 trait로 굳는다. 스킴이 바뀌면 다시 넣어야 한다.
            view.layer.borderColor = UIColor.separator
              .resolvedColor(with: view.traitCollection).cgColor
          })
          .frame(height: 44)
          Text(spec.name)
            .font(.system(size: 10))
            .lineLimit(2)
            .foregroundStyle(.secondary)
        }
      }
    }
  }
}
