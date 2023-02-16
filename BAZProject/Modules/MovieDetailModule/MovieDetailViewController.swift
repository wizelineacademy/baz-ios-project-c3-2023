//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailView: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(poster: &poster, tableView: tableView)
        getDelegates()
        setupUI()
    }
    
    private func setupUI(){
        closeView.makeRound(divide: 2)
        posterView.makeRound(divide: 100)
        favoriteView.makeRound(divide: 2)
    }
    
    private func getDelegates() {
        tableView.delegate = presenter?.getTableViewDelegate()
        tableView.dataSource = presenter?.getTableViewDataSource()
    }
    
    @IBAction func closeScreen() {
        dismiss(animated: true)
    }
    
    @IBAction func addFavorite() {
        debugPrint("addFavorite")
        presenter?.saveMovie()
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
