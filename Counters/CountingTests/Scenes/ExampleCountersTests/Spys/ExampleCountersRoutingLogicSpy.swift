//
//  ExampleCountersRouterSpy.swift
//  Counters
//
//

class ExampleCountersRoutingLogicSpy: ExampleCountersRoutingLogic {

    var routeToCountersListCalled = false
    var routeToCountersListExampleCounter: String?
    func routeToCountersList(exampleCounter: String) {
        routeToCountersListCalled = true
        routeToCountersListExampleCounter = exampleCounter
    }

}
