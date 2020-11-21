//
//  ShowsListAPIDataManagerProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

protocol ShowsListAPIDataManagerProtocol {
    func tvShows(page: Int, resultBlock: @escaping APIServiceResultBlock)
}
