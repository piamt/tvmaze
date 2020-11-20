//
//  ShowsListView.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

final class ShowsListView: UIViewController, ShowsListViewProtocol {
    var presenter: ShowsListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.perform(.load)
        title = "ShowsList.Title".localized
    }
    
    func populate(_ state: ShowsListState) {
        switch state {
        case .load:
            break // TODO: load table
        case .error(let error):
            print(error) // TODO: show error
        }
    }
}
