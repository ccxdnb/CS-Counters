//
//  CountersListInteractorTests.swift
//  Counters
//
//

import XCTest

class CountersListInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: CountersListInteractor!
    var spyPresenter: CountersListPresentationLogicSpy!
    var api: APICountersSpy!


    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupCountersListInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupCountersListInteractor() {
        sut = CountersListInteractor()

        api = APICountersSpy()
        sut.api = api

        spyPresenter = CountersListPresentationLogicSpy()
        sut.presenter = spyPresenter
    }


    // MARK: Tests

    func testDoCountersList() {
        //Given
        //When
        sut.doCountersList()
        //Then
        XCTAssertTrue(spyPresenter.presentCounterListCalled)
    }

    func testDoCountersListError() {
        //Given
        let errorApi = APICountersSpy()
        errorApi.isError = true
        sut.api = errorApi
        //When
        sut.doCountersList()
        //Then
        XCTAssertTrue(spyPresenter.presentNoInternetListCalled)
    }

    func testDoDelete() {
        //Given
        let testCounters = [
            Counter(id: "id1", title: "test1", count: 1)
        ]        //When
        sut.doDelete(counters: testCounters)
        //Then
        XCTAssertTrue(spyPresenter.presentDeletedCounterCalled)
        XCTAssertEqual(spyPresenter.presentDeletedCounterResponse?.counter.title, "test1")
    }

    func testDoDeleteError() {
        //Given
        let errorApi = APICountersSpy()
        errorApi.isError = true
        sut.api = errorApi
        let testCounters = [
            Counter(id: "id1", title: "test1", count: 1)
        ]        //When
        sut.doDelete(counters: testCounters)
        //Then
        XCTAssertTrue(spyPresenter.presentDeleteErrorCalled)
        XCTAssertEqual(spyPresenter.presentDeleteErrorResponse?.counter.title, "test1")
    }

    func testDoIncrease() {
        //Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)
        //When
        sut.doIncrease(counter: testCounter)
        //Then
        XCTAssertTrue(spyPresenter.presentUpdatedCounterCalled)
        XCTAssertEqual(spyPresenter.presentUpdatedCounterResponse?.counter.id, "id1")
    }

    func testDoIncreaseError() {
        //Given
        let errorApi = APICountersSpy()
        errorApi.isError = true
        sut.api = errorApi
        let testCounter = Counter(id: "id1", title: "test1", count: 1)
        //When
        sut.doIncrease(counter: testCounter)
        //Then
        XCTAssertTrue(spyPresenter.presentUpdateErrorCalled)
        XCTAssertEqual(spyPresenter.presentUpdateErrorResponse?.counter.id, "id1")
    }

    func testDoDecrease() {
        //Given
        let testCounter = Counter(id: "id1", title: "test1", count: 1)
        //When
        sut.doDecrease(counter: testCounter)
        //Then
        XCTAssertTrue(spyPresenter.presentUpdatedCounterCalled)
        XCTAssertEqual(spyPresenter.presentUpdatedCounterResponse?.counter.id, "id1")
    }

    func testDoDecreaseError() {
        //Given
        let errorApi = APICountersSpy()
        errorApi.isError = true
        sut.api = errorApi
        let testCounter = Counter(id: "id1", title: "test1", count: 1)
        //When
        sut.doDecrease(counter: testCounter)
        //Then
        XCTAssertTrue(spyPresenter.presentUpdateErrorCalled)
        XCTAssertEqual(spyPresenter.presentUpdateErrorResponse?.counter.id, "id1")
    }
}
