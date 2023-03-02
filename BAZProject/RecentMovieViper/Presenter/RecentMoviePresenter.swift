//
//  RecentMoviePresenter.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//  
//

import UIKit

class RecentMoviePresenter: RecentMoviePresenterProtocol  {
 
    // MARK: Properties
    weak var view: RecentMovieViewProtocol?
    var interactor: RecentMovieInteractorInputProtocol?
    var router: RecentMovieRouterProtocol?
    var idMovies: [Int]
    var recentMovies: [RecentMovie] = []
    
    init(idMovies: [Int]) {
        self.idMovies = idMovies
    }
    /// Call the interactor for get the movies of the array coming in the HomeRouter
    func viewDidLoad() {
        interactor?.getMovies(idMovies: idMovies)
    }
    
    /// Returns the recentMovies  array count
    ///
    /// - Returns: Integer that represents the recentMovies array count
    func getRecentCount() -> Int {
        return recentMovies.count
    }
    
    /// Get the cell of the tableView
    ///
    /// - Parameter tableView: reference of the tableView
    /// - Parameter indexPath: reference of the indexPath in the tableView
    /// - Returns: Cell of the tableView
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell") as? RecentTableViewCell
        else { return UITableViewCell() }
        ImageProvider.shared.getImage(for: self.recentMovies[indexPath.row].backdrop_path ?? "") { recentImage in
            cell.setupCellImage(image: recentImage, name: self.recentMovies[indexPath.row].original_title ?? "", id: self.recentMovies[indexPath.row].id)

        }
        return cell
    }
    
    /// Logic when the cell of the table is selected
    ///
    /// - Parameter indexPath: reference of indexPath.row selected in the tableView
    func didSelectTable(index: Int) {
        if let view = view {
            router?.goToDetails(from: view, idMovie: self.recentMovies[index].id)
        }
    }
}

extension RecentMoviePresenter: RecentMovieInteractorOutputProtocol {
    func pushRecentMovie(recentMovie: [RecentMovie]) {
        recentMovies = recentMovie
        view?.reloadView()
    }
}
