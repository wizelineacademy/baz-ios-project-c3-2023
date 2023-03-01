//
//  MovieDetailsViewController.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/02/23.
//
import UIKit

class MovieDetailsViewController: UIViewController {
    
    var myMovie: Movie?
    var myImage: UIImage?
    var movies: [Movie] = []
    var casting: [Casting] = []
    var castingImages: [UIImage] = []
    let movieApi = MovieAPI()
    var images: [UIImage] = []
    let tableHeight: CGFloat = 200
    var similarMovies: [Movie] = []
    var similarImages: [UIImage] = []
    var recomendedMovies: [Movie] = []
    var recomendedImages: [UIImage] = []

    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblGenres: UILabel!
    @IBOutlet weak var tableCast: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let myMovie = myMovie else { return }
        self.navigationItem.title = myMovie.title
        tableCast.delegate = self
        tableCast.dataSource = self
        lblMovieTitle.text = myMovie.title
        lblDescription.text = myMovie.overview
        lblGenres.text = getGenres(genres: myMovie.genresArray)
        imgMovie.image = myImage
        movieApi.movieID = myMovie.id
        getCast()
        getSimilars()
        getRecommended()
    }
    func getCast(){
        DispatchQueue.global().async { [weak self] in
            self?.casting = self?.movieApi.getCasting() ?? []
            guard let casting =  self?.casting else { return }
            for person in casting {
                let urlString = person.profile_path
                guard let myURL = URL(string: urlString) else { return }
                self?.castingImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async {
                    self?.tableCast.reloadData()
                }
            }
        }
    }
    func getSimilars(){
        DispatchQueue.global().async { [weak self] in
            self?.similarMovies = self?.movieApi.getMovies(ofType: .similar) ?? []
            guard let myMovies =  self?.movies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.similarImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
            }
        }
    }
    func getRecommended(){
        DispatchQueue.global().async { [weak self] in
            self?.recomendedMovies = self?.movieApi.getMovies(ofType: .recommended) ?? []
            guard let myMovies =  self?.movies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.recomendedImages.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
            }
        }
    }
}

   
    // MARK: - TableView's DataSource

extension MovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "castTableViewCell")!
    }
}

    // MARK: - TableView's Delegate

extension MovieDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableHeight
    }
}
