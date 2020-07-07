//
//  APIConstants.swift
//  Counters
//
//

import Foundation

enum APIConstants {
    private static var baseURL = "http://"
    private static var host = "localhost:3000"
    private static var version = "/api/v1"
    private static var counters = "/counters"
    private static var counter = "/counter"
    private static var increment = "/inc"
    private static var decrement = "/dec"

    static var countersBaseURL: String {
        return baseURL + host + version + counters
    }

    static var counterBaseURL: String {
        return baseURL + host + version + counter
    }

    static var increaseCounterURL: String {
        return counterBaseURL + increment
    }

    static var decreaseCounterURL: String {
        return counterBaseURL + decrement
    }
}
