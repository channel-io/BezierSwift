//
//  BezierAvatar.swift
//  
//
//  Created by Tom on 9/3/24.
//

import SwiftUI

import SDWebImageSwiftUI

public struct BezierAvatar<Content: View>: View {
  public typealias ContentBuilder = () -> Content
  
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
  
  public enum Badge {
    case chat
    case status(online: Bool, doNotDisturb: Bool)
    case integration(appImage: Image)
  }
  
  let size: Size
  let badge: Badge?
  let outlineBorder: Bool
  var ellipsis: Bool = false
  
  private let content: ContentBuilder
  
  public init(
    size: Size = .pt24,
    badge: Badge?,
    outlineBorder: Bool = false,
    @ViewBuilder content: @escaping ContentBuilder
  ) {
    self.size = size
    self.badge = badge
    self.outlineBorder = outlineBorder
    self.content = content
  }
  
  public init(
    url: URL?,
    size: Size = .pt24,
    badge: Badge?,
    outlineBorder: Bool = false,
    fallback: Image = BezierImage.fallback.image
  ) where Content == WebImage<_ConditionalContent<_ConditionalContent<Color, Image>, Image>> {
    self.size = size
    self.badge = badge
    self.outlineBorder = outlineBorder
    self.content = {
      WebImage(url: url) { result in
        switch result {
        case .empty:
          BezierColor.bgWhiteAlphaTransparent.color
        case .success(let image):
          image
            .resizable()
        case .failure:
          fallback
            .resizable()
        }
      }
    }
  }
  
  public var body: some View {
    self.content()
      .scaledToFill()
      .frame(length: self.length)
      .clipShape(BezierAvatarShape())
      .background(
        BezierAvatarShape()
          .stroke(BezierColor.surfaceNormal.color, lineWidth: self.borderWidth * 2)
      )
      .overlay(
        self.badgeContent
          .padding([.bottom, .trailing], self.badgePadding),
        alignment: .bottomTrailing
      )
  }
}

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
    case .integration(let appImage):
      switch self.size {
      case .pt24, .pt42, .pt48:
        appImage
          .resizable()
          .frame(length: self.integrationBadgeLength)
          .clipShape(BezierAvatarShape())
        
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
}

#Preview {
  BezierAvatar(url: .none, size: .pt120, badge: .chat)
}
