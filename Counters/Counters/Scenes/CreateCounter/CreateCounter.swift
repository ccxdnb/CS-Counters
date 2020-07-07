//
//  CreateCounterModels.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

// swiftlint:disable nesting
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

// swiftlint:enable nesting