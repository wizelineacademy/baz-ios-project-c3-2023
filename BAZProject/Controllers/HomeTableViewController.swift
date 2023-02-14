//
//  HomeTableViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var heightRowTable: CGFloat = 250
    var categories = MovieAPICategory.allMovieAPICategories
    var listOfCategories: [MovieAPICategory: [Movie]] = [
        .trending: [],
        .nowPlaying: [],
        .popular: [],
        .topRated: [],
        .upcoming: [],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        let movieApi = MovieAPI()
        listOfCategories[.trending] = movieApi.getMovies(category: .trending)
        listOfCategories[.nowPlaying] = movieApi.getMovies(category: .nowPlaying)
        listOfCategories[.popular] = movieApi.getMovies(category: .popular)
        listOfCategories[.topRated] = movieApi.getMovies(category: .topRated)
        listOfCategories[.upcoming] = movieApi.getMovies(category: .upcoming)
        
        tableView.reloadData()
    }
    
    func showDetailMovieViewController(sender: Any?){
        let detailView = MovieDetailPViewController()
        guard let movieDetail =  sender as? Movie else { return }
        detailView.movieToShowDetail = movieDetail
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}

// MARK: - TableView's DataSource

extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell
        cell?.setCollectionView()
        cell?.categoryTableCellDelegate = self
        switch indexPath.section {
        case MovieAPICategory.trending.rawValue:
            cell?.moviesToShow = listOfCategories[.trending] ?? []
        case MovieAPICategory.nowPlaying.rawValue:
            cell?.moviesToShow = listOfCategories[.nowPlaying] ?? []
        case MovieAPICategory.popular.rawValue:
            cell?.moviesToShow = listOfCategories[.popular] ?? []
        case MovieAPICategory.topRated.rawValue:
            cell?.moviesToShow = listOfCategories[.topRated] ?? []
        case MovieAPICategory.upcoming.rawValue:
            cell?.moviesToShow = listOfCategories[.upcoming] ?? []
        default:
            cell?.moviesToShow = []
        }
        return cell ?? CategoryTableViewCell()
    }
    
}

// MARK: - TableView's Delegate

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowTable
    }
    
}

// MARK: - TableViewCell's Delegate

extension HomeTableViewController: CategoryTableCellDelegate {
    
    func didSelectMovie(movieId: Int, indexRow: Int) {
        let movieToShow = Movie.searchMovieByID(movieID: movieId, listOfCategories: listOfCategories)
        showDetailMovieViewController(sender: movieToShow)
    }

}

