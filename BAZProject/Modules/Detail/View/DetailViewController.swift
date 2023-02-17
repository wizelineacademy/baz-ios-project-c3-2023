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

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
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
    private func setupView() {
        imageSlider.setUp(imageUrlArray: ["/lnO6QqaCoHsEOJtsqclATT7cJiM.jpg", "/3ENw07WLY75AmTBaLa5TZFYbH1l.jpg", "/sLN0BfRalbhyQBw6ictV3gVr4Dc.jpg","/p9jmVtmm29dCHDHBFrOR6WNNaeO.jpg"])
    }
    
    private func getData() {
        if let detailType = detailType {
            presenter?.willFetchMedia(detailType: detailType)
        }
    }
}

extension DetailViewController: DetailViewProtocol {
    func updateView(data: MovieDetailResult) {
        
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
