//
//  CountingListPresenter.swift
//  Counting
//
//

import UIKit

protocol CountersListPresentationLogic {
    func presentCounterList(response: CountersList.Counters.Response)
    func presentDeletedCounter(response: CountersList.DeleteCounter.Response)
    func presentEmptyCountingList()
    func presentNoInternetList()
    func presentDeleteError(response: CountersList.DeleteCounter.Response)
    func presentUpdatedCounter(response: CountersList.UpdateCounter.Response)
    func presentUpdateError(response: CountersList.UpdateCounter.Response)

}

class CountersListPresenter: CountersListPresentationLogic {

    weak var viewController: CountersListDisplayLogic?

    // MARK: - CountingListPresentationLogic

    func presentCounterList(response: CountersList.Counters.Response) {
        viewController?.displayCountingList(viewModel: .init(counters: response.counters))
    }

    func presentDeletedCounter(response: CountersList.DeleteCounter.Response) {
        viewController?.displayDeleteCounter(viewModel: .init(counter: response.counter))
    }

    func presentEmptyCountingList() {
        viewController?.displayPlaceHolderView(
            viewModel: .init(
                title: "NO_COUNTERS_PH_TITLE".localized,
                body: NSAttributedString(string: "NO_COUNTERS_PH_BODY".localized),
                buttonTitle: "NO_COUNTERS_PH_BUTTON_TITLE".localized,
                type: .noCounters
            )
        )
    }

    func presentNoInternetList() {
        viewController?.displayPlaceHolderView(
            viewModel: .init(
                title: "NO_INTERNET_PH_TITLE".localized,
                body: NSAttributedString(string: "NO_INTERNET_PH_BODY".localized),
                buttonTitle: "NO_INTERNET_PH_BUTTON_TITLE".localized,
                type: .noInternet
            )
        )
    }

    func presentDeleteError(response: CountersList.DeleteCounter.Response) {
        viewController?.displayDeleteErrorAlert(
            viewModel: .init(
                title: "DELETECOUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title),
                message: "DELETECOUNTER_ERROR_ALERT_MESSAGE".localized,
                primaryButton: "DELETECOUNTER_ERROR_ALERT_BUTTON".localized,
                secondaryButton: nil)
        )
    }

    func presentUpdatedCounter(response: CountersList.UpdateCounter.Response) {
        viewController?.displayUpdateCounter(viewModel: .init(counter: response.counter))
    }

    func presentUpdateError(response: CountersList.UpdateCounter.Response) {

        let errorCount = response.type == .increase ? response.counter.count + 1  : response.counter.count - 1

        viewController?.displayUpdateErrorAlert(
            viewModel: .init(
                counter: response.counter,
                title: "UPDATE_COUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title, errorCount),
                message: "UPDATE_COUNTER_ERROR_ALERT_MESSAGE".localized,
                primaryButton: "UPDATE_COUNTER_ERROR_ALERT_BUTTON_PRIMARY".localized,
                secondaryButton: "UPDATE_COUNTER_ERROR_ALERT_BUTTON_SECONDARY".localized,
                type: response.type)
        )
    }
}
