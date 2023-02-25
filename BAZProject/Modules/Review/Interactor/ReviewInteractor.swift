//  ReviewInteractor.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class ReviewInteractor {
    // MARK: - Protocol properties
    weak var presenter: ReviewInteractorOutputProtocol?
    var dataManager: ReviewDataManagerInputProtocol?
}

extension ReviewInteractor: ReviewInteractorInputProtocol {
    func fetchReview() {
        // TODO: add string url
        let urlString: String = "https://google.com"
        dataManager?.requestReview(urlString)
    }
}

extension ReviewInteractor: ReviewDataManagerOutputProtocol {
    func handleGetReview(_ result: ReviewResult) {
        presenter?.onReceivedReview(result)
    }
    
    func handleErrorService(_ error: Error) {
        presenter?.showViewError(error)
    }
}
