//
//  APICountersSpy.swift
//  CountersTests
//
//  Created by nisum on 07-07-20.
//

import Foundation

class APICountersSpy: APICountersService { //this should be changed for stubs implementation

    var isError = false

    var testCounters = [
        Counter(id: "id1", title: "test1", count: 1),
        Counter(id: "id2", title: "test2", count: 2),
        Counter(id: "id3", title: "test3", count: 3)
    ]

    func getCounters(onSuccess: @escaping ([Counter], Int) -> Void, onError: @escaping (ErrorCallBack)) {
        if isError {
            onError(NSError(), -1)
            return
        }
        onSuccess(testCounters, 200)
    }

    func createCounter(request: CreateCounter.NewCounter.Request, onSuccess: @escaping ([Counter], Int) -> Void, onError: @escaping (ErrorCallBack)) {
        if isError {
            onError(NSError(), -1)
            return
        }
        onSuccess(testCounters, 200)

    }

    func deleteCounter(request: CountersList.DeleteCounter.Request, onSuccess: @escaping ([Counter], Int) -> Void, onError: @escaping (ErrorCallBack)) {
        if isError {
            onError(NSError(), -1)
            return
        }
        onSuccess(testCounters, 200)

    }

    func increaseCounter(request: CountersList.IncreaseCounter.Request, onSuccess: @escaping ([Counter], Int) -> Void, onError: @escaping (ErrorCallBack)) {
        if isError {
            onError(NSError(), -1)
            return
        }
        onSuccess(testCounters, 200)

    }

    func decreaseCounter(request: CountersList.DecreaseCounter.Request, onSuccess: @escaping ([Counter], Int) -> Void, onError: @escaping (ErrorCallBack)) {
        if isError {
            onError(NSError(), -1)
            return
        }
        onSuccess(testCounters, 200)

    }


}
