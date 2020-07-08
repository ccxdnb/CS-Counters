//
//  ExampleCountersPresenterTests.swift
//  Counters
//
//

import XCTest

class ExampleCountersPresenterTests: XCTestCase {
    // MARK: Subject under test

    var sut: ExampleCountersPresenter!
    var spyViewController: ExampleCountersDisplayLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupExampleCountersPresenter()
    }

    override  func tearDown() {
        spyViewController = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupExampleCountersPresenter() {
        sut = ExampleCountersPresenter()

        spyViewController = ExampleCountersDisplayLogicSpy()
        sut.viewController = spyViewController
    }

    // MARK: Tests

     func testPresentExamples() {
        // Given
        let testExamples = ["CATEGORY":["VALUE1","VALUE2"]]
        let response = ExampleCounters.Examples.Response.Success(examples: testExamples)
        // When
        sut.presentExamples(response: response)
        // Then
        XCTAssertTrue(spyViewController.displayExamplesCalled)
        XCTAssertEqual(spyViewController.displayExamplesViewModel?.examples.keys.first, "CATEGORY")
    }
}
