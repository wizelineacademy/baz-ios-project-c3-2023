//
//  DetailViewController.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

final class DetailViewController: UIViewController {
    static let identifier: String = .detailXibIdentifier
    // MARK: - Protocol properties
    var presenter: DetailPresenterProtocol?
    var detailType: DetailType?

    // MARK: - Private properties
    private var errorGetData: Bool = false
    private var isLoading: Bool = true
    private var numberCalls: Int = 0

    @IBOutlet weak private var imageSlider: ImageSlider!
    @IBOutlet weak private var titleLabelText: UILabel! {
        didSet {
            titleLabelText.addShadow()
        }
    }
    @IBOutlet weak private var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        callService()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoading || errorGetData {
            showLoader()
        }

        if errorGetData {
            callService()
        }
        navigationController?.navigationBar.prefersLargeTitles = false
        postIdMedia()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageSlider.stopTimmer()
        navigationController?.navigationBar.prefersLargeTitles = true
        stopLoading()
    }

    // MARK: - Private methods
    private func showLoader() {
        guaranteeMainThread {
            self.view.showLoader()
        }
    }

    private func setupView(imageUrlArray: [String]) {
        imageSlider.setUp(imageUrlArray: imageUrlArray)
    }

    private func showImageSlider() {
        guaranteeMainThread {
            self.imageSlider.isHidden = false
        }
    }

    private func callService() {
        isLoading = true
        getData()
    }

    private func getData() {
        if let detailType = detailType {
            presenter?.willFetchMedia(detailType: detailType)
            presenter?.willFetchReview(of: detailType.idMedia.description)
            numberCalls = 2
        }
    }

    private func postIdMedia() {
        if let id = detailType?.idMedia as? Int {
            NotificationCenter.default.post(name: .notificacionCenterNameShowDetail,
                                            object: self,
                                            userInfo: [LocalizedConstants.notificationCenterNameParamId: String(id)])
        }
    }

    private func removeLoaderFromView() {
        guaranteeMainThread {
            self.isLoading = false
            self.view.removeLoader()
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func updateView(data: [ReviewResult]) {
       // TODO: add logic
    }

    func updateView(data: MovieDetailResult) {
        if let data = data.imagesArrayUrlString, !data.isEmpty {
            showImageSlider()
            setupView(imageUrlArray: data)
        }
        guaranteeMainThread {
            self.titleLabelText.text = data.title
            self.descriptionLabel.text = data.overview
        }
    }

    func stopLoading() {
        numberCalls -= 1
        if numberCalls != .zero { return }
        removeLoaderFromView()
    }

    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}
