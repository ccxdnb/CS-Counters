//
//  ExampleCountersInteractor.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

import Foundation

protocol ExampleCountersBusinessLogic {
    func doExamples(request: ExampleCounters.Examples.Request)
}

protocol ExampleCountersDataStore {
    //var name: String { get set }
}

class ExampleCountersInteractor: ExampleCountersBusinessLogic, ExampleCountersDataStore {

    var presenter: ExampleCountersPresentationLogic?

    // MARK: Methods

    func doExamples(request: ExampleCounters.Examples.Request) {

        let testExamples = [
            "DRINKS": ["COFFE","BEER","PECSI","COFFE","BEER","PECSI"],
            "FOOD": ["BEYOND","PANCHO","PECSI","COFFE","BEER","PECSI"],
            "MISC": ["NAPS","PAJA DSD DSA DS S","PECSI","COFFE","BEER","PECSI","COFFE","BEER","PECSI"],
            "SPORT": ["SQUATS","fLEXI","ABS","COFFE","BEER","PECSI"],
        ]

        presenter?.presentExamples(response: .init(examples: testExamples))
    }
}
