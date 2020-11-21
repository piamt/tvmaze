//
//  ShowDetailView.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

class ShowDetailView: UIViewController, ShowDetailViewProtocol {
    var presenter: ShowDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.perform(.load)
    }
    
    func populate(_ state: ShowDetailState) {
        switch state {
        case .load(let viewModel):
            title = viewModel.name
            // TODO: load view with image, summary and rating
        case .error(let error):
            showError(error)
        }
    }
}
