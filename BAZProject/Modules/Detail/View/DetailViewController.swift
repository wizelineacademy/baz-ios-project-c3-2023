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
        if let id = detailType?.idMedia as? Int {
            NotificationCenter.default.post(name: .notificacionCenterNameShowDetail, object: self, userInfo: ["id": String(id)])
        }
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
        }
    }

    private func postIdMedia() {
        if let id = detailType?.idMedia as? Int {
            NotificationCenter.default.post(name: .notificacionCenterNameShowDetail,
                                            object: self,
                                            userInfo: [LocalizedConstants.notificationCenterNameParamId: String(id)])
        }
    }
}

extension DetailViewController: DetailViewProtocol {
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
        guaranteeMainThread {
            self.isLoading = false
            self.view.removeLoader()
        }
    }

    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}
