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
  case url(URL?, fallback: Image = BezierImage.fallback.image)
  
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
          fallback
            .resizable()
        }
      }
    }
  }
}
