//
//  SearchMovieView.swift
//  BAZProject
//
//  Created by hlechuga on 20/02/23.
//

import UIKit

class SearchMovieView: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblMovies: UITableView!
    
    //MARK: - Properties
    var presenter: SearchViewOutputProtocol?
    var filterMovies: [Movie] = []
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Búsqueda"
        tblMovies.delegate = self
        tblMovies.dataSource = self
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        tblMovies.register(SearchMovieTableViewCell.nib(), forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
    }
}

//MARK: - Extensions
extension SearchMovieView: SearchViewInputProtocol {
    func loadView(from model: [Movie]) {
        filterMovies = model
        DispatchQueue.main.async {
            self.tblMovies.reloadData()
        }

    }
}
//MARK: Delegate UITableView
extension SearchMovieView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchMovieTableViewCell = tblMovies.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath) as? SearchMovieTableViewCell else { return UITableViewCell() }
        cell.configure(withModel: filterMovies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
}

extension SearchMovieView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToMovieDetail(with: filterMovies[indexPath.row] )
    }
}

//MARK: Delegate UISearchBar
extension SearchMovieView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter?.fetchModel(with: searchBar.text ?? "")
    }
}

