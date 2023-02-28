//
//  WatchedMovieViewController.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class WatchedMovieViewController: UIViewController, WatchedMovieViewProtocols {
    @IBOutlet weak var tableView: UITableView!
    var presenter: WatchedMoviePresenterProtocols?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Vistas"
        presenter?.viewDidLoad(tableView: tableView)
        setupUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getWatchedMovies()
    }
    
    func setupUI() {
        tableView.delegate = presenter?.getTableViewDelegate()
        tableView.dataSource = presenter?.getTableViewDataSource()
    }
    
    func reloadData(){
        tableView.reloadData()
    }
}
