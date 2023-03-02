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
    var detailName: String = ""
    let group = DispatchGroup()
    private var cellArray: [CollectionTypes] = []
    
    
    init(idMovie: Int) {
        self.idMovie = idMovie
    }
    
    
    /// Call the interactor for init the consume of the detail of the movie
    func viewDidLoad() {
        interactor?.getDetails(idMovie: idMovie)
    }
    
    /// Call all the presenters of the diferentes types of details and setup the dispatchGroup
    func getAllDetails() {
        setupDispatchGroup()
        presenterRecommendation?.getRecommendation(idMovie: idMovie)
        presenterSimilar?.getSimilar(idMovie: idMovie)
        presenterReview?.getReview(idMovie: idMovie)
        presenterCast?.getCast(idMovie: idMovie)
    }
    
    /// Setup the dispatch group and add a notify when the group end
    func setupDispatchGroup() {
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        group.notify(queue: .main) { [weak self] in
            self?.cellArray.sort { cellOne, cellTwo in
                cellOne.position < cellTwo.position
            }
            self?.view?.reloadView()
        }
    }
    
    /// Get an image from the MovieApi class using the detailImage and return and UIImage
    ///
    /// - Parameter completion: Escaping closure that escapes a UIImage or a nil
    /// - Returns: escaping closure with the UIImage type, if the parse fails, can return nil
    func getDetailImage(completion: @escaping (UIImage?) -> Void) {
        ImageProvider.shared.getImage(for: detailsMovie?.backdrop_path ?? "") { detailImage in
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
        return cellArray.count + 1
    }
    
    /// Get the genres of the movie depending of the number of genres coming in the api
    ///
    /// - Returns: String that includes the genres and the runtime of the movie in minutes
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
    
    /// Get the tableCell
    ///
    /// - Parameter indexPath: Integer that represents the current cell in tableView
    /// - Returns: Integer that representes the collection count
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
            switch cellArray[indexPath - 1] {
            case .cast:
                return presenterCast?.getCastCount()
            case .review:
                return presenterReview?.getReviewCount()
            case .similar:
                return presenterSimilar?.getSimilarCount()
            case .recommendation:
                return presenterRecommendation?.getRecommendationCount()
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
      
        switch cellArray[indexPathTable - 1] {
            case .cast:
                nameLabel.text = "Cast"
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
                presenterCast?.getCastImage(index: indexPath.row, completion: { castImage in
                    cell.setupCastCell(castImage: castImage, name: self.presenterCast?.getCast(index: indexPath.row).name ?? "", character: self.presenterCast?.getCast(index: indexPath.row).character ?? "")
                })
                return cell
            case .review:
                nameLabel.text = "Review"
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
                cell.setupReviewCell(name: presenterReview?.getReview(index: indexPath.row).author, review: presenterReview?.getReview(index: indexPath.row).content, date: presenterReview?.getReview(index: indexPath.row).created_at)
                return cell
            case .similar:
                nameLabel.text = "Similar"
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
                presenterSimilar?.getSimilarImage(index: indexPath.row, completion: { similarImage in
                    cell.setupCell(image: similarImage)
                })
                return cell
            case .recommendation:
                nameLabel.text = "Recommendation"
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
                presenterRecommendation?.getRecommendationImage(index: indexPath.row, completion: { recommendationImage in
                    cell.setupCell(image: recommendationImage)
                })
               return cell
            }
    }
    
    /// Get the cell of the collectionViewCell
    ///
    /// - Parameter indexPath: indexPath that represents the indexPath of the collectionView
    /// - Returns: cgsize of the collectionViewCell
    func getTableSize(indexPath: Int) -> CGSize {
        switch cellArray[indexPath - 1] {
            case .cast:
                return CGSize(width: 100, height: 130)
            case .review:
                return CGSize(width: 200, height: 100)
            case .similar:
                return CGSize(width: 100, height: 120)
            case .recommendation:
                return CGSize(width: 100, height: 120)
        }
    }

}

extension DetailMoviePresenter: DetailMovieInteractorOutputProtocol {
    
    func pushDetailMovie(detailMovie: DetailMovie) {
        self.detailsMovie = detailMovie
        view?.setupDetailsView()
        NotificationCenter.default.post(name: NSNotification.Name("RecentViewMovie"), object: ["idMovie": idMovie])
        getAllDetails()
    }
  
    func pushNotDetails() {
        view?.showNotDetailsAlert()
    }
}

extension DetailMoviePresenter: DetailMovieCastProtocol {
    func informErrorPresenterCast() {
        group.leave()
    }
    
    func informSuccesfulPresenterCast() {
        cellArray.append(.cast)
        group.leave()
    }
}

extension DetailMoviePresenter: DetailMovieReviewProtocol {
    func informErrorPresenterReview() {
        group.leave()
    }
    
    func informSuccesfulPresenterReview() {
        cellArray.append(.review)
        group.leave()
    }
}

extension DetailMoviePresenter: DetailMovieSimilarProtocol {
    func informErrorPresenterSimilar() {
        group.leave()
    }
    
    func informSuccesfulPresenterSimilar() {
        cellArray.append(.similar)
        group.leave()
    }
}

extension DetailMoviePresenter: DetailMovieRecommendationProtocol {
    func informErrorPresenterRecommendation() {
        group.leave()
    }
    
    func informSuccesfulPresenterRecommendation() {
        cellArray.append(.recommendation)
        group.leave()
    }
}

enum CollectionTypes {
    case cast, review, similar, recommendation
    var position: Int {
        switch self {
        case .cast:
            return 0
        case .review:
            return 1
        case .similar:
            return 2
        case .recommendation:
            return 3
        }
    }
}
