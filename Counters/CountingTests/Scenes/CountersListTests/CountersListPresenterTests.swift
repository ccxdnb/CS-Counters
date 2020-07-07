//
//  CountersListPresenterTests.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

import XCTest

class CountersListPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: CountersListPresenter!
    var spyViewController: CountersListDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupCountersListPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupCountersListPresenter() {
        sut = CountersListPresenter()

        spyViewController = CountersListDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

    func testPresentCountersList() {
        // Given
        let testCounters = [
            Counter(id: "id1", title: "test1", count: 1),
            Counter(id: "id2", title: "test2", count: 2),
            Counter(id: "id3", title: "test3", count: 3)
        ]
        let response = CountersList.Counters.Response(counters: testCounters)
        // When
        sut.presentCounterList(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayCountingListCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayCountingListViewModel?.counters.first?.id, "id1", "presentMovements should change the value to the correct format")
    }

    func testPresentDeletedCounter() {
        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.DeleteCounter.Response(counter: testCounter)
        // When
        sut.presentDeletedCounter(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayDeleteCounterCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayDeleteCounterViewModel?.counter.id, "id1", "presentMovements should change the value to the correct format")
    }

    func testPresentEmtpyCounterList() {
        // Given
        // When
        sut.presentEmptyCountingList()
        // Then
        XCTAssertTrue(spyViewController.displayPlaceHolderViewCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayPlaceHolderViewViewModel?.title, "NO_COUNTERS_PH_TITLE".localized, "presentMovements should change the value to the correct format")
    }

    func testPresentNoInternetList() {
        // Given
        // When
        sut.presentNoInternetList()
        // Then
        XCTAssertTrue(spyViewController.displayPlaceHolderViewCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayPlaceHolderViewViewModel?.title, "NO_INTERNET_PH_TITLE".localized, "presentMovements should change the value to the correct format")
    }

    func testPresentDeleteError() {

        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.DeleteCounter.Response(counter: testCounter)
        // When
        sut.presentDeleteError(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayDeleteErrorAlertCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayDeleteErrorAlertViewModel?.title, "DELETECOUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title), "presentMovements should change the value to the correct format")
    }

    func testPresentUpdatedCounter() {
        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.UpdateCounter.Response(counter: testCounter)
        // When
        sut.presentUpdatedCounter(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayUpdateCounterCalled, "presentSomething(response:) should ask the view controller to display the result")
        XCTAssertEqual(spyViewController.displayUpdateCounterViewModel?.counter.id, "id1", "presentMovements should change the value to the correct format")
    }

    func testPresentUpdateErrorIncrease() {

        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.UpdateCounter.Response(counter: testCounter, type: .increase)
        // When
        sut.presentUpdateError(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displayUpdateErrorAlertCalled,
            "presentSomething(response:) should ask the view controller to display the result"
        )
        XCTAssertEqual(
            spyViewController.displayUpdateErrorAlertViewModel?.title,
            "UPDATE_COUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title, response.counter.count + 1),
            "presentMovements should change the value to the correct format"
        )
    }

    func testPresentUpdateErrorDecrease() {

        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.UpdateCounter.Response(counter: testCounter, type: .decrease)
        // When
        sut.presentUpdateError(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displayUpdateErrorAlertCalled,
            "presentSomething(response:) should ask the view controller to display the result"
        )
        XCTAssertEqual(
            spyViewController.displayUpdateErrorAlertViewModel?.title,
            "UPDATE_COUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title, response.counter.count - 1),
            "presentMovements should change the value to the correct format"
        )
    }


}
