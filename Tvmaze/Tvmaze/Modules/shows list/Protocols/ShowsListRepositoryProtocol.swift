//
//  ShowsListRepositoryProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

typealias ShowsListResultBlock = (Result<[ShowEntity], ErrorModel>) -> Void

protocol ShowsListRepositoryProtocol: class {
    func tvShows(page: Int, resultBlock: @escaping ShowsListResultBlock)
}
