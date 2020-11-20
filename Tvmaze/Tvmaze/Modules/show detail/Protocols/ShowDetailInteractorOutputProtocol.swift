//
//  ShowDetailInteractorOutputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowDetailIteractorResult {
    case showDetailSucceed
    case showDetailFailed(Error)
}

protocol ShowDetailInteractorOutputProtocol: class {
    func handle(_ result: ShowDetailIteractorResult)
}
