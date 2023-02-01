//
//  WSRequestProtocol.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

protocol WSRequestProtocol: AnyObject {
    var request: URLRequest? { get }
}
