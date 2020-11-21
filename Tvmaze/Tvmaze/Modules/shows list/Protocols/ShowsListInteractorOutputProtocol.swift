//
//  ShowsListInteractorOutputProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import Foundation

enum ShowsListIteractorResult {
    case tvShowsSucceed([ShowViewModel])
    case tvShowsFailed(ErrorModel)
}

protocol ShowsListInteractorOutputProtocol: class {
    func handle(_ result: ShowsListIteractorResult)
}
