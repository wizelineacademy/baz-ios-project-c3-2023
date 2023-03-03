//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 16/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
 
    @IBOutlet weak var tableView: UITableView!
    
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var ratedMovies: [Movie] = []
    var imagesMovies: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        movieApi.getMovies { movies in
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        movieApi.getRatedMovies { ratedMovies in
            self.ratedMovies = ratedMovies
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


    
    func configTableView(){
        tableView.dataSource = self
//        tableView.delegate = self
        tableView.register(UINib(nibName: "ratedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ratedCell")
        tableView.register(UINib(nibName: "TrendingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "trendingCell")
        tableView.register(UINib(nibName: "NowPlayingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "nowPlayingCell")
        tableView.register(UINib(nibName: "PopularTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "popularCell")
        tableView.register(UINib(nibName: "UpcomingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "upcomingCell")


    }
}


// MARK: - TableView's DataSource

extension HomeViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 5
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         switch indexPath.row{
         case 0:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "ratedCell") as? ratedTableViewCell else { return UITableViewCell() }
             cell.view = self
             return cell
             
         case 1:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "nowPlayingCell") as? NowPlayingTableViewCell else { return UITableViewCell() }
             cell.view = self
             return cell
         case 2:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingCell") as? TrendingTableViewCell else { return UITableViewCell() }
             cell.view = self
             return cell
         case 3:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "popularCell") as? PopularTableViewCell else { return UITableViewCell() }
             cell.view = self
             return cell
         case 4:
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell") as? UpcomingTableViewCell else { return UITableViewCell() }
             cell.view = self
             return cell
             
             
         default:
             return UITableViewCell()
             
         }
    }
}




