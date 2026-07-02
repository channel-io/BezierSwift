import SwiftUI
import UIKit
import BezierSwift

struct BadgeCatalog: View {
  @State private var size: BezierBadgeSize = .small
  @State private var variant: BezierBadgeVariant = .default
  @State private var label: String = "Label"
  @State private var hasLeadingIcon: Bool = false
  @State private var rowWidth: CGFloat = 200

  var body: some View {
    CatalogScreen(title: "Badge") {
      self.controls
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
      Text("Variants (size: small)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      CatalogSection(.swiftUI) { self.swiftUIVariantGrid }
      CatalogSection(.uiKit) { self.uiKitVariantGrid }
      self.compressionSection
    }
  }

  private var compressionSection: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Compression Resistance (MOB-6018)")
        .font(.system(size: 13, weight: .semibold))
        .foregroundStyle(.secondary)
        .textCase(.uppercase)
      Text("메시지 셀처럼 [이름 · 배지 여러 개 · 타임스탬프]로 구성한 가로 스택. 폭을 줄이면 이름이 먼저 truncate되고 배지들은 자연폭을 유지해야 정상. UIKit·SwiftUI 모두 확인.")
        .font(.caption)
        .foregroundStyle(.secondary)
      HStack(spacing: 8) {
        Text("Row width").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Slider(value: self.$rowWidth, in: 150...340)
        Text("\(Int(self.rowWidth))pt").font(.caption.monospacedDigit()).frame(width: 44, alignment: .trailing)
      }
      CatalogSection(.uiKit) { self.uiKitCompressionDemo }
      CatalogSection(.swiftUI) { self.swiftUICompressionDemo }
    }
  }

  private var uiKitCompressionDemo: some View {
    UIKitWrap(
      { BadgeCompressionRowView() },
      update: { $0.setWidth(self.rowWidth) }
    )
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.vertical, 8)
  }

  private var swiftUICompressionDemo: some View {
    HStack(spacing: 4) {
      Text("김채널 프로덕트 디자이너")
        .font(.system(size: 13, weight: .medium))
        .lineLimit(1)
        .truncationMode(.tail)
        .layoutPriority(-1)
      SUBezierBadge(size: .xsmall, variant: .blue, label: "bot")
      SUBezierBadge(size: .xsmall, variant: .green, label: "lead")
      SUBezierBadge(size: .xsmall, variant: .red, label: "차단")
      Text("오후 5:29")
        .font(.system(size: 11))
        .foregroundStyle(.secondary)
        .lineLimit(1)
        .fixedSize()
    }
    .frame(width: self.rowWidth, alignment: .leading)
    .clipped()
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.vertical, 8)
  }

  private var controls: some View {
    VStack(alignment: .leading, spacing: 10) {
      LabeledSegmented(label: "Size", selection: self.$size, options: BezierBadgeSize.allCases)
      HStack(spacing: 8) {
        Text("Variant").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        Picker("Variant", selection: self.$variant) {
          ForEach(BezierBadgeVariant.allCases, id: \.self) { v in
            Text(v.rawValue).tag(v)
          }
        }
        .pickerStyle(.menu)
      }
      HStack(spacing: 8) {
        Text("Label").font(.caption).foregroundStyle(.secondary).frame(width: 72, alignment: .leading)
        TextField("Label", text: self.$label).textFieldStyle(.roundedBorder)
      }
      Toggle("Leading Icon", isOn: self.$hasLeadingIcon).font(.callout)
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierBadge(
        size: self.size,
        variant: self.variant,
        label: self.label.isEmpty ? nil : self.label,
        leadingIcon: self.hasLeadingIcon ? BezierIcon.star.image : nil
      )
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap(
        { BezierBadge(size: self.size, variant: self.variant) },
        update: { badge in
          badge.size = self.size
          badge.variant = self.variant
          badge.label = self.label.isEmpty ? nil : self.label
          badge.leadingIcon = self.hasLeadingIcon ? BezierIcon.star.uiImage : nil
        }
      )
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 8)
  }

  private var swiftUIVariantGrid: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
      ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
        SUBezierBadge(size: .small, variant: variant, label: variant.rawValue)
      }
    }
  }

  private var uiKitVariantGrid: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: 96), spacing: 8)], spacing: 8) {
      ForEach(BezierBadgeVariant.allCases, id: \.self) { variant in
        UIKitWrap {
          let badge = BezierBadge(size: .small, variant: variant)
          badge.label = variant.rawValue
          return badge
        }
        .fixedSize()
      }
    }
  }
}

// MARK: - Compression Demo Row (MOB-6018)

/// ChatMessagePersonInfoView 를 모사한 한 행: [이름 라벨(.defaultLow) · 배지 3개(.required) · 타임스탬프] 를
/// 폭이 통제된 UIStackView(.fill) 에 배치. 폭이 좁아져도 배지들은 collapse 되지 않고,
/// 이름 라벨이 먼저 truncate 되어야 한다.
private final class BadgeCompressionRowView: UIView {
  private let nameLabel = UILabel()
  private let timeLabel = UILabel()
  private var widthConstraint: NSLayoutConstraint?

  override init(frame: CGRect) {
    super.init(frame: frame)

    self.nameLabel.text = "김채널 프로덕트 디자이너"
    self.nameLabel.font = .systemFont(ofSize: 13, weight: .medium)
    self.nameLabel.lineBreakMode = .byTruncatingTail
    self.nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

    self.timeLabel.text = "오후 5:29"
    self.timeLabel.font = .systemFont(ofSize: 11)
    self.timeLabel.textColor = .secondaryLabel
    self.timeLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

    let stack = UIStackView(arrangedSubviews: [
      self.nameLabel,
      Self.makeBadge("bot", .blue),
      Self.makeBadge("lead", .green),
      Self.makeBadge("차단", .red),
      self.timeLabel,
    ])
    stack.axis = .horizontal
    stack.spacing = 4
    stack.distribution = .fill
    stack.alignment = .center
    stack.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(stack)

    let widthConstraint = self.widthAnchor.constraint(equalToConstant: 200)
    self.widthConstraint = widthConstraint

    NSLayoutConstraint.activate([
      stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      stack.topAnchor.constraint(equalTo: self.topAnchor),
      stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      widthConstraint,
    ])
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private static func makeBadge(_ text: String, _ variant: BezierBadgeVariant) -> BezierBadge {
    let badge = BezierBadge(size: .xsmall, variant: variant)
    badge.label = text
    badge.setContentCompressionResistancePriority(.required, for: .horizontal)
    return badge
  }

  func setWidth(_ width: CGFloat) {
    self.widthConstraint?.constant = width
    self.setNeedsLayout()
    self.layoutIfNeeded()
    self.invalidateIntrinsicContentSize()
  }
}
