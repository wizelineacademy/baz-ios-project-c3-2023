//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

enum SectionsDetailMovie: Int, CaseIterable {
    case header = 0
    case actors = 1
    case reviews = 2
    case similar = 3
    case recommendations = 4
    
    var title: String? {
        switch self {
        case .header:
            return nil
        case .reviews:
            return "Reviews"
        case .similar:
            return "Similar Movies"
        case .recommendations:
            return "Recommended Movies"
        case .actors:
           return "Cast"
        }
    }
}

final class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var tblDetailMovie: UITableView!
    var movie: Movie?
    private let group = DispatchGroup()
    private let movieAPI = MovieAPI()
    private var similarMovies: [Movie]?
    private var recomendationsMovies: [Movie]?
    private var reviews: [Review]?
    private var casts: [Cast]?
    private var contador: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.post(name: .contadorReviews, object: nil)
        contador = UserDefaults.standard.integer(forKey: "contador")
        self.title = "Detail Movie: \(contador ?? 0)👀 "

        setupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        group.enter()
        group.enter()
        group.enter()
        group.enter()
        executeRecomendations()
        executeSimilarMovies()
        executeReviews()
        executeCast()
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
        tblDetailMovie.register(ActorCarruselTableViewCell.nib, forCellReuseIdentifier: ActorCarruselTableViewCell.identifier)
    }
    /// this methode executes the movie api for recommendation from an Id Movie
    func executeRecomendations(){
        movieAPI.getMovies(endpoint: .getRecommendations(id: movie?.id ?? 0)) { result in
            switch result {
            case .success(let response):
                self.similarMovies = response.results ?? []
            case .failure(let error):
                print(error)
            }
            self.group.leave()
        }
    }
    
    /// this methode executes the movie api for similar from an Id Movie
    func executeSimilarMovies(){
        movieAPI.getMovies(endpoint: .getSimilars(id: movie?.id ?? 0)) { result in
            switch result {
            case .success(let response):
                self.recomendationsMovies = response.results ?? []
            case .failure(let error):
                print(error)
            }
            self.group.leave()
        }
    }
    
    /// this methode executes the movie api for `Review` from an Id Movie
    func executeReviews(){
        movieAPI.getReviews(endpoint: .getReviews(id: movie?.id ?? 0)) { result in
            switch result {
            case .success(let response):
                self.reviews = response.results ?? []
            case .failure(let error):
                print(error)
            }
            self.group.leave()
        }
    }
    
    /// this methode executes the movie api for `Cast`  from an Id Movie
    func executeCast(){
        movieAPI.getCast(endpoint: .getCredits(id: movie?.id ?? 0)) { result in
            switch result {
            case .success(let response):
                self.casts = response.cast ?? []
            case .failure(let error):
                print(error)
            }
            self.group.leave()
        }
    }
}

// MARK: - TableView's DataSource

extension DetailMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsDetailMovie.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionsDetailMovie = SectionsDetailMovie.init(rawValue: section) ?? .header
        switch sectionsDetailMovie {
        case .header:
            return 1
        case .reviews:
            return reviews?.count ?? 0 > 0 ? 1 : 0
        case .similar:
            return similarMovies?.count ?? 0 > 0 ? 1 : 0
        case .recommendations:
            return recomendationsMovies?.count ?? 0 > 0 ? 1 : 0
        case .actors:
            return casts?.count ?? 0 > 0 ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionsDetailMovie = SectionsDetailMovie.init(rawValue: section) ?? .header
        return sectionsDetailMovie.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionsDetailMovie.init(rawValue: indexPath.section){
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoMovieTableViewCell.identifier, for: indexPath) as? InfoMovieTableViewCell,let movie = movie else{return UITableViewCell()}
            
            cell.setInfo(for: movie)
            return cell
        case .actors:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ActorCarruselTableViewCell.identifier, for: indexPath) as? ActorCarruselTableViewCell,let casts = casts else{return UITableViewCell()}
            
            cell.setInfo(for: casts)
            return cell
        case .recommendations:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarruselMovieTableViewCell.identifier, for: indexPath) as? CarruselMovieTableViewCell,let movies = recomendationsMovies else{return UITableViewCell()}
            cell.setInfo(for: movies)
            return cell
        case .similar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarruselMovieTableViewCell.identifier, for: indexPath) as? CarruselMovieTableViewCell, let movies = similarMovies else{return UITableViewCell()}
            cell.setInfo(for: movies)
            return cell
        case .reviews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell, let reviews = reviews  else{return UITableViewCell()}
            cell.setInfo(for: reviews)
            
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
