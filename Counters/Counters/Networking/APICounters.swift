//
//  APICounters.swift
//  Counters
//
//

import Foundation

public class APICounters: APICountersService {

    func createCounter(
        request: CreateCounter.NewCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    ) {
        Network().request(
            urlString: APIConstants.counterBaseURL,
            method: .POST,
            parameters: request,
            responseType: [Counter].self,
            onSuccess: onSuccess,
            onFailure: onError)
    }

    func getCounters(
        onSuccess: @escaping([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    ) {
        Network().request(
            urlString: APIConstants.countersBaseURL,
            method: .GET,
            parameters: nil as Counter?,
            responseType: [Counter].self,
            onSuccess: onSuccess,
            onFailure: onError)
    }

    func deleteCounter(
        request: CountersList.DeleteCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    ) {
        Network().request(
            urlString: APIConstants.counterBaseURL,
            method: .DELETE,
            parameters: request,
            responseType: [Counter].self,
            onSuccess: onSuccess,
            onFailure: onError)
    }

    func increaseCounter(
        request: CountersList.IncreaseCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    ) {
        Network().request(
            urlString: APIConstants.increaseCounterURL,
            method: .POST,
            parameters: request,
            responseType: [Counter].self,
            onSuccess: onSuccess,
            onFailure: onError)
    }

    func decreaseCounter(
        request: CountersList.DecreaseCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    ) {
        Network().request(
            urlString: APIConstants.decreaseCounterURL,
            method: .POST,
            parameters: request,
            responseType: [Counter].self,
            onSuccess: onSuccess,
            onFailure: onError)
    }
}
