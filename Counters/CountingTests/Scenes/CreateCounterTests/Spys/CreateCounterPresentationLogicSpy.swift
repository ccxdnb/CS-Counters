//
//  CreateCounterPresentationLogicSpy.swift
//  Counters
//
//

@testable import Counters

class CreateCounterPresentationLogicSpy: CreateCounterPresentationLogic {

    var presentCounterListCalled = false
    var presentConnectionErrorCalled = false
    var presentCounterListResponse: CreateCounter.NewCounter.Response.Success?

    func presentCounterList(response: CreateCounter.NewCounter.Response.Success) {
        presentCounterListCalled = true
        presentCounterListResponse = response
    }

    func presentConnectionError() {
        presentConnectionErrorCalled = true
    }
}
