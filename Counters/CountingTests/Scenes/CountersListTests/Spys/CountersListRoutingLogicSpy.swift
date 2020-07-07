//
//  CountersListRoutingLogicSpy.swift
//  Counters
//
//

@testable import Counters
import Foundation

class CountersListRoutingLogicSpy: NSObject, CountersListRoutingLogic, CountersListDataPassing {

    var routeToCreateCounterCalled = false

    func routeToCreateCounter() {
        routeToCreateCounterCalled = true
    }

    var dataStore: CountersListDataStore?
}
