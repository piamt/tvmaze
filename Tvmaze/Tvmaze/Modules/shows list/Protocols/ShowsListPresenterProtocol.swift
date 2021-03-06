//
//  ShowsListPresenterProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowsListViewAction {
    case fetchData
    case reload
    case detail(index: Int)
}

protocol ShowsListPresenterProtocol {
    var view: ShowsListViewProtocol? { get set }
    var interactor: ShowsListInteractorInputProtocol? { get set }
    var wireframe: ShowsListWireframeProtocol? { get set }
    func perform(_ action: ShowsListViewAction)
}
