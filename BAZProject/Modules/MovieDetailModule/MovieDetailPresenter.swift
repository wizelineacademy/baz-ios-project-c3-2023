//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

final class MovieDetailPresenter: NSObject {
    var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInterceptorInputProtocol?
    var isFavorite: Bool = false
    let imageProvider = ImageProvider.shared
    
    private func registerResumeTableViewCells(tableView: UITableView) {
        let textFieldCell = UINib(nibName: "ResumeTableViewCell",
                                  bundle: nil)
        tableView.register(textFieldCell,
                           forCellReuseIdentifier: ResumeTableViewCell.reusableCell)
    }
    
    private func registerCastTableViewCells(tableView: UITableView) {
        let textFieldCell = UINib(nibName: "CastTableViewCell",
                                  bundle: nil)
        tableView.register(textFieldCell,
                           forCellReuseIdentifier: CastTableViewCell.reusableCell)
    }
    
    private func registerShowMoviesTableViewCells(tableView: UITableView) {
        let textFieldCell = UINib(nibName: "ShowMoviesTableViewCell",
                                  bundle: nil)
        tableView.register(textFieldCell,
                           forCellReuseIdentifier: ShowMoviesTableViewCell.reusableCell)
    }
    
    private func regiterReviewsTableViewCell(tableView: UITableView) {
        let textFieldCell = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: ReviewsTableViewCell.reusableCell)
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func deleteToFavoriteMovie() {
        interactor?.deleteToFavoriteMovie()
    }
    
    func saveFavoriteMovie() {
        interactor?.saveFavoriteMovie()
    }
    
    func goToMovieDetail(data: Movie) {
        guard let view = view as? UIViewController else { return }
        MovieDetailRouter().presentView(from: view, data: data)
    }
    
    func viewDidLoad(poster: inout UIImageView, tableView: UITableView) {
        
        pushObserver()
        registerTables(tableView: tableView)
        tableView.rowHeight = 220
        getDataIdMovie()
        getPosterImage(poster: poster)
    }
    
    private func registerTables(tableView: UITableView) {
        registerResumeTableViewCells(tableView: tableView)
        registerCastTableViewCells(tableView: tableView)
        registerShowMoviesTableViewCells(tableView: tableView)
        regiterReviewsTableViewCell(tableView: tableView)
    }
    
    private func pushObserver() {
        NotificationCenter.default.post(name: .countMovieWatch, object: ["idMovie": interactor?.data?.id])
    }
    
    private func getPosterImage(poster: UIImageView) {
        UIView.fillSkeletons(onView: poster)
        if let data = interactor?.data, let image = data.backdropPath{
            imageProvider.fetchImage(from: image , completion: { image in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    UIView.removeSkeletons(onView: poster)
                    poster.image = image
                }
            })
        }
    }
    
    private func getDataIdMovie() {
        interactor?.movieApiData.getArrayDataMovie = [
            .creditMovie: nil,
            .similar: nil,
            .recommendations: nil,
            .reviews: nil
        ]
        
        if let idMovie = interactor?.data?.id {
            interactor?.getMoviesDataWithId(from: .creditMovie, id: idMovie, structure: Credit.self)
            interactor?.getMoviesDataWithId(from: .similar, id: idMovie, structure: Movies.self)
            interactor?.getMoviesDataWithId(from: .recommendations, id: idMovie, structure: Movies.self)
            interactor?.getMoviesDataWithId(from: .reviews, id: idMovie, structure: Reviews.self)
        }
        
        view?.reloadData()
    }
    
    func getTableViewDataSource() -> UITableViewDataSource {
        return self
    }
    
    func getTableViewDelegate() -> UITableViewDelegate {
        return self
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func reloadData() {
        view?.reloadData()
    }
}

extension MovieDetailPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
//            "Resumen:"
            if let cell = tableView.dequeueReusableCell(withIdentifier: ResumeTableViewCell.reusableCell, for: indexPath) as? ResumeTableViewCell, let data = interactor?.data {
                cell.overviewTextView.text = data.overview
                cell.title.text = data.title
                cell.data.text = "Calificacion: \(data.voteAverage) * \(data.releaseDate) * \(data.popularity)"
                return cell
            }
            return UITableViewCell()
        case 1:
//            "Cast:"
            if let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.reusableCell, for: indexPath) as? CastTableViewCell, let data = interactor?.movieApiData.getArrayDataMovie?[.creditMovie] as? Credit {
                cell.data = data
                cell.collectionView.reloadData()
                return cell
            }
            return UITableViewCell()
        case 2:
//            "similar:"
            if let cell = tableView.dequeueReusableCell(withIdentifier: ShowMoviesTableViewCell.reusableCell, for: indexPath) as? ShowMoviesTableViewCell, let data = interactor?.movieApiData.getArrayDataMovie?[.similar] as? Movies{
                cell.data = data
                cell.delegate = self
                cell.collectionView.reloadData()
                return cell
            }
            return UITableViewCell()

        case 3:
//            "recommended movies:"
            if let cell = tableView.dequeueReusableCell(withIdentifier: ShowMoviesTableViewCell.reusableCell, for: indexPath)
                as? ShowMoviesTableViewCell, let data = interactor?.movieApiData.getArrayDataMovie?[.recommendations] as? Movies {
                cell.data = data
                cell.delegate = self
                cell.collectionView.reloadData()
                return cell
            }
            return UITableViewCell()
        case 4:
//             "movie review:"
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.reusableCell, for: indexPath) as? ReviewsTableViewCell, let data = interactor?.movieApiData.getArrayDataMovie?[.reviews], let data = data as? Reviews {
                if data.results.count > 0 {
                    cell.nameAuthor.text = "\(data.results[indexPath.row].author):"
                    let split = data.results[indexPath.row].content.split(separator: "_")
                    cell.review.text = String(split[1])
                }
                return cell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension MovieDetailPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Reparto de actores:"
        case 2:
            return "Peliculas Similares:"
        case 3:
            return "Peliculas Recomendadas:"
        case 4:
            return "Reseñas de Pelicula:"
        default:
            return ""
        }
    }
}

extension MovieDetailPresenter: MoviesTableViewCellDelagete {
    func didTapped(movie: Movie) {
        goToMovieDetail(data: movie)
    }
}

