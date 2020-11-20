//
//  ShowDetailPresenterProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowDetailViewAction {
    case load
}

protocol ShowDetailPresenterProtocol {
    var view: ShowDetailViewProtocol? { get set }
    var interactor: ShowDetailInteractorInputProtocol? { get set }
    var wireframe: ShowDetailWireframeProtocol? { get set }
    func perform(_ action: ShowDetailViewAction)
}
