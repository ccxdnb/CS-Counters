//
//  ExampleCountersRouter.swift
//  Counters
//
//

import UIKit

@objc
protocol ExampleCountersRoutingLogic {
     func routeToCountersList(exampleCounter: String)
}

protocol ExampleCountersDataPassing {
    var dataStore: ExampleCountersDataStore? { get }
}

class ExampleCountersRouter: NSObject, ExampleCountersRoutingLogic, ExampleCountersDataPassing {
    weak var viewController: ExampleCountersViewController?
    var dataStore: ExampleCountersDataStore?

    // MARK: Routing

    func routeToCountersList(exampleCounter: String) {

        let destinationVC = viewController?.navigationController?.viewControllers.filter {
            $0.isKind(of: CreateCounterViewController.self)
        }.first

        guard let createCounterVC = destinationVC as? CreateCounterViewController else {
            return
        }

        createCounterVC.inject(counterName: exampleCounter)
        pop(animated: true)
    }
    // MARK: Navigation

    private func pop(animated: Bool){
        viewController?.navigationController?.popViewController(animated: animated)
    }
    
    // MARK: Passing data

    
}
