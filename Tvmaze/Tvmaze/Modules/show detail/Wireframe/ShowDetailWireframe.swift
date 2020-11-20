//
//  ShowDetailWireframe.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

final class ShowDetailWireframe: ShowDetailWireframeProtocol {

    var view: UIViewController?
    
    static func createModule() -> UIViewController {
        let viewController = ShowDetailView()
        
        let wireframe = ShowDetailWireframe()
        let presenter = ShowDetailPresenter()
        let interactor = ShowDetailInteractor()
        let repository = ShowDetailRepository()
        
        wireframe.view = viewController
        presenter.view = viewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.repository = repository
        
        return viewController
    }
}
