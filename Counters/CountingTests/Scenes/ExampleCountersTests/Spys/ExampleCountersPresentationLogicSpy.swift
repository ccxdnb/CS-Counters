//
//  ExampleCountersPresentationLogicSpy.swift
//  Counters
//
//

class ExampleCountersPresentationLogicSpy: ExampleCountersPresentationLogic {

    var presentExamplesCalled = false
    var presentExamplesResponse: ExampleCounters.Examples.Response.Success?
    func presentExamples(response: ExampleCounters.Examples.Response.Success) {
        presentExamplesCalled = true
        presentExamplesResponse = response
    }


}
