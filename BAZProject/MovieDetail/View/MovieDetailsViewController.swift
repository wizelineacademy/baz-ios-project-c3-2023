//
//  MovieDetailsViewController.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    var output: MDViewOutputProtocol?
    var tableViewDelegate: DetailTableViewDelegate?
    var tableViewDataSource: DetailDataSource?

    @IBOutlet weak var movieDetails: UITableView!
    
    // MARK: - Lifecycle management
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.didLoadView()
    }
}

extension MovieDetailsViewController: MDViewInputProtocol {
    /// Sets the table view with the received cells
    /// - Parameter cells: a GenericTableViewCell types array
    func setupTable(with cells: [any GenericTableViewCell.Type]) {
        cells.forEach { cell in
            movieDetails.register(cell.nib, forCellReuseIdentifier: cell.identifier)
        }
        movieDetails.showsVerticalScrollIndicator = false
        movieDetails.showsHorizontalScrollIndicator = false
        movieDetails.dataSource = tableViewDataSource
        movieDetails.delegate = tableViewDelegate
    }
    
    /// Reload the table view with the given rows
    /// - Parameter rows: a GenericTableViewRow array
    func setRows(with rows: [any GenericTableViewRow]) {
        tableViewDataSource?.rows = rows
        self.movieDetails.reloadData()
    }
    
    /// Sets the view controller title
    /// - Parameter title: a string that contains the view controller title
    func setTitle(_ title: String) {
        self.title = title
    }
    
    /**
     Show the received error in an alert components
     - Parameter error: an Error object
     */
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Movies", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}

extension MovieDetailsViewController: SliderMovieDelegate {
    /// Calls the output method with the received movie
    /// - Parameter movie: a Movie object
    func didSelect(_ movie: Movie) {
        self.output?.didSelect(movie)
    }
}
