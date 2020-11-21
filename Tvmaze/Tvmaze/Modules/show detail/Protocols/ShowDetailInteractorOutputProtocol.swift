//
//  ShowDetailInteractorOutputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowDetailIteractorResult {
    case showDetail(DetailViewModel)
}

protocol ShowDetailInteractorOutputProtocol: class {
    func handle(_ result: ShowDetailIteractorResult)
}
