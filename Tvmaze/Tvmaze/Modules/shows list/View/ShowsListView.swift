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
            showError(error)
        }
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        presenter?.perform(.reload) 
    }
    
    private func tableViewConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.addSubview(refreshControl)
    }
}

extension ShowsListView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let show = shows[indexPath.row]
        
        // TODO: If custom cell uncomment
        //if cell == nil {
        //    cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        //}
        
        cell.textLabel?.text = show.name
        // TODO: Use SDWebImage to display show.image.medium
        
        return cell // TODO: if custom cell add: ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.perform(.detail(index: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        <#code#>
    }
}
