//
//  ShowsListRepository.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowsListRepository: ShowsListRepositoryProtocol {
    
    private var apiDataManager: ShowsListAPIDataManagerProtocol
    private var localDataManager: ShowsListLocalDataManagerProtocol
    
    init(apiDataManager: ShowsListAPIDataManagerProtocol, localDataManager: ShowsListLocalDataManagerProtocol) {
        self.apiDataManager = apiDataManager
        self.localDataManager = localDataManager
    }
    
    func tvShows(page: Int, resultBlock: @escaping ShowsListResultBlock) {
        apiDataManager.tvShows(page: page) { result in 
            switch result {
            case .success(let data):
                guard let array = try? JSONDecoder().decode([ShowEntity].self, from: data) else {
                    resultBlock(.failure(ErrorModel(APIError.General.parsing)))
                    return
                }
                resultBlock(.success(array))
            case .failure(let error):
                resultBlock(.failure(error))
            }
        }
    }
}
