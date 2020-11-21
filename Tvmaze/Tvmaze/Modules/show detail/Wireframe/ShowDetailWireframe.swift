//
//  ShowDetailWireframe.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

final class ShowDetailWireframe: ShowDetailWireframeProtocol {

    var view: UIViewController?
    
    static func createModule(entity: ShowEntity) -> UIViewController {
        let viewController = ShowDetailView()
        
        let wireframe = ShowDetailWireframe()
        let presenter = ShowDetailPresenter()
        let interactor = ShowDetailInteractor(entity: entity)
        
        wireframe.view = viewController
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        interactor.repository = ShowDetailRepository()
        
        return viewController
    }
}
