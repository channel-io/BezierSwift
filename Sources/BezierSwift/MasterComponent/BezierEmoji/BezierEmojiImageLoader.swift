//
//  BezierEmojiImageLoader.swift
//  BezierSwift
//

import UIKit

final class BezierEmojiImageLoader {
  static let shared = BezierEmojiImageLoader()

  private let cache = NSCache<NSURL, UIImage>()

  private init() {}

  func cachedImage(for url: URL) -> UIImage? {
    self.cache.object(forKey: url as NSURL)
  }

  func image(for url: URL) async -> UIImage? {
    if let cached = self.cachedImage(for: url) { return cached }

    guard
      let (data, response) = try? await URLSession.shared.data(from: url),
      let httpResponse = response as? HTTPURLResponse,
      (200..<300).contains(httpResponse.statusCode),
      let image = UIImage(data: data)
    else { return nil }

    self.cache.setObject(image, forKey: url as NSURL)
    return image
  }
}
