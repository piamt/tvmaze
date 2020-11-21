//
//  EndpointProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum HTTPMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
}

protocol EndpointProtocol {
    var baseUrl: String { get }
    var value: String { get }
    var method: HTTPMethod { get }
}

extension EndpointProtocol {
    var baseUrl: String {
        return APIConstants.baseURL
    }
}

enum Endpoint {}
