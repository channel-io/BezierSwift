import Testing
import CoreGraphics
@testable import BezierSwift

// MARK: - Size

@Suite("BezierEmojiSize")
struct BezierEmojiSizeTests {
  @Test("length는 Figma size 값과 일치한다", arguments: [
    (BezierEmojiSize.size16, CGFloat(16)),
    (.size20, 20),
    (.size24, 24),
    (.size30, 30),
    (.size36, 36),
    (.size42, 42),
    (.size48, 48),
    (.size60, 60),
    (.size72, 72),
    (.size90, 90),
    (.size120, 120),
  ])
  func length(size: BezierEmojiSize, expected: CGFloat) {
    #expect(size.length == expected)
  }

  @Test("size 60 미만은 80px 에셋을 사용한다", arguments: [
    BezierEmojiSize.size16, .size20, .size24, .size30, .size36, .size42, .size48,
  ])
  func lowResolution(size: BezierEmojiSize) {
    #expect(size.assetResolution == 80)
  }

  @Test("size 60 이상은 160px 에셋을 사용한다", arguments: [
    BezierEmojiSize.size60, .size72, .size90, .size120,
  ])
  func highResolution(size: BezierEmojiSize) {
    #expect(size.assetResolution == 160)
  }
}

// MARK: - CDN URL

// BezierEmojiCDN.environment는 전역 상태라 테스트 간 간섭을 막기 위해 직렬 실행한다.
@Suite("BezierEmojiCDN", .serialized)
struct BezierEmojiCDNTests {
  @Test("production URL 형식")
  func productionURL() {
    BezierEmojiCDN.environment = .production
    let url = BezierEmojiCDN.imageURL(name: "grinning", size: .size24)

    #expect(url?.absoluteString == "https://cf.channel.io/asset/emoji/images/80/grinning.png")
  }

  @Test("development URL 형식")
  func developmentURL() {
    BezierEmojiCDN.environment = .development
    defer { BezierEmojiCDN.environment = .production }
    let url = BezierEmojiCDN.imageURL(name: "grinning", size: .size24)

    #expect(url?.absoluteString == "https://cf.exp.channel.io/asset/emoji/images/80/grinning.png")
  }

  @Test("size 60 이상은 160 경로를 사용한다")
  func highResolutionPath() {
    BezierEmojiCDN.environment = .production
    let url = BezierEmojiCDN.imageURL(name: "grinning", size: .size60)

    #expect(url?.absoluteString == "https://cf.channel.io/asset/emoji/images/160/grinning.png")
  }

  @Test("빈 name은 nil을 반환한다")
  func emptyName() {
    BezierEmojiCDN.environment = .production

    #expect(BezierEmojiCDN.imageURL(name: "", size: .size24) == nil)
  }

  @Test("URL에 부적합한 문자는 percent-encoding된다")
  func percentEncoding() {
    BezierEmojiCDN.environment = .production
    let url = BezierEmojiCDN.imageURL(name: "my emoji", size: .size24)

    #expect(url?.absoluteString == "https://cf.channel.io/asset/emoji/images/80/my%20emoji.png")
  }

  @Test("name의 /는 경로를 쪼개지 않고 인코딩된다")
  func pathSeparatorEncoding() {
    BezierEmojiCDN.environment = .production
    let url = BezierEmojiCDN.imageURL(name: "foo/bar", size: .size24)

    #expect(url?.absoluteString == "https://cf.channel.io/asset/emoji/images/80/foo%2Fbar.png")
  }

  @Test("path에 유효한 문자를 포함한 이름은 그대로 유지된다")
  func pathSafeNameIsPreserved() {
    BezierEmojiCDN.environment = .production
    let url = BezierEmojiCDN.imageURL(name: "+1", size: .size24)

    #expect(url?.absoluteString == "https://cf.channel.io/asset/emoji/images/80/+1.png")
  }
}
