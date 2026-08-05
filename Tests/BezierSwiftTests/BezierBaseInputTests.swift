import Testing
@testable import BezierSwift

// MARK: - State 해석 우선순위

// BezierBaseInputState는 TextArea·TextInput·Search·Select·Form이 공유하는 internal 레이어다 —
// 우선순위 한 칸이 어긋나면 전 컴포넌트의 배경·보더·텍스트 색이 함께 회귀한다.
// 아래 4개 테스트가 4 boolean 16조합을 전수 커버한다.
@Suite("BezierBaseInputState 해석 우선순위")
struct BezierBaseInputStateTests {
  @Test("disabled가 다른 모든 축을 이긴다")
  func disabledWinsAll() {
    for isReadOnly in [true, false] {
      for hasError in [true, false] {
        for isFocused in [true, false] {
          let state = BezierBaseInputState.resolve(
            isEnabled: false,
            isReadOnly: isReadOnly,
            hasError: hasError,
            isFocused: isFocused
          )
          #expect(state == .disabled)
        }
      }
    }
  }

  @Test("readOnly가 error·focused를 이긴다")
  func readOnlyWinsOverErrorAndFocus() {
    for hasError in [true, false] {
      for isFocused in [true, false] {
        let state = BezierBaseInputState.resolve(
          isEnabled: true,
          isReadOnly: true,
          hasError: hasError,
          isFocused: isFocused
        )
        #expect(state == .readOnly)
      }
    }
  }

  @Test("error가 focused를 이긴다")
  func errorWinsOverFocus() {
    for isFocused in [true, false] {
      let state = BezierBaseInputState.resolve(
        isEnabled: true,
        isReadOnly: false,
        hasError: true,
        isFocused: isFocused
      )
      #expect(state == .error)
    }
  }

  @Test("나머지는 focused, 아무것도 없으면 default다")
  func focusedThenDefault() {
    #expect(
      BezierBaseInputState.resolve(
        isEnabled: true, isReadOnly: false, hasError: false, isFocused: true
      ) == .focused
    )
    #expect(
      BezierBaseInputState.resolve(
        isEnabled: true, isReadOnly: false, hasError: false, isFocused: false
      ) == .default
    )
  }
}
