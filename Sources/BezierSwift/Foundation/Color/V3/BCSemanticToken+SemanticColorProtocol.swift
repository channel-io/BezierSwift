//
//  BCSemanticToken+SemanticColorProtocol.swift
//  BezierSwift
//
//  Created by 구본욱 on 7/30/26.
//

import Foundation

extension BCSemanticToken: SemanticColorProtocol {
  public var light: ColorComponentsWithAlpha { self.paletteSet.light }
  public var dark: ColorComponentsWithAlpha { self.paletteSet.dark }
}
