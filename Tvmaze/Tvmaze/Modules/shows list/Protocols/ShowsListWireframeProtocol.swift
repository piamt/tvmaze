//
//  ShowsListWireframeProtocol.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

enum ShowsListPage {
    case showDetail
}

protocol ShowsListWireframeProtocol {
    var view: UIViewController? { get set }
    func navigate(to page: ShowsListPage)
}
