//
//  ExampleCountersPresentationLogicSpy.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

class ExampleCountersPresentationLogicSpy: ExampleCountersPresentationLogic {

    var presentExamplesCalled = false
    var presentExamplesResponse: ExampleCounters.Examples.Response.Success?
    func presentExamples(response: ExampleCounters.Examples.Response.Success) {
        presentExamplesCalled = true
        presentExamplesResponse = response
    }


}
