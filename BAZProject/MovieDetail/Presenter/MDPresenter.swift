//
//  MDPresenter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import Foundation

final class MDPresenter {
    
    weak var view: MDViewInputProtocol?
    let interactor: MDInteractorInputProtocol
    let router: MDRouterProtocol
    
    init(view: MDViewInputProtocol?, interactor: MDInteractorInputProtocol, router: MDRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension MDPresenter: MDViewOutputProtocol {
    /** Call a interactor method to fetch the needed data */
    func didLoadView() {
        self.interactor.fetchTitle()
        self.interactor.fetchCellClasses()
        self.interactor.fetchMovieDetail()
    }
    
    /// Calls the router method to push the next view controller with the given movie
    /// - Parameter movie: a Movie object
    func didSelect(_ movie: Movie) {
        self.router.goNextViewController(with: movie)
    }
}

extension MDPresenter: MDInteractorOutputProtocol {
    
    /// Calls the view method to set the view controller title with the given string
    /// - Parameter title: a string that contains the view controller title
    func setTitleForView(_ title: String) {
        self.view?.setTitle(title)
    }
    
    /// Calls the view method to set the table view with the given cells
    /// - Parameter cells: a GenericTableViewCell array
    func setupCells(_ cells: [any GenericTableViewCell.Type]) {
        self.view?.setupTable(with: cells)
    }
    /**
     Call a view method to configure the view with the received details
     - Parameters:
        - details: a GenericRow array
     */
    func didFind(_ details: [GenericTableViewRow]) {
        self.view?.setRows(with: details)
    }
    
    /// Calls the view method to present the given error
    /// - Parameter error: a Error Object
    func didFind(_ error: Error) {
        self.view?.show(error)
    }
}
