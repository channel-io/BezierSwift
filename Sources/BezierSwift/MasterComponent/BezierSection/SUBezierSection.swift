//
//  SUBezierSection.swift
//  BezierSwift
//

import SwiftUI

public struct SUBezierSection<Data: RandomAccessCollection, ID: Hashable, Row: View, LabelTrailing: View>: View, Themeable {
  @Environment(\.colorScheme) public var colorScheme

  private let data: Data
  private let id: KeyPath<Data.Element, ID>
  private let variant: BezierSectionVariant
  private let labelText: String?
  private let labelColor: BezierSectionLabelColor
  private let labelTrailing: LabelTrailing
  private let rowContent: (Data.Element) -> Row

  public init(
    _ data: Data,
    id: KeyPath<Data.Element, ID>,
    variant: BezierSectionVariant = .solid,
    labelText: String? = nil,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder labelTrailing: () -> LabelTrailing,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.data = data
    self.id = id
    self.variant = variant
    self.labelText = labelText
    self.labelColor = labelColor
    self.labelTrailing = labelTrailing()
    self.rowContent = rowContent
  }

  private var appearance: BezierSectionVariant.Appearance {
    self.variant.appearance
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: BezierSectionConstant.labelToContentSpacing) {
      if let labelText = self.labelText {
        SUBezierSectionLabel(labelText, color: self.labelColor) {
          self.labelTrailing
        }
      }
      self.content
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }

  // MARK: - Content

  private struct Entry {
    let id: ID
    let element: Data.Element
    let showsDivider: Bool
  }

  private var entries: [Entry] {
    let count = self.data.count
    return self.data.enumerated().map { offset, element in
      Entry(
        id: element[keyPath: self.id],
        element: element,
        showsDivider: offset < count - 1
      )
    }
  }

  @ViewBuilder
  private var content: some View {
    let rows = VStack(alignment: .leading, spacing: 0) {
      ForEach(self.entries, id: \.id) { entry in
        self.rowContent(entry.element)

        if entry.showsDivider, let divider = self.appearance.divider {
          self.dividerView(divider)
        }
      }
    }
    .padding(
      EdgeInsets(
        top: self.appearance.contentInsets.top,
        leading: self.appearance.contentInsets.leading,
        bottom: self.appearance.contentInsets.bottom,
        trailing: self.appearance.contentInsets.trailing
      )
    )
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(self.backgroundView)
    .overlay(self.borderView)

    if self.appearance.hasChrome {
      rows.clipShape(RoundedRectangle(cornerRadius: self.appearance.cornerRadius))
    } else {
      rows
    }
  }

  private func dividerView(_ divider: BezierSectionVariant.Appearance.Divider) -> some View {
    Rectangle()
      .fill(self.palette(divider.color))
      .frame(height: divider.thickness)
      .padding(.leading, divider.leadingInset)
      .padding(.trailing, divider.trailingInset)
  }

  @ViewBuilder
  private var backgroundView: some View {
    if let backgroundColor = self.appearance.backgroundColor {
      RoundedRectangle(cornerRadius: self.appearance.cornerRadius)
        .fill(self.palette(backgroundColor))
    }
  }

  @ViewBuilder
  private var borderView: some View {
    if let border = self.appearance.border {
      RoundedRectangle(cornerRadius: self.appearance.cornerRadius)
        .strokeBorder(self.palette(border.color), lineWidth: border.width)
    }
  }
}

// MARK: - Convenience init

extension SUBezierSection where LabelTrailing == EmptyView {
  public init(
    _ data: Data,
    id: KeyPath<Data.Element, ID>,
    variant: BezierSectionVariant = .solid,
    labelText: String? = nil,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: id,
      variant: variant,
      labelText: labelText,
      labelColor: labelColor,
      labelTrailing: { EmptyView() },
      rowContent: rowContent
    )
  }
}

extension SUBezierSection where Data.Element: Identifiable, ID == Data.Element.ID {
  public init(
    _ data: Data,
    variant: BezierSectionVariant = .solid,
    labelText: String? = nil,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder labelTrailing: () -> LabelTrailing,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: \.id,
      variant: variant,
      labelText: labelText,
      labelColor: labelColor,
      labelTrailing: labelTrailing,
      rowContent: rowContent
    )
  }
}

extension SUBezierSection where Data.Element: Identifiable, ID == Data.Element.ID, LabelTrailing == EmptyView {
  public init(
    _ data: Data,
    variant: BezierSectionVariant = .solid,
    labelText: String? = nil,
    labelColor: BezierSectionLabelColor = .neutralDark,
    @ViewBuilder rowContent: @escaping (Data.Element) -> Row
  ) {
    self.init(
      data,
      id: \.id,
      variant: variant,
      labelText: labelText,
      labelColor: labelColor,
      labelTrailing: { EmptyView() },
      rowContent: rowContent
    )
  }
}

struct SUBezierSection_Previews: PreviewProvider {
  static var previews: some View {
    ScrollView {
      LazyVStack(spacing: 20) {
        SUBezierSection(
          ["태그 관리", "고객 노트", "첨부파일"],
          id: \.self,
          variant: .card,
          labelText: "설정"
        ) { title in
          SUBezierBaseItem(
            title: title,
            onTap: {},
            leading: { Circle().fill(Color.gray) },
            trailing: {
              BezierIcon.chevronSmallRight.image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.secondary)
            }
          )
        }

        SUBezierSection(
          ["멤버 초대", "멤버 차단"],
          id: \.self,
          labelText: "멤버",
          labelColor: .neutralLight
        ) { title in
          SUBezierBaseItem(
            title: title,
            onTap: {},
            leading: { Circle().fill(Color.gray) },
            trailing: { EmptyView() }
          )
        }
      }
    }
  }
}
