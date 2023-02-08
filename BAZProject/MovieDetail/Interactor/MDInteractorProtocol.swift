//
//  MDInteractorProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import Foundation

protocol MDInteractorProtocol: AnyObject {
    var output: MDOutputProtocol? { get set }
    
    func fetchData()
}
