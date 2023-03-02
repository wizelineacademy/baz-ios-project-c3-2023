//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//  
//

import UIKit

class SearchMoviePresenter: SearchMoviePresenterProtocol {
 
    // MARK: Properties
    weak var view: SearchMovieViewProtocol?
    var interactor: SearchMovieInteractorInputProtocol?
    var router: SearchMovieRouterProtocol?
    var searchedMovies: [SearchMovie] = []
    var keywords: [Keyword] = []
    private let movieApi : MovieAPI = MovieAPI()
    var isSearching: Bool = false
    
    /// Set the boolean isSearching and get the Keyword or the Search depending of this booleand
    ///
    /// - Parameter isSearching: Boolean that represents if the user isSearching or already search
    /// - Parameter searchTerm: String that represents the searched string of the user
    func setSearching(isSearching: Bool, searchTerm: String) {
        self.isSearching = isSearching
        if self.isSearching {
            interactor?.getKeyword(keyword: searchTerm)
        } else {
            interactor?.getSearched(searchTerm: searchTerm)
        }
    }
    
    /// Get the searched movie count
    ///
    /// - Returns: Integer that representes the searched array count
    func getSearchedMoviesCount() -> Int {
        return searchedMovies.count
    }
    
    /// Get the table size depending if the isSearching bool is true or false
    ///
    /// - Returns: CGFloat that representes the size of the table
    func getTableSize() -> CGFloat {
        if isSearching {
            return CGFloat(20)
        } else {
            return CGFloat(100)
        }
    }
    
    /// Get the tableView count
    ///
    /// - Returns: Integer that represents the array count depending if the isSearching bool is true or false
    func getTableViewCount() -> Int {
        if self.isSearching{
            return keywords.count
        } else {
            return searchedMovies.count
        }
    }
    
    /// Get the searched movie 
    ///
    /// - Parameter index: Integer that represents the index to return of the SearchMovie struct array
    /// - Returns: One SearchMovie struct of the array searchedMovies
    func getSearchMovie(index: Int) -> SearchMovie {
        return searchedMovies[index]
    }
    
    /// Get an image from the ImageProvider singleton using the index of the movies array and return and UIImage
    ///
    /// - Parameter index: Index of the array searchedMovies for get the string url image
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getSearchedImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        ImageProvider.shared.getImage(for: searchedMovies[index].backdrop_path ?? "") { searchedImage in
            completion(searchedImage)
        }
    }
    
    /// Get the text of the keyword when the isSearching bool is true
    ///
    /// - Parameter index: Index of the array keywords for get the string name of the keywords
    /// - Returns: String with the keyword
    func getText(index: Int) -> String? {
        if isSearching {
            return keywords[index].name
        }
        return nil
    }
    
    /// Logic when the cell of the table is selected depending if the boolean isSearching is true or false
    ///
    /// - Parameter tableView: reference of tableView that is selected
    /// - Parameter indexPath: reference of indexPath selected in the tableView
    func tableSelected(tableView: UITableView, indexPath: IndexPath) {
        if isSearching {
            self.isSearching = false
            interactor?.getSearched(searchTerm: keywords[indexPath.row].name ?? "")
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            if let view = view {
                self.router?.goToDetails(from: view, idMovie: searchedMovies[indexPath.row].id)
            }
        }
    }
    
    /// Get the cell of the table depending if the boolean isSearching is true or false
    ///
    /// - Parameter tableView: reference of the tableView
    /// - Parameter indexPath: reference of the indexPath in the tableView
    /// - Returns: Cell of the tableView
    func getCell(tableView: UITableView, indexPath: Int) -> UITableViewCell {
        if isSearching {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordTableViewCell") as? KeywordTableViewCell
            else { return UITableViewCell() }
            tableView.separatorStyle = .singleLine
            cell.setupCell(keyword: keywords[indexPath].name ?? "")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
            else { return UITableViewCell() }
            tableView.separatorStyle = .none
            getSearchedImage(index: indexPath, completion: { searchedImage in
                cell.setupCell(image: searchedImage, name: self.getSearchMovie(index: indexPath).original_title ?? "")
            })
            return cell
        }
    }
    
    /// Remove all from the two arrays and reload the tableView to clean the view
    func cleanView() {
        keywords.removeAll()
        searchedMovies.removeAll()
        view?.reloadView()
    }
    

}

extension SearchMoviePresenter: SearchMovieInteractorOutputProtocol {
  
    func pushKeyword(keyword: [Keyword]) {
        self.keywords = keyword
        view?.reloadView()
    }
    
    func pushSearchedMovies(searchedMovies: [SearchMovie]) {
        self.searchedMovies = searchedMovies
        view?.reloadView()
    }
    
    func pushNotSearched() {
        self.isSearching = true
        view?.showAlert()
    }
    
}
