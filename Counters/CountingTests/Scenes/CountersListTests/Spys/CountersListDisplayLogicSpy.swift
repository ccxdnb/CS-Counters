//
//  CountersListDisplayLogicSpy.swift
//  Counters
//
//

@testable import Counters

class CountersListDisplayLogicSpy: CountersListDisplayLogic {
    
    var displayCountingListCalled = false
    var displayDeleteCounterCalled = false
    var displayPlaceHolderViewCalled = false
    var displayDeleteErrorAlertCalled = false
    var displayUpdateErrorAlertCalled = false
    var displayUpdateCounterCalled = false

    var displayCountingListViewModel: CountersList.Counters.ViewModel.Success?
    var displayDeleteCounterViewModel: CountersList.DeleteCounter.ViewModel.Success?
    var displayPlaceHolderViewViewModel: CountersList.Placeholder.ViewModel?
    var displayDeleteErrorAlertViewModel: CountersList.DeleteCounter.ViewModel.Failure?
    var displayUpdateErrorAlertViewModel: CountersList.UpdateCounter.ViewModel.Failure?
    var displayUpdateCounterViewModel: CountersList.UpdateCounter.ViewModel.Success?
    
    func displayCountingList(viewModel: CountersList.Counters.ViewModel.Success) {
        displayCountingListCalled = true
        displayCountingListViewModel = viewModel
    }

    func displayDeleteCounter(viewModel: CountersList.DeleteCounter.ViewModel.Success) {
        displayDeleteCounterCalled = true
        displayDeleteCounterViewModel = viewModel
    }

    func displayPlaceHolderView(viewModel: CountersList.Placeholder.ViewModel) {
        displayPlaceHolderViewCalled = true
        displayPlaceHolderViewViewModel = viewModel
    }

    func displayDeleteErrorAlert(viewModel: CountersList.DeleteCounter.ViewModel.Failure) {
        displayDeleteErrorAlertCalled = true
        displayDeleteErrorAlertViewModel = viewModel
    }

    func displayUpdateErrorAlert(viewModel: CountersList.UpdateCounter.ViewModel.Failure) {
        displayUpdateErrorAlertCalled = true
        displayUpdateErrorAlertViewModel = viewModel
    }

    func displayUpdateCounter(viewModel: CountersList.UpdateCounter.ViewModel.Success) {
        displayUpdateCounterCalled = true
        displayUpdateCounterViewModel = viewModel
    }
}
