//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import Foundation
final class DetailPresenter {
    var router: DetailRouterProtocol?
    weak var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
}

extension DetailPresenter: DetailPresenterProtocol { }

extension DetailPresenter: DetailInteractorOutputProtocol { }
