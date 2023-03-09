//
//  MovieDetailProviderProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/03/23.
//

import Foundation

protocol MovieDetailProviderProtocol: WSRequestProtocol {
    var movie: Movie { get }
    
    func getTitle() -> String
    func getCellClasses() -> [any GenericTableViewCell.Type]
    func fetchMoreDetails(completion: @escaping (Result<[GenericTableViewRow], Error>) -> Void)
}
