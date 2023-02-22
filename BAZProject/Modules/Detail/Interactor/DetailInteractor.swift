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
    func fetchMedia(detailType: DetailType) {
        let urlString: String = Endpoint.details(mediaType: detailType.mediaType, idMedia: detailType.idMedia).urlString
        dataManager?.requestMedia(urlString)
    }
}

extension DetailInteractor: DetailDataManagerOutputProtocol {
    func handleGetMediaMovie(_ result: MovieDetailResult) {
        presenter?.onReceivedMedia(result: result)
    }

    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
