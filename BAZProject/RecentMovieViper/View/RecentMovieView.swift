//
//  RecentMovieView.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//  
//

import UIKit

class RecentMovieView: UIViewController {

    // MARK: Properties
    @IBOutlet weak var recentMoviesTableView: UITableView!
    
    var presenter: RecentMoviePresenterProtocol?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        self.recentMoviesTableView.delegate = self
        self.recentMoviesTableView.dataSource = self
        self.recentMoviesTableView.register(UINib(nibName: "RecentTableViewCell", bundle: Bundle(for: RecentMovieView.self)), forCellReuseIdentifier: "RecentTableViewCell")
    }
}

extension RecentMovieView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getRecentCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        presenter?.getCell(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension RecentMovieView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.didSelectTable(index: indexPath.row)
    }
}

extension RecentMovieView: RecentMovieViewProtocol {
    func reloadView() {
        self.recentMoviesTableView.reloadData()
    }
}
