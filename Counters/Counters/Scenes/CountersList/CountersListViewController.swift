//
//  CountingListViewController.swift
//  Counting
//
//

import UIKit

protocol CountersListDisplayLogic: AnyObject {
    func displayCountingList(viewModel: CountersList.Counters.ViewModel.Success)
    func displayDeleteCounter(viewModel: CountersList.DeleteCounter.ViewModel.Success)
    func displayPlaceHolderView(viewModel: CountersList.Placeholder.ViewModel)
    func displayDeleteErrorAlert(viewModel: CountersList.DeleteCounter.ViewModel.Failure)
    func displayUpdateErrorAlert(viewModel: CountersList.UpdateCounter.ViewModel.Failure)
    func displayUpdateCounter(viewModel: CountersList.UpdateCounter.ViewModel.Success)
}

class CountersListViewController:
    UIViewController,
    CountersListDisplayLogic,
    CounterTableViewCellDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchResultsUpdating,
    UISearchBarDelegate
     {

    // MARK: - IBOutlets
    @IBOutlet private weak var countersTableView: UITableView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var footerLabel: UILabel!
    @IBOutlet private weak var trashButton: UIButton!

    // MARK: - Attributes
    private var cells: [CounterTableViewCell] = [CounterTableViewCell]()
    private var filteredCells: [CounterTableViewCell] = [CounterTableViewCell]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchActive: Bool = false

    private var editButton: UIBarButtonItem {
        UIBarButtonItem(title: "COUNTERSLIST_EDIT_BUTTON".localized, style: .plain, target: self, action: #selector(editButtonPressed))
    }

    private var doneButton: UIBarButtonItem {
        UIBarButtonItem(title: "COUNTERSLIST_DONE_BUTTON".localized, style: .plain, target: self, action: #selector(doneButtonPressed))
    }

    private var selectAllButton: UIBarButtonItem {
        UIBarButtonItem(
            title: "COUNTERSLIST_SELECTALL_BUTTON".localized,
            style: .plain,
            target: self,
            action: #selector(selectAllPressed)
        )
    }

    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    var placeHolderView: MainActivityPlaceholderView?
    var bottomButtonsView: BottomButtonsView?

    var interactor: CountersListBusinessLogic?
    var router: (NSObjectProtocol & CountersListRoutingLogic & CountersListDataPassing)?

    // MARK: - Object lifecycle

    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        let viewController = self
        let interactor = CountersListInteractor()
        let presenter = CountersListPresenter()
        let router = CountersListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }


    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        showActivityIndicator()
        interactor?.doCountersList()
    }


    // MARK: - Private

    private func updateFooterLabel() {
        if cells.isEmpty {
            footerLabel.text = ""
            return
        }

        var countersCount: Int = 0

        cells.forEach { cell in
            countersCount += cell.data?.count ?? 0
        }

        footerLabel.text = "COUNTERSLIST_FOOTER_BODY".localized(with: cells.count, countersCount)

    }

    private func setupUI() {
        navigationController?.navigationBar.tintColor = UIColor(named: "mainOrange")
        navigationController?.navigationBar.backgroundColor = UIColor(named: "navBar")
        navigationItem.title = "COUNTERSLIST_TITLE".localized
        navigationItem.leftBarButtonItem = editButton

        updateFooterLabel()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        view.backgroundColor = .white

        setupTableView()

        setupSearchController()

        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        trashButton.addTarget(self, action: #selector(trashButtonPressed), for: .touchUpInside)


    }

    private func setupCells(with counters: [Counter]) {
        cells = []
        for (index, data) in counters.enumerated() {
            let abstractCell = countersTableView.dequeueReusableCell(withIdentifier: "CounterCell", for: IndexPath(row: index, section: 0))
            if let cell = abstractCell as? CounterTableViewCell {
                cell.configure(with: data)
                cell.delegate = self
                cells.append(cell)
            }
        }
        countersTableView.reloadData()
    }

    private func setupTableView() {
        countersTableView.translatesAutoresizingMaskIntoConstraints = false
        countersTableView.allowsSelection = false
        countersTableView.delegate = self
        countersTableView.dataSource = self
        countersTableView.rowHeight = UITableView.automaticDimension
        countersTableView.estimatedRowHeight = 100
        countersTableView.separatorStyle = .none
        countersTableView.separatorColor = .none
        countersTableView.allowsMultipleSelectionDuringEditing = true

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCountersTableView), for: .valueChanged)
        countersTableView.refreshControl = refreshControl

        let counterCell = UINib(nibName: "CounterTableViewCell", bundle: nil)
        countersTableView.register(counterCell, forCellReuseIdentifier: "CounterCell")
    }


    private func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupShareButton(isHidden: Bool) {
        if isHidden {
            plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
            plusButton.removeTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
            plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
            return
        }
        plusButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        plusButton.removeTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)

    }

    // MARK: - Buttons functions
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc
    private func editButtonPressed(){
        trashButton.isHidden = false
        countersTableView.isEditing = true
        setupShareButton(isHidden: false)
        self.navigationItem.rightBarButtonItem = selectAllButton
        self.navigationItem.leftBarButtonItem = doneButton
    }

    @objc
    private func doneButtonPressed() {
        trashButton.isHidden = true
        setupShareButton(isHidden: true)
        countersTableView.isEditing = false
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = editButton

    }

    @objc
    private func trashButtonPressed() {
        guard let selectedCells = countersTableView.indexPathsForSelectedRows?.map(
                { countersTableView.cellForRow(at: $0) }
        ) as? [CounterTableViewCell],
        let selectedCounters = selectedCells.map(
            { $0.data }
        ) as? [Counter] else { return }


        let data: BottomButtonsViewData = .init(
            actionButtonTitle: "DELETECOUNTER_CONFIRMATION_DELETE_BUTTON_TITLE".localized(with: selectedCells.count),
            cancelButtonTitle: "DELETECOUNTER_CONFIRMATION_CANCEL_BUTTON_TITLE".localized)

        bottomButtonsView = BottomButtons.initWith(data)
        guard let bottomButtonsView = bottomButtonsView else { return }
        
        bottomButtonsView.actionButtonClosure = { [weak self] in
            self?.showActivityIndicator()
            self?.interactor?.doDelete(counters: selectedCounters)
        }

        bottomButtonsView.cancelButtonClosure = {
            //fill if needed
        }

        bottomButtonsView.show()
    }

    @objc
    private func refreshCountersTableView(){
        interactor?.doCountersList()
    }

    @objc
    func plusButtonPressed(){
        router?.routeToCreateCounter()
    }

    @objc
    func selectAllPressed() {
        for (index, _) in cells.enumerated() {
            countersTableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .none)
        }
    }

    @objc
    private func shareButtonPressed () {
        let selectedRowPaths = countersTableView.indexPathsForSelectedRows
        var selectedCountersTitles = [String]()
        selectedRowPaths?.forEach{ indexPath in
            guard let selectedCell = countersTableView.cellForRow(at: indexPath) as? CounterTableViewCell,
                  let counter = selectedCell.data else { return }
            selectedCountersTitles.append(counter.title)
        }

        let sharingVC = UIActivityViewController(activityItems: selectedCountersTitles, applicationActivities: [])
        present(sharingVC, animated: true, completion: nil)
    }

    private func filterContentForSearchText(_ searchText: String) {
      filteredCells = cells.filter { (cell: CounterTableViewCell) -> Bool in
        cell.cellTitle.lowercased().contains(searchText.lowercased())
      }
        if filteredCells.count == 0 && isFiltering {
            countersTableView.setMessage("No results")
        } else {
            countersTableView.clearBackground()
        }
      countersTableView.reloadData()
    }

    // MARK: - Public
    func inject(counters: [Counter]) {
        placeHolderView?.removeFromSuperview()
        setupCells(with: counters)
        updateFooterLabel()
        navigationItem.leftBarButtonItem?.isEnabled = true
    }

    // MARK: - CountingListDisplayLogic

    func displayCountingList(viewModel: CountersList.Counters.ViewModel.Success) {
        placeHolderView?.removeFromSuperview()
        countersTableView.clearBackground()
        setupCells(with: viewModel.counters)
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        countersTableView.refreshControl?.endRefreshing()
        updateFooterLabel()
        hideActivityIndicator()
    }

    func displayPlaceHolderView(viewModel: CountersList.Placeholder.ViewModel) {
        if !cells.isEmpty { return }
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        countersTableView.refreshControl?.endRefreshing()
        placeHolderView?.removeFromSuperview()
        cells = []

        let data: MainActivityPlaceholderViewData = .init(viewModel.title, viewModel.body, viewModel.buttonTitle)
        placeHolderView = MainActivityPlaceholder.initWith(data)
        guard let placeHolderView = placeHolderView else { return }

        placeHolderView.actionButtonClosure = { [weak self] in
            switch viewModel.type {
            case .noInternet:
                self?.showActivityIndicator()
                self?.interactor?.doCountersList()
            case .noCounters:
                self?.router?.routeToCreateCounter()
            }
        }

        view.addSubview(placeHolderView)
        placeHolderView.widthAnchor.constraint(equalToConstant: 304).isActive = true
        placeHolderView.heightAnchor.constraint(equalToConstant: 161).isActive = true

        placeHolderView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: 0).isActive = true
        placeHolderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0).isActive = true
        updateFooterLabel()
        hideActivityIndicator()
    }

    func displayDeleteErrorAlert(viewModel: CountersList.DeleteCounter.ViewModel.Failure){
        bottomButtonsView?.hide()
        presentErrorAlertWith(
            viewModel: .init(
                title: viewModel.title,
                message: viewModel.message,
                primaryButtonTitle: viewModel.primaryButton
            )
        )
        updateFooterLabel()
        hideActivityIndicator()
    }

    func displayUpdateErrorAlert(viewModel: CountersList.UpdateCounter.ViewModel.Failure) {

        guard let counter = viewModel.counter else {
            debugPrint("this should be possible")
            return
        }

        switch viewModel.type {
        case .decrease:
            presentErrorAlertWith(
                viewModel: .init(
                    title: viewModel.title,
                    message: viewModel.message,
                    primaryButtonTitle: viewModel.primaryButton,
                    secondaryButtonTitle: viewModel.secondaryButton,
                    primaryButtonAction: { [weak self] in
                        self?.showActivityIndicator()
                        self?.interactor?.doDecrease(counter: counter)
                    }
                )
            )
        case .increase:
            presentErrorAlertWith(
                viewModel: .init(
                    title: viewModel.title,
                    message: viewModel.message,
                    primaryButtonTitle: viewModel.primaryButton,
                    secondaryButtonTitle: viewModel.secondaryButton,
                    primaryButtonAction: { [weak self] in
                        self?.showActivityIndicator()
                        self?.interactor?.doIncrease(counter: counter)
                    }
                )
            )
        case . none:
            debugPrint("handle other errors")
        }
        hideActivityIndicator()
        updateFooterLabel()
    }

    func displayDeleteCounter(viewModel: CountersList.DeleteCounter.ViewModel.Success) {
        guard let deletedCell = cells.filter ({
                $0.data?.id == viewModel.counter.id
        }).first, let indexPath = countersTableView.indexPath(for: deletedCell) else { return }

        cells = cells.filter {
            $0.data?.id != deletedCell.data?.id
        }

        countersTableView.beginUpdates()
        countersTableView.deleteRows(at: [indexPath], with: .automatic)
        countersTableView.endUpdates()

        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = editButton

        countersTableView.isEditing = false
        bottomButtonsView?.hide()
        updateFooterLabel()
        trashButton.isHidden = true
        if cells.isEmpty {
            displayPlaceHolderView(
                viewModel: .init(
                    title: "NO_COUNTERS_PH_TITLE".localized,
                    body: NSAttributedString(string: "NO_COUNTERS_PH_BODY".localized),
                    buttonTitle: "NO_COUNTERS_PH_BUTTON_TITLE".localized,
                    type: .noCounters
                )
            )
        }

        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.removeTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)

        hideActivityIndicator()

    }

    func displayUpdateCounter(viewModel: CountersList.UpdateCounter.ViewModel.Success) {

        if let row = cells.firstIndex(where: { $0.data?.id == viewModel.counter.id }),
           let outdatedCell = cells.first(where: { $0.data?.id == viewModel.counter.id }) {
            outdatedCell.data = viewModel.counter
            cells[row] = outdatedCell

            countersTableView.beginUpdates()
            countersTableView.reloadRows(at: [IndexPath(row: row, section: .zero)], with: .none)
            countersTableView.endUpdates()

            updateFooterLabel()
        }

        hideActivityIndicator()
    }

    // MARK: - TableViewDelegateMethods

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ?  filteredCells.count : cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        isFiltering ? filteredCells[indexPath.row] : cells[indexPath.row]
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    // MARK: - UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        countersTableView.clearBackground()
    }

    // MARK: - CounterTableViewCellDelegate

    func decreaseButtonPressed(counter: Counter) {
        showActivityIndicator()
        interactor?.doDecrease(counter: counter )
    }

    func increaseButtonPressed(counter: Counter) {
        showActivityIndicator()
        interactor?.doIncrease(counter: counter)
    }

    var activityIndicator: SpinnerViewController?
    func showActivityIndicator() {
        activityIndicator = SpinnerViewController()

        // add the spinner view controller
        addChild(activityIndicator!)
        activityIndicator!.view.frame = view.frame
        view.addSubview(activityIndicator!.view)
        activityIndicator!.didMove(toParent: self)
    }

    func hideActivityIndicator() {
        activityIndicator?.willMove(toParent: nil)
        activityIndicator?.view.removeFromSuperview()
        activityIndicator?.removeFromParent()
    }
}
