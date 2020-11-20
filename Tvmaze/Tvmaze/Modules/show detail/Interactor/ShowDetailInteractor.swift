//
//  ShowDetailInteractor.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowDetailInteractor: ShowDetailInteractorInputProtocol {
    weak var presenter: ShowDetailInteractorOutputProtocol?
    var repository: ShowDetailRepositoryProtocol?
    
    func `do`(_ job: ShowDetailJob) {
        switch job {
        case .requestShowDetail:
            repository?.showDetail()
        }
    }
}
