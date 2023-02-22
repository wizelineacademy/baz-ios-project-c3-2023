//
//  DetailMoviePresenter.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import UIKit

class DetailMoviePresenter: DetailMoviePresenterProtocol  {
  
    // MARK: Properties
    weak var view: DetailMovieViewProtocol?
    var interactor: DetailMovieInteractorInputProtocol?
    var router: DetailMovieRouterProtocol?
    var presenterCast: DetailMovieCastPresenterProtocol?
    var presenterReview: DetailMovieReviewPresenterProtocol?
    var presenterSimilar: DetailMovieSimilarPresenterProtocol?
    var presenterRecommendation: DetailMovieRecommendationPresenterProtocol?
    private var idMovie: Int
    private let movieApi : MovieAPI = MovieAPI()
    var detailsMovie: DetailMovie?
    var tableViewSize: Int = 170
    var tableCount: Int = 5
    var detailName: String = ""
    let group = DispatchGroup()
    
    init(idMovie: Int) {
        self.idMovie = idMovie
    }
    
    
    /// Call all the presenters for initial the consume of all details 
    ///
    func viewDidLoad() {
        interactor?.getDetails(idMovie: idMovie)
        presenterCast?.getCast(idMovie: idMovie)
        presenterReview?.getReview(idMovie: idMovie)
        presenterSimilar?.getSimilar(idMovie: idMovie)
        presenterRecommendation?.getRecommendation(idMovie: idMovie)
    }
    
    
    /// Get an image from the MovieApi class using the detailImage and return and UIImage
    ///
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getDetailImage(completion: @escaping (UIImage?) -> Void) {
        movieApi.getImage(for: detailsMovie?.backdrop_path ?? "") { detailImage in
            completion(detailImage)
        }
    }
    
    /// Get the tableSize for the tableCollectionView
    ///
    /// - Returns: Integer that represents the table size
    func getTableSize() -> Int {
        return tableViewSize
    }

    /// Get the tableCount for the tableCollectionView
    ///
    /// - Returns: Integer that represents the table count
    func getTableCount() -> Int {
        return tableCount
    }
    
    func getGenres() -> String {
        switch self.detailsMovie?.genres?.count {
        case 1:
            return "\(self.detailsMovie?.runtime ?? 000) min | \(self.detailsMovie?.genres?[0].name ?? "")"
        case let n where n ?? 0 > 1:
            return "\(self.detailsMovie?.runtime ?? 000) min | \(self.detailsMovie?.genres?[0].name ?? "") | \(self.detailsMovie?.genres?[1].name ?? "")"
        default:
            return "\(self.detailsMovie?.runtime ?? 000) min"
        }
    }
    
  
    
    func getTableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell") as? DetailsTableViewCell else { return UITableViewCell() }
            let name = self.detailsMovie?.original_title ?? ""
            let genres = self.getGenres()
            let overview = self.detailsMovie?.overview ?? ""
            cell.setupCell(name: name, genres: genres, overview: overview)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell") as? DetailTableViewCell
            else { return UITableViewCell() }
            
            cell.presenter = self
            cell.indexPath = indexPath.row
            cell.setupDetailsCollectionView()
            return cell
        }
    }
    
  

    /// Get the collection count switching the indexPath
    ///
    /// - Parameter indexPath: Integer that represents the current cell in tableView
    /// - Returns: Integer that representes the collection count
    func getCollectionCount(indexPath: Int) -> Int? {
        switch indexPath {
        case 1:
            return presenterCast?.getCastCount()
        case 2:
            return presenterReview?.getReviewCount()
        case 3:
            return presenterSimilar?.getSimilarCount()
        case 4:
            return presenterRecommendation?.getRecommendationCount()
        default:
            return 0
        }
    }
    
    /// Get the cell of the collectionViewCell
    ///
    /// - Parameter collectionView: collectionView for switch of the cell type
    /// - Parameter indexPath: indexPath that represents the indexPath of the collectionView
    /// - Parameter indexPathTable: indexPath that represents the indexPath of the tableView
    /// - Parameter nameLabel: the label name of the collection
    /// - Returns: the cell fot setup in the collectionViewCell
    func getCell(collectionView: UICollectionView, indexPath: IndexPath, indexPathTable: Int, nameLabel: UILabel) -> UICollectionViewCell {
        switch indexPathTable{
        case 1:
            nameLabel.text = "Cast"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            presenterCast?.getCastImage(index: indexPath.row, completion: { castImage in
                cell.setupCastImage(castImage: castImage)
                DispatchQueue.main.async {
                    cell.nameLabel.text = self.presenterCast?.getCast(index: indexPath.row).name ?? ""
                    cell.characterLabel.text = self.presenterCast?.getCast(index: indexPath.row).character ?? ""
                }
            })
            return cell
        case 2:
            nameLabel.text = "Review"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            cell.setupReviewCell(name: presenterReview?.getReview(index: indexPath.row).author, review: presenterReview?.getReview(index: indexPath.row).content, date: presenterReview?.getReview(index: indexPath.row).created_at)
            cell.addShadow()
            return cell
        case 3:
            nameLabel.text = "Similar"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
            presenterSimilar?.getSimilarImage(index: indexPath.row, completion: { similarImage in
                cell.setupCell(image: similarImage)
            })
            return cell
        case 4:
            nameLabel.text = "Recommendation"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
            presenterRecommendation?.getRecommendationImage(index: indexPath.row, completion: { recommendationImage in
                cell.setupCell(image: recommendationImage)
            })
           return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    /// Get the cell of the collectionViewCell
    ///
    /// - Parameter indexPath: indexPath that represents the indexPath of the collectionView
    /// - Returns: cgsize of the collectionViewCell
    func getTableSize(indexPath: Int) -> CGSize {
        switch indexPath{
        case 1:
            return CGSize(width: 100, height: 130)
        case 2:
            return CGSize(width: 200, height: 100)
        case 3:
            return CGSize(width: 100, height: 120)
        case 4:
            return CGSize(width: 100, height: 120)
        default:
            return CGSize(width: 0, height: 0)
        }
    }

}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
  
    func pushDetailMovie(detailMovie: DetailMovie) {
        self.detailsMovie = detailMovie
        view?.setupDetailsView()
        view?.reloadView()
    }
  
}

extension DetailMoviePresenter: DetailMovieCastProtocol {
    func informSuccesfulPresenterCast() {
        view?.reloadView()
    }
}

extension DetailMoviePresenter: DetailMovieReviewProtocol {
    func informSuccesfulPresenterReview() {
        view?.reloadView()
    }
}

extension DetailMoviePresenter: DetailMovieSimilarProtocol {
    func informSuccesfulPresenterSimilar() {
        view?.reloadView()
    }
}

extension DetailMoviePresenter: DetailMovieRecommendationProtocol {
    func informSuccesfulPresenterRecommendation() {
        view?.reloadView()
    }
}
