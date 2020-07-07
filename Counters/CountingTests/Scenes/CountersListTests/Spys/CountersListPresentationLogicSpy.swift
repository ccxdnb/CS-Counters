//
//  CountersListPresentationLogicSpy.swift
//  Counters
//
//

@testable import Counters

class CountersListPresentationLogicSpy: CountersListPresentationLogic {
    var presentCounterListCalled = false
    var presentDeletedCounterCalled = false
    var presentEmptyCountingListCalled = false
    var presentNoInternetListCalled = false
    var presentDeleteErrorCalled = false
    var presentUpdatedCounterCalled = false
    var presentUpdateErrorCalled = false

    var presentCounterListResponse: CountersList.Counters.Response?
    var presentDeletedCounterResponse: CountersList.DeleteCounter.Response?
    var presentDeleteErrorResponse: CountersList.DeleteCounter.Response?
    var presentUpdatedCounterResponse: CountersList.UpdateCounter.Response?
    var presentUpdateErrorResponse: CountersList.UpdateCounter.Response?

    func presentCounterList(response: CountersList.Counters.Response) {
        presentCounterListCalled = true
        presentCounterListResponse = response
    }

    func presentDeletedCounter(response: CountersList.DeleteCounter.Response) {
        presentDeletedCounterCalled = true
        presentDeletedCounterResponse = response
    }

    func presentEmptyCountingList() {
        presentEmptyCountingListCalled = true
    }

    func presentNoInternetList() {
        presentNoInternetListCalled = true
    }

    func presentDeleteError(response: CountersList.DeleteCounter.Response) {
        presentDeleteErrorCalled = true
        presentDeleteErrorResponse = response
    }

    func presentUpdatedCounter(response: CountersList.UpdateCounter.Response) {
        presentUpdatedCounterCalled = true
        presentUpdatedCounterResponse = response
    }

    func presentUpdateError(response: CountersList.UpdateCounter.Response) {
        presentUpdateErrorCalled = true
        presentUpdateErrorResponse = response
    }

}
