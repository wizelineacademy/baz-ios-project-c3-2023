//
//  MainPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainPresenter: MainPresenterProtocol {
    var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
}

extension MainPresenter: MainInteractorOutputProtocol{
    
}
