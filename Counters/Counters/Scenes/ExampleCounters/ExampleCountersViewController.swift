//
//  ExampleCountersViewController.swift
//  Counters
//
//

import UIKit

protocol ExampleCountersDisplayLogic: AnyObject {
    func displayExamples(viewModel: ExampleCounters.Examples.ViewModel.Success)
}

class ExampleCountersViewController: UIViewController, ExampleCountersDisplayLogic,
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate
{

    var interactor: ExampleCountersBusinessLogic?
    var router: (NSObjectProtocol & ExampleCountersRoutingLogic & ExampleCountersDataPassing)?

    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet private(set) weak var examplesTableView: UITableView!
    @IBOutlet private weak var headerLabel: UILabel!

    private var cells = [ExampleCountersTableViewCell]()
    var examples = [String: [String]]()

    // MARK: Object lifecycle

    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = ExampleCountersInteractor()
        let presenter = ExampleCountersPresenter()
        let router = ExampleCountersRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override  func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override  func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.doExamples(request: .init())
    }

    // MARK: Methods

    private func setupUI() {
        navigationItem.title = "EXAMPLE_COUNTER_TITLE".localized
        headerLabel.text = "EXAMPLE_COUNTER_SUBTITLE".localized

        examplesTableView.translatesAutoresizingMaskIntoConstraints = false
        examplesTableView.allowsSelection = false
        examplesTableView.delegate = self
        examplesTableView.dataSource = self
        examplesTableView.rowHeight = UITableView.automaticDimension
        examplesTableView.estimatedRowHeight = 55
        examplesTableView.separatorStyle = .none
        examplesTableView.separatorColor = .none
        examplesTableView.allowsMultipleSelectionDuringEditing = true
        examplesTableView.sectionHeaderHeight = 40

        let bundle = Bundle(for: ExampleCountersViewController.self)

        let exampleCell = UINib(nibName: "ExampleCountersTableViewCell", bundle: bundle)
        examplesTableView.register(exampleCell, forCellReuseIdentifier: "ExampleCountersTableViewCell")
        
    }

    private func setupCells() {
        cells = []
        for (index, data) in examples.enumerated() {
            let abstractCell = examplesTableView.dequeueReusableCell(withIdentifier: "ExampleCountersTableViewCell", for: IndexPath(row: 0, section: index))
            if let cell = abstractCell as? ExampleCountersTableViewCell {
                cell.configure(with: data.value)
                cell.collectionView.delegate = self
                cells.append(cell)
            }
        }

        examplesTableView.reloadData()

    }

    @objc
    private func saveButtonPressed () {
        //do pop with name
    }

    // MARK: - ExampleCountersDisplayLogic

    func displayExamples(viewModel: ExampleCounters.Examples.ViewModel.Success) {
        examples = viewModel.examples
        setupCells()
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        cells.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         Array(examples.keys)[section]
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 8, width: 320, height: 20)
        myLabel.font =  .systemFont(ofSize: 13, weight: .regular)
        myLabel.textColor =  UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cells[indexPath.section]
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tappedCell = collectionView.cellForItem(at: indexPath) as? ExampleCountersCollectionViewCell,
              let titleText = tappedCell.data else { return }

        router?.routeToCountersList(exampleCounter: titleText)
    }
}
