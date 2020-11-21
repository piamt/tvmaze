//
//  APIService.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

typealias APIServiceResultBlock = (Result<Data, ErrorModel>) -> Void

protocol APIServiceProtocol: class {
    func makeAPIRequest(_ endpoint: EndpointProtocol, resultBlock: @escaping APIServiceResultBlock)
}

class APIService {
    static let shared: APIService = APIService()
    var apiService: APIServiceProtocol = APIServiceDefault()
    
    func makeAPIRequest(forEndpoint endpoint: EndpointProtocol, resultBlock: @escaping APIServiceResultBlock) {
        apiService.makeAPIRequest(endpoint, resultBlock: resultBlock)
    }
}

class APIServiceDefault: APIServiceProtocol {
    
    private func createRequest(_ endpoint: EndpointProtocol) -> URLRequest? {
        guard let url = URL(string: "\(endpoint.baseUrl)\(endpoint.value)") else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }

    func makeAPIRequest(_ endpoint: EndpointProtocol, resultBlock: @escaping APIServiceResultBlock) {
        // Create url session
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        dataTask?.cancel()
            
        // Create url request
        guard let urlRequest = createRequest(endpoint) else { return }
            
        // Data task
        dataTask = defaultSession.dataTask(with: urlRequest) {  data, response, error in
            defer {
              dataTask = nil
            }
            
            if let httpResponse = response as? HTTPURLResponse, let data = data {
                switch httpResponse.statusCode {
                case 200 ... 299: // TODO: Check API Specifications
                    resultBlock(.success(data))
                default:
                    // TODO: Check error and data and convert to ErrorModel
                    resultBlock(.failure(ErrorModel(APIError.General.unknownException)))
                }
            } else {
                // TODO: Check error and data and convert to ErrorModel
                resultBlock(.failure(ErrorModel(APIError.General.unknownException)))
            }  
        }
        dataTask?.resume()
    }
}
