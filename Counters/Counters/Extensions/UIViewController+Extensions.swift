//
//  UIViewController+Extensions.swift
//  Counters
//
//

import UIKit

struct CountersAlertViewModel {
    var title: String
    var message: String
    var primaryButtonTitle: String
    var secondaryButtonTitle: String?
    var primaryButtonAction: (() -> Void)?
}

extension UIViewController {
    func presentErrorAlertWith(viewModel: CountersAlertViewModel) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )

        if let buttonTitle = viewModel.secondaryButtonTitle {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        }

        alert.addAction(UIAlertAction(title: viewModel.primaryButtonTitle, style: .cancel, handler: { action in
            viewModel.primaryButtonAction?()
        }))

        present(alert, animated: true)
    }
}
