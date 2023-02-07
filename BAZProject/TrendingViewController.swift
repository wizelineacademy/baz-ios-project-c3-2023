//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    //MARK: - Properties
    var movies: [Movie] = []
    var movieSelected:Movie?
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies(type: .trending)
    }
    
    //MARK: - Functions
    func getMovies(type: TypeOfMovies){
        let movieApi = MovieAPI()
        movieApi.getMovies(forType: type, completion: { [weak self] pageResult in
            self?.movies = pageResult.results
            self?.tableView.reloadData()
        })
    }
    
    func getMovies(byFilter filter:Int){
        //TODO: Hacer que venga la info por el tag del boton
                switch filter{
                case 1:
                    getMovies(type: .upcoming)
                case 2:
                    getMovies(type: .topRated)
                case 3:
                    getMovies(type: .trending)
                default:
                    getMovies(type: .nowPlaying)
                }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailMovieVC = segue.destination as? DetailMovieViewController {
            detailMovieVC.movie = self.movieSelected
        }
    }
    
    
}
//MARK: - Extensions
// MARK: - TableView's DataSource
extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "Peliculas"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }
    
}

// MARK: - TableView's Delegate

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        let movie = movies[indexPath.row]
        config.text = movie.title
        if let url = URL(string: movie.posterImagefullPath) ,let data = try? Data(contentsOf: url) {
                config.image = UIImage(data: data)
            }
        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieSelected = movies[indexPath.row]
        performSegue(withIdentifier: "ListMoviesVCToDetailVC", sender: nil)
        
    }
}
