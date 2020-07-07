//
//  ExampleCountersPresenter.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
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
