//
//  MSCollectionProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

protocol MSCollectionDataSource: UICollectionViewDataSource {
    var movies: [Movie] { get set }
}

protocol MSCollectionDelegate: UICollectionViewDelegate {
    var output: MSCollectionOutputProtocol? { get set }
}

protocol MSCollectionOutputProtocol: AnyObject {
    func didSelectItem(at indexPath: IndexPath)
}
