//
//  ErrorPagePresenter.swift
//  BAZProject
//
//  Created by 1058889 on 31/01/23.
//

import Foundation

typealias ErrorPagePresenterProtocols = ErrorPagePresenterProtocol & ErrorPageInteractorOutputProtocol
class ErrorPagePresenter: ErrorPagePresenterProtocols {

    var router: ErrorPageRouterProtocol?
    weak var view: ErrorPageViewProtocol?
    var interactor: ErrorPageInteractorInputProtocol?
    
    func closeThisInstance() {
        router?.closeThisInstance()
    }
}
