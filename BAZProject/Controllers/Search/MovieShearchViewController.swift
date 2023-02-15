//
//  MovieShearchViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 08/02/23.
//

import UIKit

class MovieShearchViewController: UIViewController {
    
    @IBOutlet weak var movieSearcher: UISearchBar!
    @IBOutlet weak var keyworkTable: UITableView!
    @IBOutlet weak var noResults: UILabel!
    
    var movieApi = MovieAPI()
    var keywordsToShow: [MovieKeyword]? {
        didSet{
            keyworkTable.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieSearcher.searchTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        noResultsInvisible()
        movieSearcher.searchTextField.delegate = self
    }
    
    func searchMovies(from text: String) {
        movieApi.searchKeywords(textEncoded: text) { keywords, error in
            if let keywords = keywords,
               keywords.count > 0 {
                self.keywordsToShow = keywords
            } else {
                self.noResultTextVisible()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchToCatolog",
           let catalog =  segue.destination as? MovieSearchCatalogViewController,
           let keywordSelected = sender as? MovieKeyword {
            catalog.keywordToSearch = keywordSelected
        }
    }
    
    func noResultTextVisible() {
        noResults.isHidden = false
        keyworkTable.isHidden = true
        let text = movieSearcher.searchTextField.text ?? " "
        noResults.text = "No encontramos nada relacionado con \"\(text)\".\nPuedes buscar por palabra clave o título"
    }
    
    func noResultsInvisible() {
        noResults.isHidden = true
        keyworkTable.isHidden = false
        noResults.text = ""
    }
    
}

// MARK: - TableView's DataSource

extension MovieShearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordsToShow?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keywordCell =  tableView.dequeueReusableCell(withIdentifier: "keywordCell", for: indexPath)
        keywordCell.textLabel?.text = keywordsToShow?[indexPath.row].name
        return keywordCell
     }
}

// MARK: - TableView's Delegate

extension MovieShearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keywordSelected = keywordsToShow?[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "searchToCatolog", sender: keywordSelected)
    }
    
}

// MARK: - SearchBar's Delegate

extension MovieShearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            keywordsToShow = []
            noResultsInvisible()
        }else{
            searchMovies(from: searchText)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton =  true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        keywordsToShow = []
        noResultsInvisible()
        if let _ = self.navigationController?.tabBarController?.viewControllers?.first as? UINavigationController {
            navigationController?.tabBarController?.selectedIndex = 0
        }
    }
}

// MARK: - TextField's Delegate

extension MovieShearchViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        movieSearcher.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text  =  movieSearcher.searchTextField.text,
              text != "" else { return true }
        movieSearcher.resignFirstResponder()
        let keywordSelected = MovieKeyword(id: 0, name: text)
        performSegue(withIdentifier: "searchToCatolog", sender: keywordSelected)
        return true
    }
}
