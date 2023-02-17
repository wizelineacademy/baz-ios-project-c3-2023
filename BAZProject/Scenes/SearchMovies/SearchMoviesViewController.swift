//
//  SearchMoviesViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol SearchMoviesDisplayLogic: AnyObject {
    // TODO: create functions to manage display logic
    
}

class SearchMoviesViewController: UIViewController {
    
    // MARK: Properties
    lazy var searchBar: UISearchBar? = {
        let view = UISearchBar(frame: .zero)
        view.sizeToFit()
        view.placeholder = "Search"
        view.becomeFirstResponder()
        
        return view
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchViewInNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func addSearchViewInNavigation() {
        guard let searchBar = searchBar else {
            return
        }
        let rightButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightButton
    }
}

extension SearchMoviesViewController: SearchMoviesDisplayLogic {
    // TODO: conform SearchMoviesDisplayLogic protocol

}
