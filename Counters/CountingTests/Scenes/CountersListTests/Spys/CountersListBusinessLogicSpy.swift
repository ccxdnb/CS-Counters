//
//  CountersListBusinessLogicSpy.swift
//  Counters
//
//

@testable import Counters

class CountersListBusinessLogicSpy: CountersListBusinessLogic {

    var doCountersListCalled = false
    var doDeleteCalled = false
    var doIncreaseCalled = false
    var doDecreaseCalled = false

    var counters: [Counter]? //TODO CHANGE FOR REQUEST OBJECT

    func doCountersList() {
        doCountersListCalled = true
    }

    func doDelete(counters: [Counter]) {
        doDeleteCalled = true
    }

    func doIncrease(counter: Counter) {
        doIncreaseCalled = true
    }

    func doDecrease(counter: Counter) {
        doDecreaseCalled = true
    }

}
