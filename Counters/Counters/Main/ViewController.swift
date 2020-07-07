//
//  ViewController.swift
//  Counting
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            presentCountingListVC()
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            showWelcomeView()
        }
    }


    private func presentCountingListVC() {
        let bundle = Bundle(for: CountersListViewController.self)

        guard let destinationVC: UIViewController = UIStoryboard(name: "CountingList", bundle: bundle).instantiateViewController(withIdentifier: "CountersListViewController") as? CountersListViewController else { return }

        self.navigationController?.pushViewController(destinationVC, animated: false)
    }

    private func showWelcomeView () {
        let bundle = Bundle.main
        guard let welcomeView = bundle.loadNibNamed("WelcomeView",
            owner: nil,
            options: nil
            )?.first as? WelcomeView else { return }

        welcomeView.continueButtonAction = { [weak self] in
            self?.presentCountingListVC()
        }

        let currentWindow: UIWindow? = UIApplication.shared.windows.first
        currentWindow?.addSubview(welcomeView)

        view.addSubview(welcomeView)
    }
}
