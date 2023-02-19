//  HomeViewController.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    static let identifier: String = "HomeView"
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Declaration IBOutlets
    
    // MARK: - Protocol properties
    var presenter: HomePresenterProtocol?
    var dataResult: HomeResult?
    
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
        if isLoading {
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
        presenter?.willFetchHome()
    }
}

extension HomeViewController: HomeViewProtocol {
    func updateView(data: HomeResult) {
        // TODO: implement logic to update view, example:
        // dataType = data
    }
    
    func stopLoading() {
        /* Implement logic to stop logic, example:
        guaranteeMainThread {
            self.isLoading = false
            self.view.removeLoader()
        }*/
    }
    
    func setErrorGettingData(_ status: Bool) {
        /* Example:
        errorGetData = status */
    }
}
