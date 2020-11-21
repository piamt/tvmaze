//
//  ShowsListView.swift
//  Tvmaze
//
//  Created by Pia on 20/11/2020.
//

import UIKit
import SDWebImage

final class ShowsListView: UIViewController, ShowsListViewProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var isLastPage: Bool = true
    
    var presenter: ShowsListPresenterProtocol?
    private var shows: [ShowViewModel] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "ShowsList.Title".localized
        tableViewConfiguration()
        presenter?.perform(.reload)
    }
    
    // MARK: ShowsListViewProtocol implementation
    func populate(_ state: ShowsListState) {
        switch state {
        case .reload(let shows, let isLastPage):
            self.isLastPage = isLastPage
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
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ShowTableViewCell", bundle: nil), forCellReuseIdentifier: "ShowCell")
        tableView.addSubview(refreshControl)
    }
}

extension ShowsListView: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count > 0 ? (isLastPage ? shows.count : shows.count + 10) : 0 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as? ShowTableViewCell else {
            return UITableViewCell()
        }
        
        if isLoadingCell(for: indexPath) {
            cell.setup(with: .none)
        } else {
            cell.setup(with: shows[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.perform(.detail(index: indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            presenter?.perform(.fetchData)
        }
    }
    
    private func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= shows.count
    }
}
