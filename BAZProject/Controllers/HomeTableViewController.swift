//
//  HomeTableViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var categories = ["Trending", "Now playing", "Popular", "Top Rated", "Upcoming"]
    var listOfCategories: [MovieAPICategory: [Movie]] = [
        .Trending: [],
        .Now_playing: [],
        .Popular: [],
        .Top_Rated: [],
        .Upcoming: [],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        let movieApi = MovieAPI()
        listOfCategories[.Trending] = movieApi.getMovies(category: .Trending)
        listOfCategories[.Now_playing] = movieApi.getMovies(category: .Now_playing)
        listOfCategories[.Popular] = movieApi.getMovies(category: .Popular)
        listOfCategories[.Top_Rated] = movieApi.getMovies(category: .Top_Rated)
        listOfCategories[.Upcoming] = movieApi.getMovies(category: .Upcoming)
        
        tableView.reloadData()
    }
    
}

// MARK: - TableView's DataSource

extension HomeTableViewController{
    
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
        switch indexPath.section {
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
    
}

// MARK: - TableView's Delegate

extension HomeTableViewController{
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

