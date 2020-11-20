//
//  ShowsListInteractorOutputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowsListIteractorResult {
    case tvShowsSucceed
    case tvShowsFailed(Error)
}

protocol ShowsListInteractorOutputProtocol: class {
    func handle(_ result: ShowsListIteractorResult)
}
