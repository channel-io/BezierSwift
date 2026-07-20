import SwiftUI
import UIKit
import BezierSwift

struct ModalCatalog: View {
  var body: some View {
    CatalogScreen(title: "Modal") {
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var swiftUIPreview: some View {
    HStack {
      Spacer()
      SUBezierModal {
        VStack(spacing: 8) {
          Text("Custom Content")
            .font(.system(size: 16, weight: .semibold))
          Text("Modal은 customContent 슬롯 하나를 가진 순수 컨테이너입니다.")
            .font(.system(size: 14))
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
      }
      Spacer()
    }
    .padding(.vertical, 24)
  }

  private var uiKitPreview: some View {
    HStack {
      Spacer()
      UIKitWrap {
        let modal = BezierModal()

        let titleLabel = UILabel()
        titleLabel.text = "Custom Content"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textAlignment = .center

        let descriptionLabel = UILabel()
        descriptionLabel.text = "Modal은 customContent 슬롯 하나를 가진 순수 컨테이너입니다."
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        modal.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
          stackView.topAnchor.constraint(equalTo: modal.contentView.topAnchor),
          stackView.bottomAnchor.constraint(equalTo: modal.contentView.bottomAnchor),
          stackView.leadingAnchor.constraint(equalTo: modal.contentView.leadingAnchor),
          stackView.trailingAnchor.constraint(equalTo: modal.contentView.trailingAnchor),
        ])
        return modal
      }
      .fixedSize()
      Spacer()
    }
    .padding(.vertical, 24)
  }
}
