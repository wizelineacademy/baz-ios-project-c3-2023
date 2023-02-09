//
//  SearchMovieView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMovieView:UIViewController, SearchMovieViewProtocol{
    var presenter: SearchMoviePresenterProtocol?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    @IBAction func goToMainMovie(){
        dismiss(animated: true)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchMovieView:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let getCount = presenter?.interceptor?.movieApi.getDataMovies as? SearchMovieData{
            return getCount.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovie") as? SearchMovieTableViewCell, let dataMovies = presenter?.interceptor?.movieApi.getDataMovies as? SearchMovieData{
            cell.nameMovieLbl.text = dataMovies.results[indexPath.row].title
            cell.imageMovie.image = UIImage(named: "poster")
            presenter?.interceptor?.movieApi.getImage(from: dataMovies.results[indexPath.row].posterPath ?? "", handler: { imagen in
                DispatchQueue.main.async {
                    cell.imageMovie.image = imagen
                }
            })
            return cell
        }
        return UITableViewCell()
    }
}

extension SearchMovieView:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){ [weak self] in
            self?.presenter?.getKeywordSearch(keyword: searchText)
        }
    }
}


