//
//  CountersListViewControllerTests.swift
//  Counters
//
//

import XCTest

class CountersListViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: CountersListViewController!
    var spyInteractor: CountersListBusinessLogicSpy!
    var spyRouter: CountersListRoutingLogicSpy!
    var window: UIWindow!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        window = UIWindow()
        setupCountersListViewController()
    }

    override  func tearDown() {
        spyInteractor = nil
        spyRouter = nil
        sut = nil
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupCountersListViewController() {
        let bundle = Bundle(for: CountersListViewController.self)

        let storyboard = UIStoryboard(name: "CountingList", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "CountersListViewController") as! CountersListViewController)

        spyInteractor = CountersListBusinessLogicSpy()
        sut.interactor = spyInteractor

        spyRouter = CountersListRoutingLogicSpy()
        sut.router = spyRouter

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
       XCTAssertTrue(spyInteractor.doCountersListCalled)
   }

    func testDecreaseButtonPressed() {
        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)
        // When
        sut.decreaseButtonPressed(counter: testCounter)
        // Then
        XCTAssertTrue(spyInteractor.doDecreaseCalled)
    }

    func testIncreaseButtonPressed() {
        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)
        // When
        sut.increaseButtonPressed(counter: testCounter)
        // Then
        XCTAssertTrue(spyInteractor.doIncreaseCalled)
    }

    func testTrashButtonPressed() {
        //TOOO... harder to create scenario
    }
}
