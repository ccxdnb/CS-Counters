//
//  CreateCounterInteractor.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

import Foundation

protocol CreateCounterBusinessLogic {
    func createCounter(request: CreateCounter.NewCounter.Request)
}

protocol CreateCounterDataStore {
    //var name: String { get set }
}

class CreateCounterInteractor: CreateCounterBusinessLogic, CreateCounterDataStore {
    var presenter: CreateCounterPresentationLogic?
    // var name: String = ""

    let api: APICountersService?

    init(api: APICountersService = APICounters()) {
        self.api = api
    }
    // MARK: Methods

    func createCounter(request: CreateCounter.NewCounter.Request) {
        api?.createCounter(
            request: request, onSuccess: { response, code in
                self.presenter?.presentCounterList(response: .init(counters: response))
            }, onError: { error, status in
                self.presenter?.presentConnectionError()
            }
        )
    }
}
