//
//  DetailInteractor.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

final class DetailInteractor {
    weak var presenter: DetailInteractorOutputProtocol?
    var dataManager: DetailDataManagerInputProtocol?
}

extension DetailInteractor: DetailInteractorInputProtocol {
    func fetchMovie(of idMovie: String) {
        let urlString: String = Endpoint.detail(idMovie: idMovie).urlString
        dataManager?.requestMovie(urlString)
    }

    func fetchReview(of idMovie: String) {
        dataManager?.requestReview(Endpoint.reviews(idMovie: idMovie).urlString)
    }

    func fetchSimilarMovie(of idMovie: String) {
        dataManager?.requestSimilarMovie(Endpoint.similarMovie(idMovie: idMovie).urlString)
    }

    func fetchMovieRecomendation(of idMovie: String) {
        dataManager?.requestMovieRecomendation(Endpoint.recomendations(idMovie: idMovie).urlString)
    }
}

extension DetailInteractor: DetailDataManagerOutputProtocol {
    func handleGetMovie(_ result: MovieDetailResult) {
        presenter?.onReceivedMedia(result: result)
    }

    func handleGetReview(_ result: [ReviewResult]) {
        presenter?.onReceivedReview(result)
    }

    func handleGetSimilarMovie(_ result: [SimilarMovieModelResult]) {
        presenter?.onReceivedReview(result)
    }

    func handleGetMovieRecomendation(_ result: [RecomendationMovieModelResult]) {
        presenter?.onReceivedMovieRecomendation(result)
    }

    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
