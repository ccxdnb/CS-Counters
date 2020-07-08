//
//  CreateCounterModels.swift
//  Counters
//
//

enum CreateCounter {

    enum NewCounter {
        struct Request: Encodable {
            var title: String
        }
        enum Response {
            struct Success {
                var counters: [Counter]
            }
            struct Failure {
            }
        }
        enum DeleteCounter {
            struct Request: Encodable {
                var id: String
            }
            enum Response {
                struct Success {
                    var counters: [Counter]
                }
                struct Failure {
                }
            }
        }
        enum ViewModel {
            struct Success {
                var counters: [Counter]
            }
            struct Failure {
                var title: String
                var message: String
                var buttonTitle: String
            }
        }
        enum Error {
            struct Success {
            }
            struct Failure {
            }
        }
    }
}
