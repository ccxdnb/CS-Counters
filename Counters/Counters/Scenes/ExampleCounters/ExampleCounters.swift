//
//  ExampleCountersModels.swift
//  Counters
//
//  Copyright © 2019 Banco de Crédito e Inversiones. All rights reserved.
//

// swiftlint:disable nesting
enum ExampleCounters {

    enum Examples {
        struct Request {
        }
        enum Response {
            struct Success {
                var examples: [String: [String]]
            }
            struct Failure {
            }
        }
        enum ViewModel {
            struct Success {
                var examples: [String: [String]]
            }
            struct Failure {
            }
        }
    }
}

// swiftlint:enable nesting
