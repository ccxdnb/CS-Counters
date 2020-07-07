//
//  CreateCounterPresenter.swift
//  Counters
//
//

import UIKit

protocol CreateCounterPresentationLogic {
    func presentCounterList(response: CreateCounter.NewCounter.Response.Success)
    func presentConnectionError()
}

class CreateCounterPresenter: CreateCounterPresentationLogic {

    weak  var viewController: CreateCounterDisplayLogic?

    // MARK: Methods

    func presentCounterList(response: CreateCounter.NewCounter.Response.Success) {
        viewController?.displayCountersList(viewModel: .init(counters: response.counters))
    }

    func presentConnectionError() {
        viewController?.displayErrorAlert(
            viewModel: .init(
                title: "NO_INTERNET_ALERT_TITLE".localized,
                message: "NO_INTERNET_ALERT_MESSAGE".localized,
                buttonTitle: "NO_INTERNET_ALERT_BUTTON".localized
            )
        )
    }

}
