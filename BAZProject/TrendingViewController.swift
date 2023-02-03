//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var imagesMovies: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableview()
        movies = movieApi.getMovies()
        tableView.reloadData()
    }
    
    func configTableview(){
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Home")
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home") as! HomeTableViewCell
        return cell
    }
    
    
}

// MARK: - TableView's Delegate

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let custom = cell as? HomeTableViewCell{
            custom.labelTitle.text = movies[indexPath.row].title
            custom.imgView.image = UIImage(systemName: "play.circle")

        }
    }
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?){
        if let destination = segue.destination as? DetailMovieViewController{
            destination.movie = movies[self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
