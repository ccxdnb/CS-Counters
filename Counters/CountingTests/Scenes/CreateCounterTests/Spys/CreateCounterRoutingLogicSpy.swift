//
//  CreateCounterRoutingLogicSpy.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import Counters
import Foundation

class CreateCounterRoutingLogicSpy: NSObject, CreateCounterRoutingLogic, CreateCounterDataPassing {

    var routeToCountersListCalled = false
    var routeToExampleCountersCalled = false
    var routeToCountersListNewCounters: [Counter]?

    func routeToCountersList(newCounters: [Counter]) {
        routeToCountersListCalled = true
        routeToCountersListNewCounters = newCounters
    }

    func routeToExampleCounters() {
        routeToExampleCountersCalled = true
    }

    var dataStore: CreateCounterDataStore?
}
