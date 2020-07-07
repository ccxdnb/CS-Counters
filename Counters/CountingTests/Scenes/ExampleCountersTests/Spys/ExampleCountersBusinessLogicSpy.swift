//
//  ExampleCountersBusinessLogicSpy.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

class ExampleCountersBusinessLogicSpy: ExampleCountersBusinessLogic {

    var doExamplesCalled = false
    var doExamplesRequest: ExampleCounters.Examples.Request?

    func doExamples(request: ExampleCounters.Examples.Request) {
        doExamplesCalled = true
        doExamplesRequest = request
    }


}
