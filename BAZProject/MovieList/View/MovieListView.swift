//
//  MovieListView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MovieListView: UIViewController {
    
    var output: MLViewOutputProtocol?
    var tableViewDelegate: MovieListDelegate?
    
    @IBOutlet weak var movieListTbv: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        output?.didLoadView()
    }
    
    private func setupTable() {
        self.movieListTbv.dataSource = tableViewDelegate
        self.movieListTbv.delegate = tableViewDelegate
        self.movieListTbv.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
}

extension MovieListView: MLViewInputProtocol {
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setMovies(_ movies: [Movie]) {
        self.tableViewDelegate?.movies = movies
        self.movieListTbv.reloadData()
    }
    
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Movies", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}
