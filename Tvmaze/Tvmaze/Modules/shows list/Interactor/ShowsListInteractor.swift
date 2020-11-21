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
    
    private var currentPage: Int = 0
    private var availablePages: Bool = true
    private var fetchInProgress: Bool = false
    private var showsArray: [ShowEntity] = []
    
    var isLastPage: Bool {
        return !availablePages
    }
    
    func showEntityForIndex(_ index: Int) -> ShowEntity {
        showsArray[index]
    }
    
    func `do`(_ job: ShowsListJob) {
        switch job {
        case .reloadTvShows:
            availablePages = true
            currentPage = 0
            requestTvShows()
        case .requestTvShows:
            requestTvShows()
        }
    }
    
    private func requestTvShows() {
        guard availablePages == true, fetchInProgress == false else { return }
        fetchInProgress = true
        repository?.tvShows(page: currentPage + 1) { result in
            switch result {
            case .success(let array):
                guard array.count > 0 else {
                    self.availablePages = false
                    return
                }
                self.currentPage += 1
                self.showsArray.append(contentsOf: array)
                self.presenter?.handle(.tvShowsSucceeded(self.showsArray.compactMap({ ShowViewModel(entity: $0) })))
                self.fetchInProgress = false
            case .failure(let error):
                self.presenter?.handle(.tvShowsFailed(error))
                self.fetchInProgress = false
            }
        }
    }
}
