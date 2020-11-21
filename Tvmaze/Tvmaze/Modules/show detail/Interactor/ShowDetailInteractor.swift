//
//  ShowDetailInteractor.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowDetailInteractor: ShowDetailInteractorInputProtocol {
    weak var presenter: ShowDetailInteractorOutputProtocol?
    var entity: ShowEntity
    
    init(entity: ShowEntity) {
        self.entity = entity
    }
    
    func `do`(_ job: ShowDetailJob) {
        switch job {
        case .requestShowDetail:
            presenter?.handle(.showDetail(DetailViewModel(entity: entity)))
        }
    }
}
