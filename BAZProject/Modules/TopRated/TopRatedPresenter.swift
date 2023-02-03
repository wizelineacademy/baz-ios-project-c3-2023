//
//  TopRatedPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import Foundation

class TopRatedPresenter  {
    
    // MARK: Properties
    weak var view: TopRatedViewProtocol?
    var interactor: TopRatedInteractorInputProtocol?
    var router: TopRatedRouterProtocol?
    
}

extension TopRatedPresenter: TopRatedPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension TopRatedPresenter: TopRatedInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
