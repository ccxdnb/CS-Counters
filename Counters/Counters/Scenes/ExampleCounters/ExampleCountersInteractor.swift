//
//  ExampleCountersInteractor.swift
//  Counters
//
//

import Foundation

protocol ExampleCountersBusinessLogic {
    func doExamples(request: ExampleCounters.Examples.Request)
}

protocol ExampleCountersDataStore {
}

class ExampleCountersInteractor: ExampleCountersBusinessLogic, ExampleCountersDataStore {

    var presenter: ExampleCountersPresentationLogic?

    // MARK: Methods

    func doExamples(request: ExampleCounters.Examples.Request) {
        // TODO: replace for service call
        let testExamples = [
            "DRINKS": ["Coffe","Beer","Juice","Te","More beer","Wine"],
            "FOOD": ["Burgers","Completo","Sushi","Milanesas","Pizza","Empanada"],
            "MISC": ["Naps","Yoga","Tutorials","Apps","Loundry","Dishes","Shits"],
            "SPORT": ["Squats","Abs","Kilometers","Vegetables","Protein bars","laps"],
        ]

        presenter?.presentExamples(response: .init(examples: testExamples))
    }
}
