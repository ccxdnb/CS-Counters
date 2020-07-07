//
//  ExampleCountersRouter.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
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
        navigateToCreateCounter()
    }
    // MARK: Navigation

    private func navigateToCreateCounter(){
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Passing data

    // func passDataToSomewhere(source: CreateCounterDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
