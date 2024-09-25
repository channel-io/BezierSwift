//
//  BezierAvatar.swift
//
//
//  Created by Tom on 9/3/24.
//

import SwiftUI

// - MARK: BezierAvatar
public struct BezierAvatar: View {
  // MARK: Size
  public enum Size {
    case pt16
    case pt20
    case pt24
    case pt30
    case pt36
    case pt42
    case pt48
    case pt72
    case pt90
    case pt120
  }
  
  // MARK: Badge
  public enum Badge {
    case chat
    case status(online: Bool, doNotDisturb: Bool)
    case integration(source: BezierImageSource)
  }
  
  // MARK: Properties
  private let image: BezierImageSource
  private let size: Size
  private let badge: Badge?
  private var outlineBorder: Bool = false
  private var ellipsis: Bool = false
  
  // MARK: Initializer
  /// - Parameters:
  ///   - image: 아바타는 사용자가 업로드한 이미지를 표현합니다. 이미지가 없을 경우 `fallback` 이미지를 표현합니다.
  ///   - size: 아바타의 사이즈는 `16pt`, `20pt`, `24pt`, `30pt`, `36pt`, `42pt`, `48pt`, `72pt`, `90pt`, `120pt` 로 총 10개 사이즈를 가집니다. 주변 요소와의 균형감, 아바타 요소의 중요도에 따라 적절한 사이즈를 선택합니다.
  ///     - 아바타의 경우 예외적으로 semantic name 이 아닌, raw 한 수치 그대로 사용합니다.
  ///   - badge: 아바타에는 관련된 사람의 상태를 나타내는 현재 상태 배지가 포함될 수 있습니다.
  ///     - chat (public / private)
  ///     - status (on / off)
  ///     - integration (연동앱)
  ///       - integration은 특정 사이즈에서만 허용합니다 (`24pt`, `42pt`, `48pt`)
  public init(
    image: BezierImageSource,
    size: Size = .pt24,
    badge: Badge? = nil
  ) {
    self.image = image
    self.size = size
    self.badge = badge
  }
  
  // MARK: Body
  public var body: some View {
    self.image
      .scaledToFill()
      .if(self.ellipsis) { view in
        view
          .overlay(
            ZStack {
              BezierColor.dimBlackLight.color
              BezierIcon.more.image
                .frame(length: self.ellipsisIconLength)
                .foregroundColor(BezierColor.fgAbsoluteWhiteDark.color)
            }
          )
      }
      .frame(length: self.length)
      .clipShape(BezierAvatarShape())
      .if(self.outlineBorder) { view in
        view
          .background(
            BezierAvatarShape()
              .stroke(BezierColor.surfaceNormal.color, lineWidth: self.borderWidth * 2)
          )
      }
      .overlay(
        self.badgeContent
          .padding([.bottom, .trailing], self.badgePadding),
        alignment: .bottomTrailing
      )
      .compositingGroup()
  }
}

// - MARK: Style
extension BezierAvatar {
  private var length: CGFloat {
    switch self.size {
    case .pt16: return 16
    case .pt20: return 20
    case .pt24: return 24
    case .pt30: return 30
    case .pt36: return 36
    case .pt42: return 42
    case .pt48: return 48
    case .pt72: return 72
    case .pt90: return 90
    case .pt120: return 120
    }
  }
  
  private var borderWidth: CGFloat {
    switch self.size {
    case .pt120: return 4
    default: return 2
    }
  }
  
  @ViewBuilder
  private var badgeContent: some View {
    switch self.badge {
    case .chat:
      BezierChatBadge(size: self.chatBadgeSize)
    case .status(let online, let doNotDisturb):
      BezierStatusBadge(online: online, size: self.statusBadgeSize, doNotDisturb: doNotDisturb)
    case .integration(let source):
      switch self.size {
      case .pt24, .pt42, .pt48:
        source
          .frame(length: self.integrationBadgeLength)
          .clipShape(BezierAvatarShape())
          .background(
            BezierAvatarShape()
              .stroke(BezierColor.surfaceNormal.color, lineWidth: self.borderWidth * 2)
          )
        
      default:
        EmptyView()
      }
    case .none:
      EmptyView()
    }
  }
  
  private var chatBadgeSize: BezierChatBadge.Size {
    switch self.size {
    case .pt16, .pt20, .pt24, .pt30, .pt36, .pt42, .pt48: return .medium
    case .pt72, .pt90, .pt120: return .large
    }
  }
  
  private var statusBadgeSize: BezierStatusBadge.Size {
    switch self.size {
    case .pt16, .pt20, .pt24, .pt30, .pt36, .pt42, .pt48: return .medium
    case .pt72, .pt90, .pt120: return .large
    }
  }
  
  private var integrationBadgeLength: CGFloat {
    switch self.size {
    case .pt24: return 16
    case .pt42, .pt48: return 20
    default: return .zero
    }
  }
  
  private var badgePadding: CGFloat {
    switch self.size {
    case .pt16, .pt20, .pt24, .pt30: return -4
    case .pt36: return -3
    case .pt42, .pt48: return -2
    case .pt72, .pt90, .pt120: return 2
    }
  }
  
  private var ellipsisIconLength: CGFloat {
    return 24
  }
}

// - MARK: Extensions
extension BezierAvatar {
  /// - Parameters:
  ///   - outlineBorder: 아바타의 바깥으로 배경과 구분할 수 있도록 Outline Border white/highest 를 추가할 수 있습니다. 바깥 영역과 아바타의 구분이 필요한 경우, 아웃라인 보더를 사용할 수 있습니다. 아바타 그룹에서 주로 사용됩니다.
  public func outlineBorder(_ outlineBorder: Bool) -> Self {
    var view = self
    view.outlineBorder = outlineBorder
    return view
  }
  
  /// - Parameters:
  ///   - ellipsis: 아바타의 개수가 여러개일 때 N개 이상부터 생략되어 표기되는데 이때 생략되었음을 표현하기 위해 사용됩니다.
  public func ellipsis(_ ellipsis: Bool) -> Self {
    var view = self
    view.ellipsis = ellipsis
    return view
  }
}

#Preview {
  BezierAvatar(image: .avatar(url: URL(string: "")), size: .pt120)
}
