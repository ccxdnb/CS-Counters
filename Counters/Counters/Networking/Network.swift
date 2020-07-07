//
//  API.swift
//  Counters
//
//
import Foundation

/// A dictionary of parameters to apply to a `URLRequest`.
public typealias Parameters = [String: Any]

/// A successfull clousure type on request completion
public typealias SuccessCallBack = (Decodable, Int) -> Void

/// A failure clousure type on request completion
public typealias ErrorCallBack = (Error?, Int) -> Void


enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

internal enum HTTPStatusCodes: Int {
    // 200 Success
    case okStatus = 200
    // 400 Client Error
    case badRequest = 400
    case notFound = 404
    case misdirectedRequest = 421
    // 500 Server Error
    case internalServerError = 500
    case notExtended = 510
    // offline
    case networkConnectionOffline = -1
}

final class Network  {

    private let session = URLSession.shared

    public func request<T: Encodable, R: Decodable>(
        urlString: String,
        method: HTTPMethod,
        parameters: T?,
        responseType: R.Type,
        onSuccess: @escaping (R, Int) -> Void,
        onFailure: @escaping (Error?, Int) -> Void)
    {

        guard let url = URL(string: urlString) else { fatalError() }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalCacheData

        var task: URLSessionDataTask?

        switch method {
        case .GET:
             task = session.dataTask(with: request) { data, response, error in

                if let err = error as NSError? {
                    DispatchQueue.main.sync {
                        onFailure(err, err.code)
                    }
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else { fatalError() }

                if httpResponse.statusCode == HTTPStatusCodes.okStatus.rawValue {
                    do {
                        guard let dataObject = data else {
                            throw NSError(domain: "empty.data", code: httpResponse.statusCode, userInfo: nil)
                        }

                        let responseObject = try JSONDecoder().decode(responseType, from: dataObject)
                        DispatchQueue.main.sync {
                            onSuccess(responseObject, httpResponse.statusCode)
                        }
                    }
                    catch let error as NSError {
                        DispatchQueue.main.sync {
                            onFailure(error, httpResponse.statusCode)
                        }
                    }

                } else if httpResponse.statusCode == HTTPStatusCodes.badRequest.rawValue ||
                            httpResponse.statusCode == HTTPStatusCodes.notFound.rawValue ||
                            httpResponse.statusCode == HTTPStatusCodes.networkConnectionOffline.rawValue {
                    DispatchQueue.main.sync {
                        onFailure(error,  httpResponse.statusCode)
                    }
                } else if (httpResponse.statusCode < 600 && httpResponse.statusCode >= 500) {
                    let error = NSError(domain: "server.error", code: httpResponse.statusCode, userInfo: nil)
                    DispatchQueue.main.sync {
                        onFailure(error,  httpResponse.statusCode)
                    }
                }
            }
        case .POST, .PUT, .DELETE:
            let jsonData: Data?
            
            do {
                jsonData = try JSONEncoder().encode(parameters)
            } catch {
                fatalError("This should be possible")
            }

             task = session.uploadTask(with: request, from: jsonData) { data, response, error in
                if let err = error as NSError? {
                    DispatchQueue.main.sync {
                        onFailure(err, err.code)
                    }
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else { fatalError() }

                if httpResponse.statusCode == HTTPStatusCodes.okStatus.rawValue {
                    do {
                        guard let dataObject = data else {
                            throw NSError(domain: "empty.data", code: httpResponse.statusCode, userInfo: nil)
                        }

                        let responseObject = try JSONDecoder().decode(responseType, from: dataObject)
                        DispatchQueue.main.sync {
                            onSuccess(responseObject, httpResponse.statusCode)
                        }
                    }
                    catch let error as NSError {
                        DispatchQueue.main.sync {
                            onFailure(error, httpResponse.statusCode)
                        }
                    }

                } else if httpResponse.statusCode == HTTPStatusCodes.badRequest.rawValue ||
                            httpResponse.statusCode == HTTPStatusCodes.notFound.rawValue ||
                            httpResponse.statusCode == HTTPStatusCodes.networkConnectionOffline.rawValue {
                    DispatchQueue.main.sync {
                        onFailure(error,  httpResponse.statusCode)
                    }
                }
            }
        }

        task?.resume()
    }

}
