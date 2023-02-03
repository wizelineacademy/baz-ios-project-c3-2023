//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingView: UITableViewController {

    
    // MARK: Properties
    var presenter: TrendingPresenterProtocol?
    var movies: [Movie] = []

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }

}

//MARK: TrendingViewProtocols
extension TrendingView: TrendingViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - TableView's DataSource
extension TrendingView {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.movies?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate
extension TrendingView {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = self.presenter?.movies?[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
