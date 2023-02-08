//
//  MovieListView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MovieListView: UIViewController {
    
    weak var eventHandler: MLEventHandler?
    var movies: [Movie] = []
    
    @IBOutlet weak var movieListTbv: UITableView!
    
    init() {
        super.init(nibName: String(describing: MovieListView.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        eventHandler?.didLoadView()
    }
    
    private func setupTable() {
        self.movieListTbv.dataSource = self
        self.movieListTbv.delegate = self
        self.movieListTbv.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setMovies(_ movies: [Movie]) {
        self.movies = movies
        self.movieListTbv.reloadData()
    }
    
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Movies", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}
