//
//  CountingListModels.swift
//  Counting
//
//
import UIKit

enum CountersList {

    // MARK: - Use cases

    enum Counters {
        struct Request {}
        struct Response {
            let counters: [Counter]
        }
        enum ViewModel {
            struct Success {
                var counters: [Counter]
            }
            struct Failure {
                var title: String
                var message: String
                var primaryButton: String
                var secondaryButton: String?
            }
        }
    }

    enum IncreaseCounter {
        struct Request: Encodable {
            let id: String
        }
        struct Response {
            let counter: Counter
        }
        enum ViewModel {
            struct Success {
                var counter: Counter
            }
            struct Failure {
                var title: String
                var message: String
                var primaryButton: String
                var secondaryButton: String?
            }
        }
    }


    enum DecreaseCounter {
        struct Request: Encodable {
            let id: String
        }
        struct Response {
            let counter: Counter
        }
        enum ViewModel {
            struct Success {
                var counter: Counter
            }
            struct Failure {
                var title: String
                var message: String
                var primaryButton: String
                var secondaryButton: String?
            }
        }
    }

    enum UpdateCounter {
        struct Request: Encodable {
            let id: String
        }
        struct Response {
            let counter: Counter
            var type: failureCallTypes?
        }
        enum ViewModel {
            struct Success {
                var counter: Counter
            }
            struct Failure {
                var counter: Counter?
                var title: String
                var message: String
                var primaryButton: String
                var secondaryButton: String?
                var type: failureCallTypes?
            }
        }
    }

    enum DeleteCounter {
        struct Request: Encodable {
            let id: String
        }
        struct Response {
            let counter: Counter
        }
        enum ViewModel {
            struct Success {
                var counter: Counter
            }
            struct Failure {
                var title: String
                var message: String
                var primaryButton: String
                var secondaryButton: String?
            }
        }
    }

    enum failureCallTypes {
        case increase
        case decrease
    }

    enum PlaceholderContentType {
        case noInternet
        case noCounters
    }


    enum Placeholder {
        struct Request {}
        struct Response {
        }
        struct ViewModel {
            let title: String
            let body: NSAttributedString
            let buttonTitle: String
            let type: PlaceholderContentType
        }
    }
}
