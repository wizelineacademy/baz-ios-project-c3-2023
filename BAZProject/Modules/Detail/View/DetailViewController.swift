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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callServiceAndShowLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if errorGetData {
            callServiceAndShowLoader()
        }
    }
    
    // MARK: - Private methods
    private func callServiceAndShowLoader() {
        view.showLoader()
        getData()
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
