//
//  ExampleCountersPresenter.swift
//  Counters
//
//

import UIKit

protocol ExampleCountersPresentationLogic {
    func presentExamples(response: ExampleCounters.Examples.Response.Success)
}

class ExampleCountersPresenter: ExampleCountersPresentationLogic {

    weak  var viewController: ExampleCountersDisplayLogic?

    // MARK: Methods

    func presentExamples(response: ExampleCounters.Examples.Response.Success) {
        viewController?.displayExamples(
            viewModel: .init(examples: response.examples)
        )
    }
}
