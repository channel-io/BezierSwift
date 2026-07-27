//
//  SUBezierEmoji.swift
//  BezierSwift
//

import SwiftUI

/// 채널톡 이모지 에셋을 지정된 크기로 표시하는 이미지 컴포넌트 (SwiftUI).
/// `name`만으로 CDN URL과 에셋 해상도가 자동 결정된다. UIKit에서는 `BezierEmoji`를 사용한다.
public struct SUBezierEmoji: View {
  private let name: String
  private let size: BezierEmojiSize

  @State private var loadedImage: LoadedImage?

  /// 이모지 이름과 크기를 지정해 이모지를 만든다.
  /// - Parameters:
  ///   - name: 채널톡 이모지 이름 (예: `grinning`, `smiley`). 유니코드 이모지 문자가 아니라 에셋 이름을 전달한다.
  ///           유효하지 않은 이름이면 빈 영역으로 렌더된다.
  ///   - size: 이모지 크기. 기본값은 `.size24`다.
  public init(name: String, size: BezierEmojiSize = .size24) {
    self.name = name
    self.size = size
  }

  public var body: some View {
    Group {
      if let image = self.displayedImage {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        Color.clear
      }
    }
    .frame(width: self.size.length, height: self.size.length)
    .task(id: self.imageURL) {
      guard let url = self.imageURL else {
        self.loadedImage = nil
        return
      }
      guard let image = await BezierEmojiImageLoader.shared.image(for: url) else { return }
      self.loadedImage = LoadedImage(url: url, image: image)
    }
    .accessibilityElement()
    .accessibilityAddTraits(.isImage)
    .accessibilityLabel(self.name)
  }

  // MARK: - Private

  /// 로드 완료 이미지를 URL에 키잉해, name·size 전환 중 이전 URL의 이미지가 표시되는 상태 오염을 막는다.
  private struct LoadedImage {
    let url: URL
    let image: UIImage
  }

  private var imageURL: URL? {
    BezierEmojiCDN.imageURL(name: self.name, size: self.size)
  }

  private var displayedImage: UIImage? {
    guard let url = self.imageURL else { return nil }
    if let loadedImage = self.loadedImage, loadedImage.url == url { return loadedImage.image }
    return BezierEmojiImageLoader.shared.cachedImage(for: url)
  }
}

struct SUBezierEmoji_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        Text("size row")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .bottom, spacing: 12) {
            ForEach(BezierEmojiSize.allCases, id: \.self) { size in
              SUBezierEmoji(name: "smile", size: size)
            }
          }
        }

        Text("names")
          .font(.caption.weight(.semibold))
          .foregroundColor(.secondary)
        HStack(spacing: 12) {
          ForEach(["grinning", "smiley", "thumbsup"], id: \.self) { name in
            SUBezierEmoji(name: name, size: .size48)
          }
        }
      }
      .padding()
    }
  }
}
