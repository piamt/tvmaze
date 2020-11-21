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
        
        wireframe.view = viewController
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        interactor.repository = ShowsListRepository(apiDataManager: ShowsListAPIDataManager(), localDataManager: ShowsListLocalDataManager())
        
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
