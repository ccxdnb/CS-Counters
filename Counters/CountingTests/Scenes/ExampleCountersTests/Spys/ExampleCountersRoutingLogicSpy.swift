//
//  ExampleCountersRouterSpy.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//


class ExampleCountersRoutingLogicSpy: ExampleCountersRoutingLogic {

    var routeToCountersListCalled = false
    var routeToCountersListExampleCounter: String?
    func routeToCountersList(exampleCounter: String) {
        routeToCountersListCalled = true
        routeToCountersListExampleCounter = exampleCounter
    }

}
