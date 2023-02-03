//
//  TopRatedView.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import UIKit

class TopRatedView: UITableViewController {

    // MARK: Properties
    var presenter: TopRatedPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TopRatedView: TopRatedViewProtocol {
    // TODO: implement view output methods
}
