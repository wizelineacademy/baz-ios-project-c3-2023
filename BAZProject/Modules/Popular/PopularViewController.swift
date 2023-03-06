//
//  PopularViewController.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class PopularViewController: UITableViewController {
    
    //MARK: Properties
    var presenter: PopularPresenterProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.notifyViewLoaded()
    }
}

//MARK: PopularViewProtocol
extension PopularViewController: PopularViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: UITableViewDelegate
extension PopularViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.movies?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell") else { return UITableViewCell() }
        return tableViewCell
    }
}

//MARK: UITableViewDataSource
extension PopularViewController {
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
