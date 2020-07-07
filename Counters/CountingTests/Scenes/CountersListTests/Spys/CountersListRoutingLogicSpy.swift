//
//  CountersListRoutingLogicSpy.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
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
