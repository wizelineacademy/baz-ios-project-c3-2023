//
//  MovieListView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MovieListView: UIViewController {
    
    var output: MLViewOutputProtocol?
    var tableViewDataSource: MLTableViewDataSource?
    var tableViewDelegate: MLTableViewDelegate?
    
    @IBOutlet weak var movieListTbv: UITableView!

    //MARK: - Lifecycle management
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        output?.didLoadView()
    }
    
    //MARK: - Settings methods
    /** Configures the table view that shows a list of movies */
    private func setupTable() {
        self.movieListTbv.dataSource = tableViewDataSource
        self.movieListTbv.delegate = tableViewDelegate
        self.movieListTbv.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
}

//MARK: - TableViewDelegate
extension MovieListView: MLTableViewOutputProtocol {
    func didSelect(indexPath: IndexPath) {
        guard let movie = tableViewDataSource?.movies[indexPath.row] else { return }
        self.output?.didSelect(movie)
    }
}

//MARK: - Input methods implementation
extension MovieListView: MLViewInputProtocol {
    /**
     Sets the view title in its navigation bar component
     - Parameters:
        - title: a string tha have name of the view
     */
    func setTitle(_ title: String) {
        self.title = title
    }
    
    /**
     Sets the list of received movies the needs to display
     - Parameters:
        - movies: a Movie array
     */
    func setMovies(_ movies: [Movie]) {
        self.tableViewDataSource?.movies = movies
        self.movieListTbv.reloadData()
    }
    
    /**
     Show the received error in an alert components
     - Parameters:
        - error: an Error object
     */
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Movies", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}
