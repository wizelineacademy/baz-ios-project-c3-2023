//
//  MainPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainPresenter: NSObject {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .countMovieWatch, object: nil)
    }
}

extension MainPresenter: MainPresenterProtocol {
    func goToMovieDetail(data: Result) {
        guard let view = view as? UIViewController else { return }
        MovieDetailRouter().presentView(from: view, data: data)
    }
    
    func goToSearchMovieView() {
        guard let view = view as? UIViewController else { return }
        SearchMovieRouter().presentView(from: view)
    }
    
    func viewDidLoad() {
        interactor?.getMoviesData(from: .trending)
        registerTableViewCells()
        getSectionSegmentedControl()
        NotificationCenter.default.addObserver(self, selector: #selector(countMovieWatched), name: .countMovieWatch, object: nil)
    }
    
    @objc func countMovieWatched() {
        interactor?.countMovieWatched += 1
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "MoviesTableViewCell",
                                  bundle: nil)
        view?.tableView.register(textFieldCell,
                                 forCellReuseIdentifier: MoviesTableViewCell.reusableIdentifier)
    }
    
    func getMoviesData(from api: URLApi) {
        interactor?.getMoviesData(from: api)
    }
    
    private func getSectionSegmentedControl(){
        view?.segmentControl.setTitle("Trending", forSegmentAt: 0)
        view?.segmentControl.setTitle("Now Playing", forSegmentAt: 1)
        view?.segmentControl.setTitle("Popular", forSegmentAt: 2)
        view?.segmentControl.setTitle("Top Rated", forSegmentAt: 3)
        view?.segmentControl.setTitle("Upcoming", forSegmentAt: 4)
    }
    
    func getTableViewDataSource() -> UITableViewDataSource {
        return self
    }
    
    func getTableViewDelegate() -> UITableViewDelegate {
        return self
    }
    
}

extension MainPresenter: MainInteractorOutputProtocol{
    func reloadData(){
        view?.reloadData()
    }
}

extension MainPresenter: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = interactor?.movieApiData.getDataMovies as? Movies {
            return data.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reusableIdentifier) as? MoviesTableViewCell {
            
            if let dataMovies = interactor?.movieApiData.getDataMovies as? Movies,
               let image = dataMovies.results[indexPath.row].posterPath {
                
                cell.movieImage.image = UIImage(named: "poster")
                cell.movieTitle.text = dataMovies.results[indexPath.row].title
                
                MovieAPI.getImage(from:  image, handler: { imagen in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        cell.movieImage.image = imagen
                    }
                })
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataMovies = interactor?.movieApiData.getDataMovies as? Movies {
            goToMovieDetail(data: dataMovies.results[indexPath.row])
        }
    }
}
