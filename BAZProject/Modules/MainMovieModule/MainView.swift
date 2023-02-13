//
//  MainView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainView: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol?
    var movies: Movies?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        presenter?.viewDidLoad()
    }
    
    @IBAction func goToSeachView() {
        presenter?.goToSearchMovieView()
    }
    
    @IBAction func didChangeSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presenter?.getMoviesData(from: .trending(page: 1))
        case 1:
            presenter?.getMoviesData(from: .nowPlaying(page: 1))
        case 2:
            presenter?.getMoviesData(from: .popular(page: 1))
        case 3:
            presenter?.getMoviesData(from: .topRated(page: 1))
        case 4:
            presenter?.getMoviesData(from: .upcoming)
        default:
            debugPrint("No segmented found")
        }
    }
    
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = presenter?.interactor?.movieApiData.getDataMovies as? Movies {
            return data.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reusableIdentifier) as? MoviesTableViewCell {
            
            if let dataMovies = presenter?.interactor?.movieApiData.getDataMovies as? Movies,
               let image = dataMovies.results[indexPath.row].posterPath {
                
                cell.movieImage.image = UIImage(named: "poster")
                cell.movieTitle.text = dataMovies.results[indexPath.row].title
                
                MovieAPI.getImage(from:  image, handler: { imagen in
                    DispatchQueue.main.async {
                        cell.movieImage.image = imagen
                    }
                })
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataMovies = presenter?.interactor?.movieApiData.getDataMovies as? Movies {
            presenter?.goToMovieDetail(data: dataMovies.results[indexPath.row])
        }
    }
}
