//
//  ExampleCountersBusinessLogicSpy.swift
//  Counters
//
//

class ExampleCountersBusinessLogicSpy: ExampleCountersBusinessLogic {

    var doExamplesCalled = false
    var doExamplesRequest: ExampleCounters.Examples.Request?

    func doExamples(request: ExampleCounters.Examples.Request) {
        doExamplesCalled = true
        doExamplesRequest = request
    }
}
