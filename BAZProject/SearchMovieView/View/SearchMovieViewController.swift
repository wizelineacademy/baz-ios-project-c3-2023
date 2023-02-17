//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

class SearchMovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search movie"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
