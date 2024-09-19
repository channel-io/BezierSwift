//
//  BezierEmoji.swift
//
//
//  Created by Tom on 9/19/24.
//

import SwiftUI

import SDWebImageSwiftUI

private enum Metric {
  static let bottomTrailingPadding: CGFloat = -4
}

private enum Constant {
  static let emojiUrlString: String = "https://cf.channel.io/asset/emoji/images/80/%@.png"
}
// - MARK: BezierAvatar
public struct BezierEmoji: View {
  // MARK: Size
  public enum Size {
    case pt16
    case pt20
    case pt24
    case pt30
    case pt36
    case pt42
    case pt48
    case pt60
    case pt72
    case pt90
    case pt120
  }
  
  // MARK: Badge
  public enum Badge {
    case chat
  }
  
  // MARK: Properties
  private let name: String
  private let size: Size
  private let badge: Badge?
  
  private var emojiUrl: URL? {
    if let encodedEmojiUrlString = String(format: Constant.emojiUrlString, self.name).percentEncode() {
      return URL(string: encodedEmojiUrlString)
    } else {
      return nil
    }
  }
  
  // MARK: Initializer
  /// - Parameters:
  ///   - name: ch-asset 기반으로 emoji 의 file name 을 사용합니다.
  ///     - emojipedia 를 통해 name을 검색 할 수 있으며, Shortcodes/github 기준으로 사용합니다.
  ///     - ex) https://emojipedia.org/😄#technical
  ///   - size: emoji 사이즈는 `16pt`, `20pt`, `24pt`, `30pt`, `36pt`, `42pt`, `48pt`, `60pt`, `72pt`, `90pt`, `120pt` 로 총 11개 사이즈를 가집니다.
  ///     - emoji의 경우 예외적으로 semantic name 이 아닌, raw 한 수치 그대로 사용합니다.
  ///   - badge: 이모지의 상태 배지가 포함될 수 있습니다.
  ///     - chat (public / private)
  public init(name: String, size: Size, badge: Badge? = nil) {
    self.name = name
    self.size = size
    self.badge = badge
  }
  
  // MARK: Body
  public var body: some View {
    WebImage(url: self.emojiUrl)
      .resizable()
      .scaledToFit()
      .frame(length: self.length)
      .if(self.badge.isNotNil) { view in
        view
          .overlay(
            BezierChatBadge(size: .medium)
              .padding([.bottom, .trailing], Metric.bottomTrailingPadding),
            alignment: .bottomTrailing
          )
      }
  }
}

// - MARK: Style
extension BezierEmoji {
  private var length: CGFloat {
    switch self.size {
    case .pt16: return 16
    case .pt20: return 20
    case .pt24: return 24
    case .pt30: return 30
    case .pt36: return 36
    case .pt42: return 42
    case .pt48: return 48
    case .pt60: return 60
    case .pt72: return 72
    case .pt90: return 90
    case .pt120: return 120
    }
  }
}

#Preview {
  BezierEmoji(name: "+1", size: .pt24, badge: .chat)
}
