//  HomeViewController.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    static let identifier: String = .homeXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Declaration IBOutlets
    @IBOutlet weak var movieTopSlider: ImageSlider!

    // MARK: - Protocol properties
    var presenter: HomePresenterProtocol?
    var movieTopRated: [MovieTopRatedResult]?
    
    // MARK: - Private properties
    private var errorGetData: Bool = false
    private var isLoading: Bool = true
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        hideSearchBar()
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
        movieTopSlider.stopTimmer()
        navigationItem.searchController = getUISearchController()
        stopLoading()
    }
    
    // MARK: - Private methods
    private func hideSearchBar() {
        navigationItem.searchController = .none
    }

    private func showLoader() {
        guaranteeMainThread {
            self.view.showLoader()
        }
    }
    
    private func callService() {
        isLoading = true
        getData()
    }
    
    private func getData() {
        presenter?.willFetchMovieTopRated()
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateView(data: [MovieTopRatedResult]) {
        movieTopRated = data
        var cellMovieType = [CellMovieType]()
        data.forEach { movie in
            if let bac = movie.backdropPath {
                cellMovieType.append(CellMovieType(imageUrlString: Endpoint.img(idImage: bac, sizeImage: .w500).urlString, title: movie.title ?? ""))
            }
        }

        movieTopSlider.setUp(cellMovieType)
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
