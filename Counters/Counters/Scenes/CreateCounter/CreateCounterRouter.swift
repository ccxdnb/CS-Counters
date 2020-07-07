//
//  CreateCounterRouter.swift
//  Counters
//
//

import UIKit

protocol CreateCounterRoutingLogic {
    func routeToCountersList(newCounters: [Counter])
    func routeToExampleCounters()
}

protocol CreateCounterDataPassing {
    var dataStore: CreateCounterDataStore? { get }
}

class CreateCounterRouter: NSObject, CreateCounterRoutingLogic, CreateCounterDataPassing {

    weak var viewController: CreateCounterViewController?
    var dataStore: CreateCounterDataStore?

    // MARK: Routing

    func routeToCountersList(newCounters: [Counter]) {

        let destinationVC = viewController?.navigationController?.viewControllers.filter {
            $0.isKind(of: CountersListViewController.self)
        }.first

        guard let counterListVC = destinationVC as? CountersListViewController else {
            return
        }

        counterListVC.inject(counters: newCounters)
        viewController?.navigationController?.popViewController(animated: true)
    }

    func routeToExampleCounters() {
        let bundle = Bundle(for: ExampleCountersViewController.self)

        guard let destinationVC: UIViewController = UIStoryboard(name: "ExampleCounters", bundle: bundle).instantiateViewController(withIdentifier: "ExampleCountersViewController") as? ExampleCountersViewController else { return }

        viewController?.navigationController?.pushViewController(destinationVC, animated: true)

    }

    // MARK: Navigation

    // func navigateToSomewhere(source: CreateCounterViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    // func passDataToSomewhere(source: CreateCounterDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
