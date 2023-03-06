//
//  NowPlayingViewController.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class NowPlayingViewController: UITableViewController {
    
    //MARK: Properties
    var presenter: NowPlayingPresenterProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.notifyViewLoaded()
    }
}

//MARK: NowPlayingViewProtocol
extension NowPlayingViewController: NowPlayingViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: UITableViewDelegate
extension NowPlayingViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.movies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingTableViewCell") else { return UITableViewCell() }
        return tableViewCell
    }
}

//MARK: UITableViewDataSource
extension NowPlayingViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = self.presenter?.movies?[indexPath.row].title
        self.presenter?.movies?[indexPath.row].getImage(completion: { image in
            DispatchQueue.main.async {
                config.image = image
                cell.contentConfiguration = config
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.goToMovieDetail(of: indexPath,from: self)
    }
}
