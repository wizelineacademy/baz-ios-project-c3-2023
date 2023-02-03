//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    @IBOutlet var tableViewMovies: UITableView!
    
    var movies: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUITrendingView()
        settingsForTableBtc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    private func setupUITrendingView() {
//        self.view.backgroundColor = .white
    }
    
    private func fetchMovies() {
        movies = movieApi.getMovies(typeMovie: .popularity) ?? []
        movie = movieApi.getDetailMovie(idMovie: 315162)
        debugPrint(movie)
        tableView.reloadData()
    }
    
    private func settingsForTableBtc() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.separatorStyle = .none
        tableViewMovies.register(UINib.init(nibName: "MovieTableViewCell", bundle: Bundle(for: MovieTableViewCell.self)), forCellReuseIdentifier: "MovieTableViewCell")
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleMovie.text = movies[indexPath.row].title
        let url = URL(string: "https://image.tmdb.org/t/p/original/\((movies[indexPath.row].posterPath) ?? "")")
        
        if let urlString = url {
            cell.imgMovie.load(url: urlString)
        }

        return cell
    }

}

// MARK: - TableView's Delegate
//
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        var config = UIListContentConfiguration.cell()
//        config.text = movies[indexPath.row].title
//        config.image = UIImage(named: "poster")
//        cell.contentConfiguration = config
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
