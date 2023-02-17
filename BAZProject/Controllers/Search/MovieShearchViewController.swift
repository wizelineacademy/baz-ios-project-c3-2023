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
    
    var timer: Timer?
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
         movieSearcher.searchTextField.delegate = self
     }
     
     func searchMovies(from text: String) {
         movieApi.searchKeywords(textEncoded: text) { keywords, error in
             if let keywords = keywords,
                keywords.count > 0 {
                 self.keywordsToShow = keywords
             } else {
                 DispatchQueue.main.async {
                     guard let text = self.movieSearcher.searchTextField.text else { return }
                     self.keywordsToShow = [MovieKeyword.init(id: 0, name: "\(text)")]
                 }
             }
         }
     }
     
     @objc func initTimer() {
         guard let text = movieSearcher.searchTextField.text,
                   text != "" else { return }
         searchMovies(from: text)
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "searchToCatolog",
            let catalog =  segue.destination as? MovieSearchCatalogViewController,
            let keywordSelected = sender as? MovieKeyword {
             catalog.keywordToSearch = keywordSelected
         }
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
         }
     }
     
     func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
         searchBar.showsCancelButton = false
         timer?.invalidate()
     }

     func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
         searchBar.showsCancelButton =  true
         timer = Timer.scheduledTimer(timeInterval: 0.8,
                                      target: self,
                                      selector: #selector(initTimer),
                                      userInfo: nil,
                                      repeats: true)
     }
     
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.text = ""
         keywordsToShow = []
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
