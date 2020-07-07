//
//  CreateCounterViewController.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

import UIKit

protocol CreateCounterDisplayLogic: AnyObject {
    func displayCountersList(viewModel: CreateCounter.NewCounter.ViewModel.Success)
    func displayErrorAlert(viewModel: CreateCounter.NewCounter.ViewModel.Failure)
}

class CreateCounterViewController:
    UIViewController,
    CreateCounterDisplayLogic,
    UITextFieldDelegate,
    UITextViewDelegate {

    // MARK: - IBOutlets


    // MARK: - Attributes

    private var cancelButton: UIBarButtonItem {
        UIBarButtonItem(title: "CREATE_COUNTER_CANCEL_BUTTON".localized, style: .plain, target: self, action: #selector(cancelButtonPressed))
    }

    private var saveButton: UIBarButtonItem {
        UIBarButtonItem(title: "CREATE_COUNTER_SAVE_BUTTON".localized, style: .plain, target: self, action: #selector(saveButtonPressed))
    }

    var examplesTextView = UITextView()
    let nameTextField = CounterNameField()

    var interactor: CreateCounterBusinessLogic?
    var router: (NSObjectProtocol & CreateCounterRoutingLogic & CreateCounterDataPassing)?

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
        let interactor = CreateCounterInteractor()
        let presenter = CreateCounterPresenter()
        let router = CreateCounterRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override  func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Private

    private func setupUI() {
        view.backgroundColor = UIColor(named: "bgGray")

        navigationItem.title = "CREATE_COUNTER_TITLE".localized
        navigationItem.backButtonTitle = "COUNTERSLIST_TITLE".localized
        navigationItem.largeTitleDisplayMode  = .never
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton

        view.addSubview(nameTextField)
        nameTextField.delegate = self
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12).isActive = true

        setupExamplesLabel()
        view.addSubview(examplesTextView)
        examplesTextView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 13).isActive = true
        examplesTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        examplesTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        examplesTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }

    private func setupExamplesLabel () {
        let attributedString = NSMutableAttributedString(
            string: "CREATE_COUNTER_SUBTITLE_BASE".localized,
            attributes: nil
        )
        let linkedString = NSMutableAttributedString(string: "CREATE_COUNTER_EXAMPLE_LINK".localized)
        linkedString.addAttribute(NSAttributedString.Key.link, value: "CREATE_COUNTER_EXAMPLE_LINK".localized, range: NSMakeRange(0,linkedString.length))

        attributedString.append(linkedString)

        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "textGray") ?? UIColor.lightText,
            NSAttributedString.Key.underlineColor: UIColor(named: "textGray") ?? UIColor.lightText,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        examplesTextView.delegate = self
        examplesTextView.attributedText = attributedString
        examplesTextView.linkTextAttributes = linkAttributes
        examplesTextView.isSelectable = true
        examplesTextView.isEditable = false
        examplesTextView.isScrollEnabled = false
        examplesTextView.font = .systemFont(ofSize: 15)
        examplesTextView.textColor = UIColor(named: "textGray")
        examplesTextView.translatesAutoresizingMaskIntoConstraints = false
        examplesTextView.backgroundColor = .clear
    }

    @objc
    private func cancelButtonPressed(){
        navigationController?.popViewController(animated: true)
    }

    @objc
    func saveButtonPressed(){
        guard let counterName = nameTextField.text, !counterName.isEmpty else { return }
        nameTextField.startLoading()
        interactor?.createCounter(request: .init(title: counterName))
    }

    // MARK: - Public

    public func inject(counterName: String) {
        nameTextField.text = counterName
    }


    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }

    // MARK: CreateCounterDisplayLogic

    func displayCountersList(viewModel: CreateCounter.NewCounter.ViewModel.Success) {
        router?.routeToCountersList(newCounters: viewModel.counters)
    }

    func displayErrorAlert(viewModel: CreateCounter.NewCounter.ViewModel.Failure) {
        nameTextField.stopLoading()
        presentErrorAlertWith(
            viewModel: .init(
                title: viewModel.title,
                message: viewModel.message,
                primaryButtonTitle: viewModel.buttonTitle,
                secondaryButtonTitle: nil,
                primaryButtonAction: {}
            )
        )
    }

    // MARK: UITextViewDelegate
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        router?.routeToExampleCounters()
        return false
    }
}
