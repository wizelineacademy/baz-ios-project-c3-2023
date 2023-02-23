//
//  HelperMakeSearchView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 17/02/23.
//

import UIKit

struct MakeSearchView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame:  UINavigationController().view.bounds)
        searchBar.placeholder = "Buscar"
        return searchBar
    }()
}
