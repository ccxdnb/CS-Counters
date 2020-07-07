//
//  ExampleCountersModels.swift
//  Counters
//
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
