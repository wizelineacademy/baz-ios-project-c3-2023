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
    
    // MARK: - Private methods
    private var errorGetData: Bool = false
    
    @IBOutlet weak var imageSlider: ImageSlider!
    @IBOutlet weak var titleLabelText: UILabel! {
        didSet {
            titleLabelText.addShadow()
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guaranteeMainThread {
            self.view.showLoader()
        }
        if errorGetData {
            getData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        imageSlider.stopTimmer()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Private methods
    private func showLoader() {
        guaranteeMainThread {
            self.view.showLoader()
        }
    }
    private func setupView(imageUrlArray: [String]) {
        guaranteeMainThread {
            self.imageSlider.setUp(imageUrlArray: imageUrlArray)
        }
    }
    
    private func getData() {
        if let detailType = detailType {
            presenter?.willFetchMedia(detailType: detailType)
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func updateView(data: MovieDetailResult) {
        if let data = data.imagesArrayUrlString, !data.isEmpty {
            setupView(imageUrlArray: data)
        }
        guaranteeMainThread {
            self.titleLabelText.text = data.title
        }
        guaranteeMainThread {
            self.descriptionLabel.text = data.overview
        }
    }
    
    func stopLoading() {
        guaranteeMainThread {
            self.view.removeLoader()
        }
    }
    
    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}
