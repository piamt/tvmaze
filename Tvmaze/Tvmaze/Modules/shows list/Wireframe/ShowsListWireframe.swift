//
//  ShowsListWireframe.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

final class ShowsListWireframe: ShowsListWireframeProtocol {
    var view: UIViewController?
    
    static func createModule() -> UIViewController {
        let viewController = ShowsListView()
        let navigation = UINavigationController(rootViewController: viewController)
        
        let wireframe = ShowsListWireframe()
        let presenter = ShowsListPresenter()
        let interactor = ShowsListInteractor()
        let repository = ShowsListRepository()
        
        wireframe.view = viewController
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.repository = repository
        
        return navigation
    }
    
    func navigate(to page: ShowsListPage) {
        switch page {
        case .showDetail:
            let detailView = ShowDetailWireframe.createModule()
            view?.navigationController?.pushViewController(detailView, animated: true)
        }
    }
}
