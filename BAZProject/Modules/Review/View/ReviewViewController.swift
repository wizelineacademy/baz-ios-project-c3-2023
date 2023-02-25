//  ReviewViewController.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ReviewViewController: UIViewController {
    static let identifier: String = .reviewXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    // MARK: - Declaration IBOutlets

    // MARK: - Protocol properties
    var presenter: ReviewPresenterProtocol?
    var dataResult: [ReviewResult]?

    var idMovie: String?

    // MARK: - Private properties
    private var errorGetData: Bool = false
    private var isLoading: Bool = true

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoading || errorGetData {
            showLoader()
        }

        if errorGetData {
            callService()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        stopLoading()
    }

    // MARK: - Private methods
    private func showLoader() {
        guaranteeMainThread {
            self.view.showLoader()
        }
    }
    // private func setupView() {}

    private func callService() {
        isLoading = true
        getData()
    }

    private func getData() {
        guard let idMovie = idMovie else { return }
        presenter?.willFetchReview(of: idMovie)
    }
}

extension ReviewViewController: ReviewViewProtocol {
    func updateView(data: [ReviewResult]) {
        // TODO: implement logic to update view, example:
        // dataType = data
    }

    func stopLoading() {
        guaranteeMainThread {
            self.isLoading = false
            self.view.removeLoader()
        }
    }

    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}
