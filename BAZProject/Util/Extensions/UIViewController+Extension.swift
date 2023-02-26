//
//  UIViewController+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 01/02/23.
//

import UIKit

enum UIImageType {
    case systemName
    case named
}

extension UIViewController {
    func getUIImage(for name: String, type: UIImageType) -> UIImage {
        var uiImage: UIImage?
        switch type {
        case .systemName:
            uiImage = UIImage(systemName: name)
        case .named:
            uiImage = UIImage(named: name)
        }
        return uiImage ?? UIImage()
    }

    func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = .mainPlaceholderSearchBar
        searchController.searchBar.searchTextField.backgroundColor = .lightGray
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.navigationController?.navigationItem.searchController = searchController
    }
}
