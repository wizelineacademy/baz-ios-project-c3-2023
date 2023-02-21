//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

enum SectionsDetailMovie: Int, CaseIterable {
    case header = 0
    case reviews = 1
    case similar = 2
    case recommendations = 3
}

final class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var tblDetailMovie: UITableView!
    var movie: Movie?
    private let group = DispatchGroup()
    private let movieAPI = MovieAPI()
    private var similarMovies: [Movie]?
    private var recomendationsMovies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Movie"
        setupTable()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        group.enter()
        group.enter()
        executeRecomendations()
        executeSimilarMovies()
        group.notify(queue: .main) {
            self.tblDetailMovie.reloadData()
            print("Se cargaron")
        }
    }
    
    private func setupTable(){
        tblDetailMovie.delegate = self
        tblDetailMovie.dataSource = self
        tblDetailMovie.register(InfoMovieTableViewCell.nib, forCellReuseIdentifier: InfoMovieTableViewCell.identifier)
        tblDetailMovie.register(CarruselMovieTableViewCell.nib, forCellReuseIdentifier: CarruselMovieTableViewCell.identifier)
        tblDetailMovie.register(ReviewsTableViewCell.nib, forCellReuseIdentifier: ReviewsTableViewCell.identifier)
    }
/// this methode executes the movie api for recommendation from an Id Movie
    func executeRecomendations(){
        movieAPI.getMovies(endpoint: .getRecommendations(id: movie?.id ?? 0)) { result in
            self.group.leave()
            switch result {
            case .success(let response):
                self.similarMovies = response.results ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    
/// this methode executes the movie api for similar from an Id Movie
    func executeSimilarMovies(){
        movieAPI.getMovies(endpoint: .getSimilars(id: movie?.id ?? 0)) { result in
            self.group.leave()
            switch result {
            case .success(let response):
                self.recomendationsMovies = response.results ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TableView's DataSource

extension DetailMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsDetailMovie.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionsDetailMovie.init(rawValue: indexPath.section){
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoMovieTableViewCell.identifier, for: indexPath) as? InfoMovieTableViewCell,let movie = movie else{return UITableViewCell()}
            
            cell.setInfo(for: movie)
            return cell
        case .recommendations, .similar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarruselMovieTableViewCell.identifier, for: indexPath) as? CarruselMovieTableViewCell else{return UITableViewCell()}
            
            return cell
        case .reviews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell else{return UITableViewCell()}

            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
}

// MARK: - TableView's Delegate

extension DetailMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
