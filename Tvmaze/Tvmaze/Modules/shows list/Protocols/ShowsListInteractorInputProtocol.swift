//
//  ShowsListInteractorInputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowsListJob {
    case requestTvShows
}

protocol ShowsListInteractorInputProtocol {
    var presenter: ShowsListInteractorOutputProtocol? { get set }
    var repository: ShowsListRepositoryProtocol? { get set }
    var currentPage: Int { get set }
    func `do`(_ job: ShowsListJob)
}