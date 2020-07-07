//
//  CountingListRouter.swift
//  Counting
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

import UIKit

@objc protocol CountersListRoutingLogic {
    func routeToCreateCounter()
}

protocol CountersListDataPassing {
    var dataStore: CountersListDataStore? { get }
}

class CountersListRouter: NSObject, CountersListRoutingLogic, CountersListDataPassing {
    func routeToCreateCounter() {
        let bundle = Bundle(for: CountersListRouter.self)

        guard let destinationVC: UIViewController = UIStoryboard(name: "CreateCounter", bundle: bundle).instantiateViewController(withIdentifier: "CreateCounterViewController") as? CreateCounterViewController else { return }

        destinationVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }


    weak var viewController: CountersListViewController?
    var dataStore: CountersListDataStore?

    // MARK: - Routing


    // MARK: - Passing data

    //func passDataToSomewhere(source: CountingListDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
