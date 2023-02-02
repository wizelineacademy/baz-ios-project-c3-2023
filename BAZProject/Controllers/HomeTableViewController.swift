//
//  HomeTableViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var movies: [Movie] = []
    var moviesNowPlaying: [Movie] = []
    
    var listOfCategories: [MovieAPICategory : [Movie]] = [.Trending: [],
                                                          .Now_playing: [],
                                                          .Popular: [],
                                                          .Top_Rated: [],
                                                          .Upcoming: []]
    
    var categories = ["Trending", "Now playing", "Popular", "Top Rated", "Upcoming"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        let movieApi = MovieAPI()
        movieApi.requestType = .Trending
        listOfCategories[.Trending] = movieApi.getMovies()
        movieApi.requestType = .Now_playing
        listOfCategories[.Now_playing] = movieApi.getMovies()
        movieApi.requestType = .Popular
        listOfCategories[.Popular] = movieApi.getMovies()
        movieApi.requestType = .Top_Rated
        listOfCategories[.Top_Rated] = movieApi.getMovies()
        movieApi.requestType = .Upcoming
        listOfCategories[.Upcoming] = movieApi.getMovies()
        
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell
        cell?.setCollectionView()
        switch indexPath.section{
        case 0:
            cell?.moviesToShow = listOfCategories[.Trending] ?? []
        case 1:
            cell?.moviesToShow = listOfCategories[.Now_playing] ?? []
        case 2:
            cell?.moviesToShow = listOfCategories[.Popular] ?? []
        case 3:
            cell?.moviesToShow = listOfCategories[.Top_Rated] ?? []
        case 4:
            cell?.moviesToShow = listOfCategories[.Upcoming] ?? []
        default:
            cell?.moviesToShow = []
        }
        return cell ?? CategoryTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
