//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

final class SearchMovieViewController: UIViewController {

    @IBOutlet weak var viewConatinerSearch: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUINavigation()
        setUISearchView()
        addGestureKeyboard()
    }
    
    private func setUINavigation() {
        self.title = "Search movie"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setUISearchView() {
        viewConatinerSearch.layer.cornerRadius = 10
    }
    
    private func addGestureKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
