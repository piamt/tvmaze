//
//  ShowDetailInteractorInputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowDetailJob {
    case requestShowDetail
}

protocol ShowDetailInteractorInputProtocol {
    var presenter: ShowDetailInteractorOutputProtocol? { get set }
    func `do`(_ job: ShowDetailJob)
}
