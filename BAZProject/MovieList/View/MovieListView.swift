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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let data = tableViewDataSource?.data else { return }
        output?.lookForUpdates(in: data)
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
    /**
     Call the output methods to send the selected movie
     - Parameters:
        - indexPath: a IndexPath object
     */
    func didSelect(indexPath: IndexPath) {
        guard let movie = tableViewDataSource?.data.movies[indexPath.row] else { return }
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
     Sets the data of received movies that needs to be displayed
     
     If MoviesList object has an array of rows to insert and/or to update, the table view show them in animated way
     
     - Parameters:
        - data: a MoviesList object
     */
    func setMovies(with data: MoviesList) {
        self.tableViewDataSource?.data = data
        
        self.movieListTbv.beginUpdates()
        if let rowsToInsert = data.rowsToInsert, !rowsToInsert.isEmpty {
            self.movieListTbv.insertRows(at: rowsToInsert, with: .middle)
        }
        
        if let rowsToUpdate = data.rowsToUpdate, !rowsToUpdate.isEmpty {
            self.movieListTbv.reloadRows(at: rowsToUpdate, with: .fade)
        }
        self.movieListTbv.endUpdates()
        self.movieListTbv.layoutIfNeeded()
        
        self.movieListTbv.tableFooterView = data.nextPage != nil ?
            MoreMoviesView.getView(delegate: self) :
            nil
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

extension MovieListView: MoreMoviesDelegate {
    /**
     Call the output methods to send the current data and request more movies
     */
    func didSelectMoreMovies() {
        guard let data = self.tableViewDataSource?.data else { return }
        self.output?.fetchMoreMovies(with: data)
    }
}
