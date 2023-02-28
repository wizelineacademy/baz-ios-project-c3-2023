//
//  FavoriteMovieView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class FavoriteMovieView: UIViewController {
    var presenter: FavoriteMoviePresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tus Favoritos"
        presenter?.viewDidLoad(tableView: tableView)
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavoriteMovies()
    }
    
    func setupUI() {
        tableView.delegate = presenter?.getTableViewDelegate()
        tableView.dataSource = presenter?.getTableViewDataSource()
    }
}

extension FavoriteMovieView: FavoriteMovieViewProtocol {
    
    
    func reloadData(){
        tableView.reloadData()
    }
}
