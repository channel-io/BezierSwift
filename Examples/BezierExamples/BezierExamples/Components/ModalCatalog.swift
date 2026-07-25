import SwiftUI
import UIKit
import BezierSwift

struct ModalCatalog: View {
  @State private var isModalPresented = false

  var body: some View {
    CatalogScreen(title: "Modal") {
      CatalogSection(.swiftUI) { self.swiftUIPreview }
      CatalogSection(.uiKit) { self.uiKitPreview }
    }
  }

  private var swiftUIPreview: some View {
    VStack(spacing: 24) {
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

      SUBezierButton(
        size: .medium,
        variant: .filled,
        semantic: .primary,
        title: "Present"
      ) {
        self.isModalPresented = true
      }
      .bezierModal(isPresented: self.$isModalPresented) {
        VStack(spacing: 16) {
          Text("Presented Modal")
            .font(.system(size: 16, weight: .semibold))
          Text("배경 dim 위에 별도 화면으로 표시됩니다.")
            .font(.system(size: 14))
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
          SUBezierButton(
            size: .medium,
            variant: .filled,
            semantic: .secondary,
            title: "Close"
          ) {
            self.isModalPresented = false
          }
        }
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 24)
  }

  private var uiKitPreview: some View {
    VStack(spacing: 24) {
      UIKitWrap {
        let modal = BezierModal()

        let stackView = Self.makeSampleContentStackView()
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

      UIKitWrap {
        let button = BezierButton(size: .medium, variant: .filled, semantic: .primary)
        button.title = "Present (UIKit)"
        button.addAction(
          UIAction { [weak button] _ in
            guard let presenter = button?.topPresentingViewController else { return }
            let contentView = Self.makeSampleContentStackView()
            let modalController = BezierModalViewController(contentView: contentView)

            let closeButton = BezierButton(size: .medium, variant: .filled, semantic: .secondary)
            closeButton.title = "Close"
            closeButton.addAction(
              UIAction { [weak modalController] _ in
                modalController?.dismiss(animated: true)
              },
              for: .touchUpInside
            )
            contentView.setCustomSpacing(16, after: contentView.arrangedSubviews[1])
            contentView.addArrangedSubview(closeButton)

            presenter.present(modalController, animated: true)
          },
          for: .touchUpInside
        )
        return button
      }
      .fixedSize()
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical, 24)
  }

  private static func makeSampleContentStackView() -> UIStackView {
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
    return stackView
  }
}
