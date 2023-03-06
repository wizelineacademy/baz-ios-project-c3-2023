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
    @IBOutlet weak var reviewsTableView: UITableView!

    // MARK: - Protocol properties
    var presenter: ReviewPresenterProtocol?
    var reviews: [ReviewResult] = []

    var idMovie: String?

    // MARK: - Private properties
    private var errorGetData: Bool = false
    private var isLoading: Bool = true

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

    func getDataCount() -> Int {
        return reviews.count
    }

    func getReview(_ index: Int) -> ReviewResult? {
        return reviews[index]
    }

    // MARK: - Private methods
    private func setupView() {
        initRegister()
    }

    private func initRegister() {
        setTableViewDelegates()
        registerCell()
        reviewsTableView.rowHeight = UITableView.automaticDimension
        reviewsTableView.separatorColor = .white
    }

    private func setTableViewDelegates() {
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
    }

    private func registerCell() {
        reviewsTableView.register(CellReview.nib(),
                                 forCellReuseIdentifier: CellReview.identifier)
    }

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
         reviews = data
        guaranteeMainThread {
            self.reviewsTableView.reloadData()
        }
    }

    func stopLoading() {
        guaranteeMainThread {
            self.view.removeLoader()
        }
        isLoading = false
    }

    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}
