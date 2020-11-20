//
//  ShowDetailViewProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowDetailState {
    case load
    case error(String)
}

protocol ShowDetailViewProtocol: class {
    var presenter: ShowDetailPresenterProtocol? { get set }
    func populate(_ state: ShowDetailState)
}
