//
//  CreateCounterViewControllerTests.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//


import XCTest

class CreateCounterViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CreateCounterViewController!
    var spyInteractor: CreateCounterBusinessLogicSpy!
    var spyRouter: CreateCounterRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupCreateCounterViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupCreateCounterViewController() {
        let bundle = Bundle(for: CountersListViewController.self)

        let storyboard = UIStoryboard(name: "CreateCounter", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "CreateCounterViewController") as! CreateCounterViewController)

        spyInteractor = CreateCounterBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = CreateCounterRoutingLogicSpy()
        sut.router = spyRouter

        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

     func testCreateCounter() {
        // Given
        sut.nameTextField.text = "testText"
        // When
        sut.saveButtonPressed()
        // Then
        XCTAssertTrue(spyInteractor.createCounterCalled)
        XCTAssertEqual(spyInteractor.createCounterRequest?.title, "testText")
    }

    func testDisplayCounterList() {
       // Given
       // When
        sut.displayCountersList(viewModel: .init(
                                    counters: [Counter(
                                                id: "testCounterId",
                                                title: "testCounterId",
                                                count: 0)]))
       // Then
       XCTAssertTrue(spyRouter.routeToCountersListCalled)
   }
}
