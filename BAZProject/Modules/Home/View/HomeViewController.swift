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
    @IBOutlet weak private var movieTopSlider: ImageSlider!
    @IBOutlet weak private var nowPlayingSlider: ImageSlider!

    // MARK: - Protocol properties
    var presenter: HomePresenterProtocol?
    var movieTopRated: [MovieTopRatedResult]?
    var nowPlaying: [NowPlayingResult]?

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
        addObservers()
        movieTopSlider.initTimer()
        nowPlayingSlider.initTimer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        movieTopSlider.stopTimmer()
        nowPlayingSlider.stopTimmer()
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
        presenter?.willFetchNowPlaying()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(changeIconEyeInCell),
                                               name: .notificacionCenterNameShowDetail,
                                               object: nil)
    }

    @objc private func changeIconEyeInCell(_ notification: Notification) {
        let nameParameter: String = LocalizedConstants.notificationCenterNameParamId
        guard let id = notification.userInfo?[nameParameter] as? String else { return }
        print("Se a llamado a prueba", id)
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateView(data: [NowPlayingResult]) {
        nowPlaying = data
        var posterUrlString: [String] = []
        data.forEach { movie in
            if let poster = movie.posterPath {
                posterUrlString.append(poster)
            }
        }

        nowPlayingSlider.setUp(imageUrlArray: posterUrlString, imageContentMode: .scaleAspectFit)
        nowPlayingSlider.delegate = self
    }

    func updateView(data: [MovieTopRatedResult]) {
        movieTopRated = data
        var cellMovieType = [CellMovieType]()
        data.forEach { movie in
            if let bac = movie.backdropPath {
                cellMovieType.append(CellMovieType(imageUrlString: Endpoint.img(idImage: bac, sizeImage: .w500).urlString, title: movie.title ?? ""))
            }
        }

        movieTopSlider.setUp(cellMovieType)
        movieTopSlider.delegate = self
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

extension HomeViewController: ImageSliderDelegate {
    func indexDidSelect(_ index: Int) {
        guard let id = movieTopRated?[index].id as? Int else { return }
        presenter?.willShowDetail(of: DetailType(mediaType: .movie, idMedia: id))
    }
}
