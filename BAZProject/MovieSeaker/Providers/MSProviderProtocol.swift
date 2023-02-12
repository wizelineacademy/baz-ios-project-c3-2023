//
//  MSProviderProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import Foundation

protocol MSProviderProtocol: AnyObject {
    func getViewData() -> MSEntity
    func getMovies(by text: String?, completion: @escaping (Result<[Movie], Error>) -> Void)
}
