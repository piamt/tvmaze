//
//  ShowsListInteractor.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowsListInteractor: ShowsListInteractorInputProtocol {
    weak var presenter: ShowsListInteractorOutputProtocol?
    var repository: ShowsListRepositoryProtocol?
    
    var currentPage: Int = 0
    private var showsArray: [ShowEntity] = []
    
    func showEntityForIndex(_ index: Int) -> ShowEntity {
        showsArray[index]
    }
    
    func `do`(_ job: ShowsListJob) {
        switch job {
        case .requestTvShows:
            repository?.tvShows(page: currentPage + 1) { result in
                switch result {
                case .success(let array):
                    self.currentPage += 1 
                    self.showsArray.append(contentsOf: array)
                    self.presenter?.handle(.tvShowsSucceed(self.showsArray.compactMap({ ShowViewModel(entity: $0) })))
                case .failure(let error):
                    self.presenter?.handle(.tvShowsFailed(error))
                }
            }
        }
    }
    
    
}
