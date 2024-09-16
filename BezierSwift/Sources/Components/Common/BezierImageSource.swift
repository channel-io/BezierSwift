//
//  BezierImageSource.swift
//
//
//  Created by Tom on 9/16/24.
//

import SwiftUI

import SDWebImageSwiftUI

public enum BezierImageSource: View {
  case image(Image)
  case url(URL?, fallback: Image?)
  
  public var body: some View {
    switch self {
    case .image(let image):
      image
        .resizable()
    case .url(let url, let fallback):
      WebImage(url: url) { result in
        switch result {
        case .empty:
          BezierColor.bgWhiteAlphaTransparent.color
        case .success(let image):
          image
            .resizable()
        case .failure:
          if let fallback {
            fallback
              .resizable()
          } else {
            EmptyView()
          }
        }
      }
    }
  }
}

extension BezierImageSource {
  public static func avatar(url: URL?, fallback: Image? = BezierImage.fallback.image) -> Self {
    return .url(url, fallback: fallback)
  }
}
