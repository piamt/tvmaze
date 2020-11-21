//
//  ShowsListViewProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowsListState {
    case reload([ShowViewModel], isLastPage: Bool)
    case error(String)
}

protocol ShowsListViewProtocol: class {
    var presenter: ShowsListPresenterProtocol? { get set }
    func populate(_ state: ShowsListState)
}
