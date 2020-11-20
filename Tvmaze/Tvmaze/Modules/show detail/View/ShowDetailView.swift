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
        case .load:
            break // TODO: load table
        case .error(let error):
            print(error) // TODO: show error
        }
    }
}
