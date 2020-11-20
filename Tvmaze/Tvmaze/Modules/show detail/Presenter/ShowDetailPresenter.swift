//
//  ShowDetailPresenter.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowDetailPresenter: ShowDetailPresenterProtocol, ShowDetailInteractorOutputProtocol {

    weak var view: ShowDetailViewProtocol?
    var interactor: ShowDetailInteractorInputProtocol?
    var wireframe: ShowDetailWireframeProtocol?
    
    // MARK: Implement ShowDetailPresenterProtocol
    func perform(_ action: ShowDetailViewAction) {
        switch action {
        case .load:
            interactor?.do(.requestShowDetail)
        }
    }
    
    // MARK: Implement ShowDetailInteractorOutputProtocol
    func handle(_ result: ShowDetailIteractorResult) {
        switch result {
        case .showDetailSucceed:
            view?.populate(.load)
        case .showDetailFailed(let error):
            view?.populate(.error(error.localizedDescription))
        }
    }
}
