//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

final class MovieDetailView: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var playVideo: UIButton!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(poster: &poster, tableView: tableView)
        getDelegates()
        setupUI()
        playVideo.setTitle("", for: .normal)
    }
    
    private func setupUI() {
        closeView.makeRound(divide: 2)
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
