//
//  ShowsListInteractorInputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowsListJob {
    case reloadTvShows
    case requestTvShows
}

protocol ShowsListInteractorInputProtocol {
    var presenter: ShowsListInteractorOutputProtocol? { get set }
    var repository: ShowsListRepositoryProtocol? { get set }
    var isLastPage: Bool { get }
    func showEntityForIndex(_ index: Int) -> ShowEntity
    func `do`(_ job: ShowsListJob)
}
