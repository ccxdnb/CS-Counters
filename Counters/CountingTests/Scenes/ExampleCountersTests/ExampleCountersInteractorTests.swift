//
//  ExampleCountersInteractorTests.swift
//  Counters
//
//

import XCTest

class ExampleCountersInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: ExampleCountersInteractor!
    var spyPresenter: ExampleCountersPresentationLogicSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupExampleCountersInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        sut = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupExampleCountersInteractor() {
        sut = ExampleCountersInteractor()

        spyPresenter = ExampleCountersPresentationLogicSpy()
        sut.presenter = spyPresenter
    }

    // MARK: Tests

     func testDoSomething() {
        // Given
        let request = ExampleCounters.Examples.Request()
        // When
        sut.doExamples(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentExamplesCalled, "doSomething(request:) should ask the presenter to format the result")

        //TODO: Update with stubs
//        XCTAssertEqual(spyPresenter.presentExamplesResponse?.examples.first?.key, "FOOD" )
    }

}

// swiftlint:enable line_length
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable identifier_name
// swiftlint:enable force_cast
// swiftlint:enable file_length
// swiftlint:enable superfluous_disable_command
