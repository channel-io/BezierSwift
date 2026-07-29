//
//  BezierEmojiSpec.swift
//  BezierSwift
//

import Foundation

// MARK: - Emoji Size

/// 이모지 컨테이너 크기. Figma `Emoji` 컴포넌트의 `size` 프로퍼티에 대응 (Figma 값 `"24"` = `.size24`, bare 숫자에 `size` prefix가 붙은 형태).
/// `.size60` 이상은 160px 해상도 에셋을, 미만은 80px 해상도 에셋을 내려받는다.
public enum BezierEmojiSize: String, CaseIterable {
  case size16
  case size20
  case size24
  case size30
  case size36
  case size42
  case size48
  case size60
  case size72
  case size90
  case size120

  public var length: CGFloat {
    switch self {
    case .size16:  return 16
    case .size20:  return 20
    case .size24:  return 24
    case .size30:  return 30
    case .size36:  return 36
    case .size42:  return 42
    case .size48:  return 48
    case .size60:  return 60
    case .size72:  return 72
    case .size90:  return 90
    case .size120: return 120
    }
  }

  var assetResolution: Int {
    self.length >= 60 ? 160 : 80
  }
}

// MARK: - Emoji CDN

/// 채널톡 이모지 에셋 CDN 설정. 라이브러리는 소비자 앱의 배포 환경을 알 수 없으므로,
/// 개발 환경 CDN을 사용하려면 앱 시작 시 `BezierEmojiCDN.environment`를 `.development`로 지정한다.
public enum BezierEmojiCDN {
  /// 이모지 에셋 CDN 환경.
  public enum Environment {
    /// `https://cf.channel.io`에서 에셋을 내려받는다.
    case production
    /// `https://cf.exp.channel.io`에서 에셋을 내려받는다.
    case development

    var baseURLString: String {
      switch self {
      case .production:  return "https://cf.channel.io"
      case .development: return "https://cf.exp.channel.io"
      }
    }
  }

  /// 현재 CDN 환경. 기본값은 `.production`이다.
  public static var environment: Environment = .production

  /// `.urlPathAllowed`는 `/`를 통과시켜 name 하나가 여러 경로 세그먼트로 쪼개진다.
  /// name은 단일 세그먼트여야 하므로 `/`를 인코딩 대상에 포함시킨다.
  private static let pathSegmentAllowed: CharacterSet = {
    var allowed = CharacterSet.urlPathAllowed
    allowed.remove("/")
    return allowed
  }()

  static func imageURL(name: String, size: BezierEmojiSize) -> URL? {
    guard
      !name.isEmpty,
      let encodedName = name.addingPercentEncoding(withAllowedCharacters: self.pathSegmentAllowed)
    else { return nil }

    return URL(
      string: "\(self.environment.baseURLString)/asset/emoji/images/\(size.assetResolution)/\(encodedName).png"
    )
  }
}
