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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.addSubview(refreshControl)
    }
    
    private func setupCellUI(_ cell: UITableViewCell, show: ShowViewModel) {
        cell.textLabel?.text = show.name
        if let imageUrl = show.imageUrl {
            cell.imageView?.sd_setImage(with: URL(string: imageUrl),
                                                placeholderImage: UIImage(named: "placeholder"),
                                                options: [.retryFailed]) { (_, _, _, _) in
                cell.imageView?.contentMode = .scaleAspectFill
                cell.setNeedsLayout()
            }
        } else {
            cell.imageView?.image = UIImage(named: "placeholder")
            cell.imageView?.contentMode = .scaleAspectFill
        }
    }
}

extension ShowsListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // TODO: If custom cell uncomment
        //if cell == nil {
        //    cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        //}
        
        setupCellUI(cell, show: shows[indexPath.row])
        
        // TODO: Improve pagination
        if (indexPath.row == shows.count - 20) {
            presenter?.perform(.fetchData)
        }
        
        return cell // TODO: if custom cell add: ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.perform(.detail(index: indexPath.row))
    }
}
