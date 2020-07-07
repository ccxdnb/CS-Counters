//
//  CreateCounterInteractorTests.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// swiftlint:disable force_cast
// swiftlint:disable identifier_name
// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable line_length

@testable import Counters
import XCTest

class CreateCounterInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: CreateCounterInteractor!
    var spyPresenter: CreateCounterPresentationLogicSpy!
    var api: APICountersSpy!

    // MARK: Test lifecycle

    override  func setUp() {
        super.setUp()
        setupCreateCounterInteractor()
    }

    override  func tearDown() {
        spyPresenter = nil
        sut = nil
        api = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupCreateCounterInteractor() {
        api = APICountersSpy()
        sut = CreateCounterInteractor(api: api)

        spyPresenter = CreateCounterPresentationLogicSpy()
        sut.presenter = spyPresenter

    }

    // MARK: Tests

    func testCreateCounter () {
        // Given
        let request: CreateCounter.NewCounter.Request = .init(title: "testTitle")
        // When
        sut.createCounter(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentCounterListCalled)
    }


    func testCreateCounterError () {
        // Given
        api.isError = true
        let request: CreateCounter.NewCounter.Request = .init(title: "testTitle")
        // When
        sut.createCounter(request: request)
        // Then
        XCTAssertTrue(spyPresenter.presentConnectionErrorCalled)
    }
}
