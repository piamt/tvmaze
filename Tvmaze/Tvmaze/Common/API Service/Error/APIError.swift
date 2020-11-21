//
//  APIError.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum APIError { }

extension APIError {
    enum General: String, CaseIterable, APIErrorProtocol {
        case unknownException = "APIError.UnknownException"
        case parsing = "APIError.Parsing"
    }
}
