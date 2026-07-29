//
//  BezierEmojiImageLoader.swift
//  BezierSwift
//

import UIKit

actor BezierEmojiImageLoader {
  static let shared = BezierEmojiImageLoader()

  /// NSCache는 자체 thread-safe라 actor 격리 밖에서도 안전하다.
  /// 캐시 히트 시 동기 조회(첫 프레임 flash 방지)를 유지하려면 nonisolated여야 한다.
  private nonisolated let cache = NSCache<NSURL, UIImage>()

  private var inFlightTasks: [URL: Task<UIImage?, Never>] = [:]

  private init() {}

  nonisolated func cachedImage(for url: URL) -> UIImage? {
    self.cache.object(forKey: url as NSURL)
  }

  func image(for url: URL) async -> UIImage? {
    if let cached = self.cachedImage(for: url) { return cached }

    // 같은 이모지가 목록에 여러 번 렌더될 때 URL별 다운로드가 1회만 나가도록 요청을 공유한다.
    // 호출자 Task가 취소돼도 이 Task는 독립적이라 남은 대기자의 로드가 끊기지 않는다.
    if let inFlight = self.inFlightTasks[url] { return await inFlight.value }

    let task = Task<UIImage?, Never> { [cache] in
      guard
        let (data, response) = try? await URLSession.shared.data(from: url),
        let httpResponse = response as? HTTPURLResponse,
        (200..<300).contains(httpResponse.statusCode),
        let image = UIImage(data: data)
      else { return nil }

      cache.setObject(image, forKey: url as NSURL)
      return image
    }

    self.inFlightTasks[url] = task
    defer { self.inFlightTasks[url] = nil }

    return await task.value
  }
}
