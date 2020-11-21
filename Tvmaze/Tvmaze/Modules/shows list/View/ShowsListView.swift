//
//  ShowsListView.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit

final class ShowsListView: UIViewController, ShowsListViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ShowsListPresenterProtocol?
    private var shows: [ShowViewModel] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.perform(.load)
        title = "ShowsList.Title".localized
        tableViewConfiguration()
    }
    
    // MARK: ShowsListViewProtocol implementation
    func populate(_ state: ShowsListState) {
        switch state {
        case .reload(let shows):
            self.shows = shows
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        case .error(let error):
            DispatchQueue.main.async {
                let alert = UIAlertController(title: nil, message: error, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Alert.Button.Refresh".localized, style: UIAlertAction.Style.default, handler: { _ in
                    self.presenter?.perform(.load)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.perform(.reload) 
    }
    
    private func tableViewConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.addSubview(refreshControl)
    }
}

extension ShowsListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let show = shows[indexPath.row]
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        }
        cell.textLabel?.text = show.name
        // TODO: Use SDWebImage to display show.image.medium
        
        return cell ?? UITableViewCell()
    }
}
