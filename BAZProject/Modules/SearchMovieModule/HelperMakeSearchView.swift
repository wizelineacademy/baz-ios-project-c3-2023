//
//  HelperMakeSearchView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 17/02/23.
//

import UIKit

struct MakeSearchView {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame:  CGRectMake(0, 0, 300, 20))
        searchBar.placeholder = "Buscar"
        return searchBar
    }()
}
