//
//  CountingListRouter.swift
//  Counting
//
//

import UIKit

@objc protocol CountersListRoutingLogic {
    func routeToCreateCounter()
}

protocol CountersListDataPassing {
    var dataStore: CountersListDataStore? { get }
}

class CountersListRouter: NSObject, CountersListRoutingLogic, CountersListDataPassing {

    weak var viewController: CountersListViewController?
    var dataStore: CountersListDataStore?

    // MARK: - Routing

    func routeToCreateCounter() {
        let bundle = Bundle(for: CountersListRouter.self)

        guard let destinationVC: UIViewController = UIStoryboard(name: "CreateCounter", bundle: bundle).instantiateViewController(withIdentifier: "CreateCounterViewController") as? CreateCounterViewController else { return }

        destinationVC.modalPresentationStyle = .fullScreen
        navigateTo(vc: destinationVC)

    }
    // MARK: - Navigation

    private func navigateTo(vc: UIViewController){
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Passing data

}
