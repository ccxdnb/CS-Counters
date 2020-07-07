//
//  CountingListInteractor.swift
//  Counting
//
//

protocol CountersListBusinessLogic {
    func doCountersList()
    func doDelete(counters: [Counter])
    func doIncrease(counter: Counter)
    func doDecrease(counter: Counter)
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

    func doCountersList() {
        api?.getCounters(onSuccess: { response , code in
            if response.isEmpty {
                self.presenter?.presentEmptyCountingList()
                return
            }
            self.presenter?.presentCounterList(response: .init(counters: response))
        }, onError: { error , code in
            self.presenter?.presentNoInternetList()
        })
    }

    func doDelete(counters: [Counter]) {
        counters.forEach { counter in
            api?.deleteCounter(
                request: .init(id: counter.id),
                onSuccess: { (response, code) in
                     self.presenter?.presentDeletedCounter(response: .init(counter: counter))
                },
                onError: { (error, code) in
                    self.presenter?.presentDeleteError(response: .init(counter: counter))
                }
            )
        }
    }

    func doIncrease(counter: Counter) {
        api?.increaseCounter(
            request: .init(id: counter.id),
            onSuccess: { (response, code) in
                guard let newCounter = response.first(where: { $0.id == counter.id }) else {
                    debugPrint("this should be possible")
                    self.presenter?.presentUpdateError(response: .init(counter: counter, type: .increase))
                    return
                }
                self.presenter?.presentUpdatedCounter(response: .init(counter: newCounter))
            },
            onError: { (error, code) in
                self.presenter?.presentUpdateError(response: .init(counter: counter, type: .increase))
            }
        )
    }

    func doDecrease(counter: Counter) {
        api?.decreaseCounter(
            request: .init(id: counter.id),
            onSuccess: { (response, code) in
                guard let newCounter = response.first(where: { $0.id == counter.id }) else {
                    debugPrint("this should be possible")
                    self.presenter?.presentUpdateError(response: .init(counter: counter, type: .decrease))
                    return
                }
                self.presenter?.presentUpdatedCounter(response: .init(counter: newCounter))
            },
            onError: { (error, code) in
                self.presenter?.presentUpdateError(response: .init(counter: counter, type: .decrease))
            }
        )
    }
}
