//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailView: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overviewTextView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeView: UIView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var featuresMovie: UILabel!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(textOverview: &overviewTextView, poster:  &poster)
        if let data = presenter?.interactor?.data {
            featuresMovie.text = "\(data.releaseDate)  *  \(data.voteCount) votes"
        }
        
        getDelegates()
        
        closeView.layer.cornerRadius = closeView.frame.size.width/2
        closeView.clipsToBounds = true

        
        posterView.layer.cornerRadius = posterView.frame.size.width/100
        posterView.clipsToBounds = true

        
        favoriteView.layer.cornerRadius = favoriteView.frame.size.width/2
        favoriteView.clipsToBounds = true
        
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
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
