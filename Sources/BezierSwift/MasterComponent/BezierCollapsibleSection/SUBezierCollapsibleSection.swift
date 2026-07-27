//
//  SUBezierCollapsibleSection.swift
//  BezierSwift
//

import SwiftUI

/// 헤더 탭으로 콘텐츠를 접고 펼치는 인터랙티브 섹션 컨테이너 (SwiftUI). 데이터 컬렉션을 받아 헤더(라벨·chevron) + 행 목록을 그리며 행에는 `SUBezierSectionItem`을 넣는다. 펼침 상태는 `isOpen` 바인딩으로 소비자가 소유한다 (Figma `CollapsibleSection`의 `open` 프로퍼티 대응). 정적 그룹핑만 필요하면 `SUBezierSection`을 사용한다. UIKit에서는 `BezierCollapsibleSection`을 사용한다.
public struct SUBezierCollapsibleSection<
  Data: RandomAccessCollection,
  ID: Hashable,
  Row: View,
  LabelLeading: View,
  LabelTrailing: View
>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme
  @Environment(\.accessibilityReduceMotion) private var reduceMotion

  @Binding private var isOpen: Bool
  private let data: Data
  private let id: KeyPath<Data.Element, ID>
  private let labelText: String
  private let labelColor: BezierSectionLabelColor
  private let labelLeading: LabelLeading
  private let labelTrailing: LabelTrailing
  private let rowContent: (Data.Element) -> Row

  /// 데이터 컬렉션·식별 keyPath·펼침 상태 바인딩·헤더로 섹션을 만든다. `rowContent`로 각 원소의 행 뷰를, `labelLeading`/`labelTrailing`으로 헤더 좌·우 슬롯을 구성한다.
  public init(
    _ data: Data,
    id: KeyPath<Data.Element, ID>,
    isOpen: Binding<Bool>,
    labelText: String,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder labelLeading: () -> LabelLeading,
    @ViewBuilder labelTrailing: () -> LabelTrailing,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.data = data
    self.id = id
    self._isOpen = isOpen
    self.labelText = labelText
    self.labelColor = labelColor
    self.labelLeading = labelLeading()
    self.labelTrailing = labelTrailing()
    self.rowContent = rowContent
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: BezierSectionConstant.labelToContentSpacing) {
      self.header

      if self.isOpen {
        self.rows
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .clipped()
  }

  // MARK: - Header

  private var header: some View {
    Button(action: self.toggle) {
      self.headerContent
    }
    .buttonStyle(SUBezierCollapsibleSectionLabelStyle())
  }

  private var headerContent: some View {
    HStack(spacing: 0) {
      HStack(spacing: BezierSectionConstant.labelLeadingSpacing) {
        self.labelLeadingView

        Text(self.labelText)
          .applyBezierFontStyle(
            BezierSectionConstant.labelTypography,
            semanticColorToken: self.labelColor.textColor
          )
          .lineLimit(1)
          .truncationMode(.tail)

        self.chevronView
      }

      Spacer(minLength: BezierSectionConstant.labelTrailingSpacing)

      self.labelTrailingView
    }
  }

  private var chevronView: some View {
    BezierCollapsibleSectionConstant.chevronIcon(isOpen: self.isOpen).image
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .frame(
        width: BezierCollapsibleSectionConstant.chevronLength,
        height: BezierCollapsibleSectionConstant.chevronLength
      )
      .foregroundColor(self.palette(self.labelColor.chevronColor))
  }

  @ViewBuilder
  private var labelLeadingView: some View {
    if LabelLeading.self != EmptyView.self {
      self.labelLeading
        .frame(
          width: BezierSectionConstant.labelLeadingContentLength,
          height: BezierSectionConstant.labelLeadingContentLength
        )
    }
  }

  @ViewBuilder
  private var labelTrailingView: some View {
    if LabelTrailing.self != EmptyView.self {
      self.labelTrailing
        .frame(height: BezierSectionConstant.labelTrailingContentHeight)
        .layoutPriority(1)
    }
  }

  private func toggle() {
    if self.reduceMotion {
      self.isOpen.toggle()
    } else {
      withAnimation(
        .easeInOut(duration: BezierCollapsibleSectionConstant.openAnimationDuration)
      ) {
        self.isOpen.toggle()
      }
    }
  }

  // MARK: - Rows

  private var rows: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(self.data, id: self.id) { element in
        self.rowContent(element)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

// MARK: - Label Style (pressed 배경 + press scale)

private struct SUBezierCollapsibleSectionLabelStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .modifier(SUBezierCollapsibleSectionLabelContainer(isPressed: configuration.isPressed))
  }
}

