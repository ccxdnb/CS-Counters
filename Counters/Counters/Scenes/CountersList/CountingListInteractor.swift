//
//  CountingListInteractor.swift
//  Counting
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

protocol CountersListBusinessLogic {
    func doCountingList()
}

protocol CountersListDataStore {

}

class CountersListInteractor: CountersListBusinessLogic, CountersListDataStore {

    // MARK: - Attributes

    var presenter: CountersListPresentationLogic?
    var api: APICountersService?

    // MARK: - CountingListDataStore

    init(api: APICountersService = APICounters()) {
        self.api = api
    }

    // MARK: - CountingListBusinessLogic

    func doCountingList() {
        api?.getCounters(onSuccess: { response , code in
            if response.isEmpty {
                self.presenter?.presentEmptyCountingList()
                return
            }
            self.presenter?.presentCounterList(response: .init(counters: response))
        }, onError: {error , code in
            self.presenter?.presentNoInternetList()
        })
    }

//    func createCounter(counter: Counter) {
//        api?.createCounter(
//            counter: counter, onSuccess: { response, code in
//                self.presenter?.presentCounterList(response: .init(counters: response))
//            }, onError: { error, status in
//
//            })
//    }

}
