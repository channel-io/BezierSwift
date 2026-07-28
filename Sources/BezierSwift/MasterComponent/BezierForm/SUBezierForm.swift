//
//  SUBezierForm.swift
//  BezierSwift
//

import SwiftUI

/// 한 번에 함께 검증·제출되어야 하는 FormField들의 컨테이너 (SwiftUI). `SUBezierFormField`를 세로로 쌓으며 필드 간 간격은 필드 자체의 하단 패딩이 담당한다. 즉시 저장이 필요한 화면에는 Form이 아닌 `SUBezierSection` 계열을 사용한다. submit 액션(예: 내비게이션 바 저장 버튼)과 카드 chrome 조합은 화면(소비자) 책임이다. UIKit에서는 `BezierForm`을 사용한다.
public struct SUBezierForm<Content: View>: View {
  private let content: Content

  /// FormField들을 담는 콘텐츠 빌더로 폼을 만든다.
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: BezierFormConstant.fieldSpacing) {
      self.content
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct SUBezierForm_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      SUBezierForm {
        SUBezierFormField(labelText: "이름", isRequired: true) {
          SUBezierTextInput(text: .constant(""), placeholder: "이름 입력")
        }

        SUBezierFormField(labelText: "이메일", description: "회사 이메일을 입력해요") {
          SUBezierTextInput(text: .constant(""), placeholder: "예: hong@company.com")
        }
      }
      .padding(16)
    }
  }
}
