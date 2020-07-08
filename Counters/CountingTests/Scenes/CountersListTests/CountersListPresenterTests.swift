//
//  CountersListPresenterTests.swift
//  Counters
//
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
        XCTAssertTrue(spyViewController.displayCountingListCalled)
        XCTAssertEqual(spyViewController.displayCountingListViewModel?.counters.first?.id, "id1")
    }

    func testPresentDeletedCounter() {
        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.DeleteCounter.Response(counter: testCounter)
        // When
        sut.presentDeletedCounter(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayDeleteCounterCalled)
        XCTAssertEqual(spyViewController.displayDeleteCounterViewModel?.counter.id, "id1")
    }

    func testPresentEmtpyCounterList() {
        // Given
        // When
        sut.presentEmptyCountingList()
        // Then
        XCTAssertTrue(spyViewController.displayPlaceHolderViewCalled)
        XCTAssertEqual(spyViewController.displayPlaceHolderViewViewModel?.title, "NO_COUNTERS_PH_TITLE".localized)
    }

    func testPresentNoInternetList() {
        // Given
        // When
        sut.presentNoInternetList()
        // Then
        XCTAssertTrue(spyViewController.displayPlaceHolderViewCalled)
        XCTAssertEqual(spyViewController.displayPlaceHolderViewViewModel?.title, "NO_INTERNET_PH_TITLE".localized)
    }

    func testPresentDeleteError() {

        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.DeleteCounter.Response(counter: testCounter)
        // When
        sut.presentDeleteError(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayDeleteErrorAlertCalled)
        XCTAssertEqual(spyViewController.displayDeleteErrorAlertViewModel?.title,
                       "DELETECOUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title)
        )
    }

    func testPresentUpdatedCounter() {
        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.UpdateCounter.Response(counter: testCounter)
        // When
        sut.presentUpdatedCounter(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayUpdateCounterCalled)
        XCTAssertEqual(spyViewController.displayUpdateCounterViewModel?.counter.id, "id1")
    }

    func testPresentUpdateErrorIncrease() {

        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.UpdateCounter.Response(counter: testCounter, type: .increase)
        // When
        sut.presentUpdateError(response: response)
        // Then
        XCTAssertTrue(
            spyViewController.displayUpdateErrorAlertCalled)
        XCTAssertEqual(
            spyViewController.displayUpdateErrorAlertViewModel?.title,
            "UPDATE_COUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title, response.counter.count + 1)
        )
    }

    func testPresentUpdateErrorDecrease() {

        // Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)

        let response = CountersList.UpdateCounter.Response(counter: testCounter, type: .decrease)
        // When
        sut.presentUpdateError(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayUpdateErrorAlertCalled)
        XCTAssertEqual(
            spyViewController.displayUpdateErrorAlertViewModel?.title,
            "UPDATE_COUNTER_ERROR_ALERT_TITLE".localized(with: response.counter.title, response.counter.count - 1)
        )
    }


}
