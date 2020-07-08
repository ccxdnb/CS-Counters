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
        pop(animated: true)
    }

    func routeToExampleCounters() {
        let bundle = Bundle(for: ExampleCountersViewController.self)

        guard let destinationVC: UIViewController = UIStoryboard(name: "ExampleCounters", bundle: bundle).instantiateViewController(withIdentifier: "ExampleCountersViewController") as? ExampleCountersViewController else { return }

            navigateTo(vc:destinationVC)
    }

    // MARK: Navigation

    private func navigateTo(vc: UIViewController){
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    private func pop(animated: Bool){
        viewController?.navigationController?.popViewController(animated: animated)
    }
    
    // MARK: Passing data

}
