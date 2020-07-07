//
//  CreateCounterBusinessLogicSpy.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

@testable import Counters

class CreateCounterBusinessLogicSpy: CreateCounterBusinessLogic {

    var createCounterCalled = true
    var createCounterRequest: CreateCounter.NewCounter.Request?

    func createCounter(request: CreateCounter.NewCounter.Request) {
        createCounterCalled = true
        createCounterRequest = request
    }
}
