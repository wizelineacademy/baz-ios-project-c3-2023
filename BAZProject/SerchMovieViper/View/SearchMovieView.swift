//
//  SearchMovieView.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//  
//

import Foundation
import UIKit

class SearchMovieView: UIViewController {

    // MARK: Properties
    var presenter: SearchMoviePresenterProtocol?

    @IBOutlet weak var movieSearchBar: UISearchBar! {
        didSet {
            self.movieSearchBar.placeholder = "  Search movie"
            self.movieSearchBar.isTranslucent = true
            self.movieSearchBar.layer.borderWidth = 1
            self.movieSearchBar.layer.borderColor = UIColor.lightGray.cgColor
            self.movieSearchBar.layer.masksToBounds = true
            self.movieSearchBar.layer.cornerRadius = 8.0
            if let textField = movieSearchBar.value(forKey: "searchField") as? UITextField {
                textField.backgroundColor = .white
                if self.traitCollection.userInterfaceStyle == .dark {
                    textField.backgroundColor = .black
                }
                let backgroundView = textField.subviews.first
                if #available(iOS 11.0, *) {
                    backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
                    backgroundView?.subviews.forEach({ $0.removeFromSuperview() })
                }
                backgroundView?.layer.cornerRadius = 12.0
                backgroundView?.layer.masksToBounds = true
            }
        }
    }
    @IBOutlet weak var movieSearchTableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       setupSearchTable()
    }
    
    func setupSearchTable() {
        movieSearchBar.delegate = self
        movieSearchTableView.delegate = self
        movieSearchTableView.dataSource = self
        movieSearchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: Bundle(for: SearchMovieView.self)), forCellReuseIdentifier: "SearchTableViewCell")
        movieSearchTableView.register(UINib(nibName: "KeywordTableViewCell", bundle: Bundle(for: SearchMovieView.self)), forCellReuseIdentifier: "KeywordTableViewCell")
    }
}

extension SearchMovieView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let searchedText = presenter?.getText(index: indexPath.row){
            movieSearchBar.text = searchedText
        }
        presenter?.tableSelected(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter?.getTableSize() ?? 0
    }
}

extension SearchMovieView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTableViewCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { presenter?.getCell(tableView: tableView, indexPath: indexPath.row) ?? UITableViewCell()
    }
}

extension SearchMovieView: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.showsCancelButton = true
        return true
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.showsCancelButton = false
        searchBar.text?.removeAll()
        searchBar.endEditing(true)
        presenter?.cleanView()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.setSearching(isSearching: true, searchTerm: searchText)
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.setSearching(isSearching: false, searchTerm: searchBar.text ?? "")
    }
}

extension SearchMovieView: SearchMovieViewProtocol {
    func showAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Movie not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.movieSearchTableView.reloadData()
        }
    }
    
    
}
