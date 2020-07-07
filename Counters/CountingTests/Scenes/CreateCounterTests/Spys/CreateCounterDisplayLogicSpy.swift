//
//  CreateCounterDisplayLogicSpy.swift
//  Counters
//
//

@testable import Counters

class CreateCounterDisplayLogicSpy: CreateCounterDisplayLogic {

    var displayCountersListCalled = false
    var displayErrorAlertCalled = false
    var displayCountersListViewModelSuccess: CreateCounter.NewCounter.ViewModel.Success?
    var displayCountersListViewModelFailure: CreateCounter.NewCounter.ViewModel.Failure?

    func displayCountersList(viewModel: CreateCounter.NewCounter.ViewModel.Success) {
        displayCountersListCalled = true
        displayCountersListViewModelSuccess = viewModel
    }

    func displayErrorAlert(viewModel: CreateCounter.NewCounter.ViewModel.Failure) {
        displayErrorAlertCalled = true
        displayCountersListViewModelFailure = viewModel
    }

}
