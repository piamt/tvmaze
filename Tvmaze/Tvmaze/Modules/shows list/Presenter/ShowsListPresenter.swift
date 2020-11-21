//
//  ShowsListPresenter.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

class ShowsListPresenter: ShowsListPresenterProtocol, ShowsListInteractorOutputProtocol {
    
    weak var view: ShowsListViewProtocol?
    var interactor: ShowsListInteractorInputProtocol?
    var wireframe: ShowsListWireframeProtocol?
    
    // MARK: Implement ShowsListPresenterProtocol
    func perform(_ action: ShowsListViewAction) {
        switch action {
        case .load:
            interactor?.do(.requestTvShows)
        case .reload:
            interactor?.currentPage = 0
            interactor?.do(.requestTvShows)
        }
    }
    
    // MARK: Implement ShowsListInteractorOutputProtocol
    func handle(_ result: ShowsListIteractorResult) {
        switch result {
        case .tvShowsSucceed(let arrayViewModel):
            view?.populate(.reload(arrayViewModel))
        case .tvShowsFailed(let error):
            view?.populate(.error(error.value.string.localized))
        }
    }
}
