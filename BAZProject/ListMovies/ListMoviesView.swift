//
//  ListMoviesView.swift
//  BAZProject
//
//  Created by hlechuga on 15/02/23.
//

import UIKit

class ListMoviesView: UIViewController {

//MARK: - IBOutlets
    @IBOutlet weak var tblMovies: UITableView!
    
//MARK: - Properties
    var listMoviesPresenter : ListMoviesPresenter?
    var arrMovies: [AllMovieTypes] = []

//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listMoviesPresenter?.onViewAppear()
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }

}

//MARK: - Extensions
extension ListMoviesView : ListMoviesViewProtocol{
    func update(movies: [AllMovieTypes]) {
        print("Datos Recibidos \(movies)")
        arrMovies = movies
        DispatchQueue.main.async {
            self.tblMovies.reloadData()
        }
    }
}

extension ListMoviesView : UITableViewDelegate{
    
}

extension ListMoviesView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        arrMovies.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return  arrMovies[section].typeOfMovies?.description
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MovieTableViewCell = tblMovies.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        let movies = arrMovies[indexPath.section].pagesMovies?.results ?? []
        cell.configure(with: movies)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }    
}
