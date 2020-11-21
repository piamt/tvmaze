//
//  ShowsListAPIDataManager.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowsListAPIDataManager: ShowsListAPIDataManagerProtocol {
    
    func tvShows(page: Int, resultBlock: @escaping APIServiceResultBlock) {
        APIService.shared.makeAPIRequest(forEndpoint: Endpoint.ShowsEndpoint.showsList(page), resultBlock: resultBlock)
    }
}
