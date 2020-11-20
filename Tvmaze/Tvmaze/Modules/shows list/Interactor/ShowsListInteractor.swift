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
    
    func `do`(_ job: ShowsListJob) {
        switch job {
        case .requestTvShows:
            repository?.tvShows()
        }
    }
    
    
}