private struct SUBezierCollapsibleSectionLabelContainer: ViewModifier, Themeable {
  @Environment(\.colorScheme) var colorScheme

  let isPressed: Bool

  func body(content: Content) -> some View {
    content
      .bezierPressScale(isPressed: self.isPressed)
      .padding(.horizontal, BezierSectionConstant.labelHorizontalPadding)
      .frame(minHeight: BezierSectionConstant.labelHeight)
      .frame(maxWidth: .infinity)
      .background(
        self.isPressed
          ? self.palette(BezierCollapsibleSectionConstant.labelPressedBackgroundColor)
          : Color.clear
      )
      .clipShape(RoundedRectangle(cornerRadius: BezierSectionConstant.labelCornerRadius))
      .contentShape(Rectangle())
  }
}

// MARK: - Convenience init

extension SUBezierCollapsibleSection where LabelLeading == EmptyView {
  /// 헤더 좌측 슬롯 없이 만드는 편의 이니셜라이저.
  public init(
    _ data: Data,
    id: KeyPath<Data.Element, ID>,
    isOpen: Binding<Bool>,
    labelText: String,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder labelTrailing: () -> LabelTrailing,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: id,
      isOpen: isOpen,
      labelText: labelText,
      labelColor: labelColor,
      labelLeading: { EmptyView() },
      labelTrailing: labelTrailing,
      rowContent: rowContent
    )
  }
}

extension SUBezierCollapsibleSection where LabelLeading == EmptyView, LabelTrailing == EmptyView {
  /// 헤더 좌·우 슬롯 없이 만드는 편의 이니셜라이저.
  public init(
    _ data: Data,
    id: KeyPath<Data.Element, ID>,
    isOpen: Binding<Bool>,
    labelText: String,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: id,
      isOpen: isOpen,
      labelText: labelText,
      labelColor: labelColor,
      labelLeading: { EmptyView() },
      labelTrailing: { EmptyView() },
      rowContent: rowContent
    )
  }
}

extension SUBezierCollapsibleSection where Data.Element: Identifiable, ID == Data.Element.ID {
  /// 원소가 `Identifiable`일 때 `id` keyPath를 생략하는 편의 이니셜라이저.
  public init(
    _ data: Data,
    isOpen: Binding<Bool>,
    labelText: String,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder labelLeading: () -> LabelLeading,
    @ViewBuilder labelTrailing: () -> LabelTrailing,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: \.id,
      isOpen: isOpen,
      labelText: labelText,
      labelColor: labelColor,
      labelLeading: labelLeading,
      labelTrailing: labelTrailing,
      rowContent: rowContent
    )
  }
}

extension SUBezierCollapsibleSection
where Data.Element: Identifiable, ID == Data.Element.ID, LabelLeading == EmptyView, LabelTrailing == EmptyView {
  /// 원소가 `Identifiable`이고 헤더 슬롯이 없을 때 쓰는 편의 이니셜라이저.
  public init(
    _ data: Data,
    isOpen: Binding<Bool>,
    labelText: String,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: \.id,
      isOpen: isOpen,
      labelText: labelText,
      labelColor: labelColor,
      labelLeading: { EmptyView() },
      labelTrailing: { EmptyView() },
      rowContent: rowContent
    )
  }
}

// MARK: - Preview

struct SUBezierCollapsibleSection_Previews: PreviewProvider {
  private struct Host: View {
    @State private var isFirstOpen = true
    @State private var isSecondOpen = false

    var body: some View {
      ScrollView {
        LazyVStack(spacing: 20) {
          SUBezierCollapsibleSection(
            ["태그 관리", "고객 노트", "첨부파일"],
            id: \.self,
            isOpen: self.$isFirstOpen,
            labelText: "고객 정보"
          ) { title in
            SUBezierBaseItem(
              title: title,
              onTap: {},
              leading: { Circle().fill(Color.gray) },
              trailing: { EmptyView() }
            )
          }

          SUBezierCollapsibleSection(
            ["멤버 초대", "멤버 차단"],
            id: \.self,
            isOpen: self.$isSecondOpen,
            labelText: "멤버",
            labelColor: .neutralLight,
            labelTrailing: {
              BezierIcon.plus.image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundColor(.secondary)
            }
          ) { title in
            SUBezierBaseItem(
              title: title,
              onTap: {},
              leading: { Circle().fill(Color.gray) },
              trailing: { EmptyView() }
            )
          }
        }
        .padding()
      }
    }
  }

  static var previews: some View {
    Host()
  }
}
