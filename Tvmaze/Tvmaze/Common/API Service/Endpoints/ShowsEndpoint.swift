//
//  ShowsEndpoint.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

extension Endpoint {
    enum ShowsEndpoint: EndpointProtocol {
        case showsList(Int)
        
        var value: String {
            switch self {
            case .showsList(let page):
                return "shows?page=\(page)"
            }
        }
        
        var method: HTTPMethod {
            return .GET
        }
    }
}
