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
    
    func setSearching(isSearching: Bool, searchTerm: String) {
        self.isSearching = isSearching
        if self.isSearching{
            interactor?.getKeyword(keyword: searchTerm)
        } else {
            interactor?.getSearched(searchTerm: searchTerm)
        }
    }
    
    func getSearchedMoviesCount() -> Int {
        return searchedMovies.count
    }
    
    func getTableSize() -> CGFloat {
        if isSearching {
            return CGFloat(20)
        } else {
            return CGFloat(100)
        }
    }
    
    func getTableViewCount() -> Int {
        if self.isSearching{
            return keywords.count
        } else {
            return searchedMovies.count
        }
    }
    
    func getSearchMovie(index: Int) -> SearchMovie {
        return searchedMovies[index]
    }
    
    func getSearchedImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: searchedMovies[index].backdrop_path ?? "") { searchedImage in
            if let searchedImage = searchedImage{
                completion(searchedImage)
            } else {
                completion(nil)
            }
        }
    }
    
    func getText(index: Int) -> String? {
        if isSearching{
            return keywords[index].name
        } else {
            return nil
        }
    }
    
    func tableSelected(tableView: UITableView, indexPath: IndexPath) {
        if isSearching {
            self.isSearching = false
            interactor?.getSearched(searchTerm: keywords[indexPath.row].name?.replacingOccurrences(of: " ", with: "%20") ?? "")
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            if let view = view{
                self.router?.goToDetails(from: view, idMovie: searchedMovies[indexPath.row].id)
            }
        }
    }
    
    func getCell(tableView: UITableView, indexPath: Int) -> UITableViewCell {
        if isSearching {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordTableViewCell") as? KeywordTableViewCell
            else { return UITableViewCell() }
            
            cell.setupCell(keyword: keywords[indexPath].name ?? "")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell
            else { return UITableViewCell() }
            
            getSearchedImage(index: indexPath, completion: { searchedImage in
                cell.setupCell(image: searchedImage, name: self.getSearchMovie(index: indexPath).original_title ?? "")
            })
            return cell
        }
    }
    
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
    
    
}
