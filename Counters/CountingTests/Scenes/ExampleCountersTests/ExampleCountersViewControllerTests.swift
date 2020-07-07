//
//  ExampleCountersViewControllerTests.swift
//  Counters
//
//

import XCTest

class ExampleCountersViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: ExampleCountersViewController!
    var spyInteractor: ExampleCountersBusinessLogicSpy!
    var spyRouter: ExampleCountersRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupExampleCountersViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupExampleCountersViewController() {
        let bundle = Bundle(for: ExampleCountersViewController.self)

        let storyboard = UIStoryboard(name: "ExampleCounters", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ExampleCountersViewController") as! ExampleCountersViewController)

        spyInteractor = ExampleCountersBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = ExampleCountersRoutingLogicSpy()
        //sut.router = spyRouter as! ExampleCountersDataPassing & ExampleCountersRoutingLogic & NSObjectProtocol

        loadView()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests

     func testShouldDoExamplesWhenViewIsLoaded() {
        // Given
        // When
        // Then
        XCTAssertTrue(spyInteractor.doExamplesCalled, "viewDidLoad() should ask the interactor to do something")
        XCTAssertNotNil(spyInteractor.doExamplesRequest, "some value")
    }

     func testDisplayExamplesCalled() {
        // Given
        let testExamples = ["CATEGORY":["VALUE1","VALUE2"]]
        let viewModel = ExampleCounters.Examples.ViewModel.Success(examples: testExamples)
        // When
        sut.displayExamples(viewModel: viewModel)

        // Then
        XCTAssertEqual(Array(sut.examples.keys).first, "CATEGORY", "displaySomething(viewModel:) should update the name text field")
        XCTAssertEqual(sut.examples["CATEGORY"]?.first, "VALUE1", "displaySomething(viewModel:) should update the name text field")
    }
}
