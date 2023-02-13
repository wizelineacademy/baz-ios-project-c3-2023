//
//  MainPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainPresenter {
    weak var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
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
        interactor?.getMoviesData(from: .trending(page: 1))
        registerTableViewCells()
        getSectionSegmentedControl()
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
    
}

extension MainPresenter: MainInteractorOutputProtocol{
    func reloadData(){
        view?.reloadData()
    }
}
