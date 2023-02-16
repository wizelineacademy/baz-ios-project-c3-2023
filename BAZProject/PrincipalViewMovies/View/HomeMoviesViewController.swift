//
//  HomeMoviesViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

class HomeMoviesViewController: UIViewController {
    
    //    MARK: Outlets
    @IBOutlet weak var tableViewMovies: UITableView!
//    @IBOutlet weak var viewContainerVCTabBar: UIView!
    
    //    MARK: Vars and Constants
    var movies: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    var typeMovieList: TypeMovieList = .popularity
    
    //    MARK: Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForTableBtc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
//        let module = TabBarNavigationViewController()
//        self.addChild(module)
//        module.view.frame = viewContainerVCTabBar.bounds
//        viewContainerVCTabBar.addSubview(module.view)
    }
    
    //TODO: Set UIUX for principal view
    private func setupUITrendingView() {
    }
    
    private func fetchMovies() {
        movies = movieApi.getMovies(typeMovie: typeMovieList) ?? []
        tableViewMovies.reloadData()
    }
    
    private func settingsForTableBtc() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.separatorStyle = .none
        tableViewMovies.getBundleAndRegisterCell(MovieTableViewCell.self)
    }
}

// MARK: - TableView's DataSource

extension HomeMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        //        cell.titleMovie.text = movies[indexPath.row].title
        //        let url = movies[indexPath.row].getUrlImg(posterPath: movies[indexPath.row].posterPath ?? "")
        //        if let urlString = url { cell.imgMovie.load(url: urlString) }
        return cell
    }
}
