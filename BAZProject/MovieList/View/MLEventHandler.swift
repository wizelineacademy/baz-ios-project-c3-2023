//
//  MLEventHandler.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

protocol MLEventHandler: AnyObject {
    func didLoadView()
    func didSelect(movie: Movie)
}
