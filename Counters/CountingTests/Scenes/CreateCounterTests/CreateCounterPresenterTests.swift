//
//  CreateCounterPresenterTests.swift
//  Counters
//
//

import XCTest

class CreateCounterPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: CreateCounterPresenter!
    var spyViewController: CreateCounterDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupCreateCounterPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupCreateCounterPresenter() {
        sut = CreateCounterPresenter()
        spyViewController = CreateCounterDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

     func testPresentNewCounter() {
        // Given
        let testCounters = [
            Counter(id: "id1", title: "test1", count: 1),
            Counter(id: "id2", title: "test2", count: 2),
            Counter(id: "id3", title: "test3", count: 3)
        ]

        let response = CreateCounter.NewCounter.Response.Success(counters: testCounters)
        // When
        sut.presentCounterList(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayCountersListCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayCountersListViewModelSuccess?.counters.first?.title, "test1", "presentMovements should change the value to the correct format")
        XCTAssertEqual(spyViewController.displayCountersListViewModelSuccess?.counters.last?.title, "test3", "presentMovements should change the value to the correct format")
    }

    func testPresentError() {
       // Given
       // When
       sut.presentConnectionError()
       // Then
       XCTAssertTrue(spyViewController.displayErrorAlertCalled, "presentSomething(response:) should ask the view controller to display the result")
  }
}

