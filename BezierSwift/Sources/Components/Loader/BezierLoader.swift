//
//  BezierLoader.swift
//
//
//  Created by Tom on 6/29/24.
//

import SwiftUI

/// NOTE: SwiftUI 로 구현한 BezierLoader의 경우 Animation 사이클이 부모뷰 사이클과 같이 동작하기 때문에 범용적인 컴포넌트로 사용이 어려운 문제가 있었습니다.
/// UIKit으로 구현한 Loader를 UIViewRepresentable 로 감싸서 사용하며, 정확한 사이즈 사용을 위해 SwiftUI View로 한번 더 감싸서 사용합니다. by Tom 2024.08.01
// - MARK: BezierLoader
public struct BezierLoader: View {
  public typealias Configuration = BezierLoaderConfiguration
  
  private let configuration: Configuration
  
  // MARK: Initializer
  /// - Parameters:
  ///   - configuration: 버튼의 스타일과 모양을 정의하는 `BezierLoaderConfiguration` 객체입니다.
  public init(configuration: Configuration) {
    self.configuration = configuration
  }
  
  // MARK: Body
  public var body: some View {
    Representable(configuration: self.configuration)
      .compositingGroup()
      .frame(length: self.configuration.loaderLength)
  }
}

// - MARK: Representable
extension BezierLoader {
  struct Representable: UIViewRepresentable {
    private let configuration: Configuration
    
    init(configuration: Configuration) {
      self.configuration = configuration
    }
    
    func makeUIView(context: Context) -> UIBezierLoader {
      let loader = UIBezierLoader(configuration: self.configuration)
      return loader
    }
    
    func updateUIView(_ loader: UIBezierLoader, context: Context) { }
  }
}

#Preview {
  BezierLoader(configuration: .init(size: .medium, variant: .primary))
}
