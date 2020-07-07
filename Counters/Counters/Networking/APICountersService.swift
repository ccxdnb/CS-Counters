//
//  APICountersService.swift
//  Counters
//
//

protocol APICountersService {

    func getCounters(
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    )

    func createCounter(
        request: CreateCounter.NewCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    )

    func deleteCounter(
        request: CountersList.DeleteCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    )

    func increaseCounter(
        request: CountersList.IncreaseCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    )
    
    func decreaseCounter(
        request: CountersList.DecreaseCounter.Request,
        onSuccess: @escaping ([Counter], Int) -> Void,
        onError: @escaping (ErrorCallBack)
    )

}
