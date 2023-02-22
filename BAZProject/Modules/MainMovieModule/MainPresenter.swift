//
//  MainPresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

final class MainPresenter: NSObject {
    var view: MainViewProtocol?
    var interactor: MainInteractorInputProtocol?
    let dispatchGroup = DispatchGroup()
    
    private func registerTableViewCells(tableView: UITableView) {
        let textFieldCell = UINib(nibName: "MoviesTableViewCell",
                                  bundle: nil)
        tableView.register(textFieldCell,
                                 forCellReuseIdentifier: MoviesTableViewCell.reusableIdentifier)
    }
    
    private func setupUI(tableView: UITableView) {
        tableView.rowHeight = 250
    }
    
    private func makeTableViewCell(cell:inout UITableViewCell, typeUrl: URLApi) -> UITableViewCell {
        if let dataMovies = interactor?.movieApiData.getArrayDataMovie?[typeUrl] as? Movies, let cell = cell as? MoviesTableViewCell {
            UIView.fillSkeletons(onView: cell)
            cell.data = dataMovies
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                UIView.removeSkeletons(onView: cell)
            }
        }
        return cell
    }
    
    private func getDataMovies() {
        interactor?.movieApiData.getArrayDataMovie = [
            .trending: nil,
            .nowPlaying: nil,
            .popular: nil,
            .topRated: nil,
            .upcoming: nil]
        
        interactor?.getMoviesData(from: .topRated, dispatchGroup: dispatchGroup) { self.dispatchGroup.leave() }
        interactor?.getMoviesData(from: .trending, dispatchGroup: dispatchGroup) { self.dispatchGroup.leave() }
        interactor?.getMoviesData(from: .nowPlaying, dispatchGroup: dispatchGroup) { self.dispatchGroup.leave() }
        interactor?.getMoviesData(from: .popular, dispatchGroup: dispatchGroup) { self.dispatchGroup.leave() }
        interactor?.getMoviesData(from: .upcoming, dispatchGroup: dispatchGroup) { self.dispatchGroup.leave() }

        dispatchGroup.notify(queue: .main) {
            self.view?.reloadData()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .countMovieWatch, object: nil)
    }
}

extension MainPresenter: MainPresenterProtocol {
    func goToMovieDetail(data: Movie) {
        guard let view = view as? UIViewController else { return }
        MovieDetailRouter().presentView(from: view, data: data)
    }
    
    func goToSearchMovieView() {
        guard let view = view as? UIViewController else { return }
        SearchMovieRouter().presentView(from: view)
    }
    
    func viewDidLoad(tableView: UITableView) {
        registerTableViewCells(tableView: tableView)
        NotificationCenter.default.addObserver(self, selector: #selector(countMovieWatched), name: .countMovieWatch, object: nil)
        setupUI(tableView: tableView)
        getDataMovies()
    }
    
    @objc func countMovieWatched() {
        interactor?.countMovieWatched += 1
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

extension MainPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.reusableIdentifier) as? MoviesTableViewCell {
            cell.delegate = self
            if let urlIndexSection = URLApi.nothing.indexForSectionMain(for: indexPath.section), let dataMovies = interactor?.movieApiData.getArrayDataMovie?[urlIndexSection] as? Movies {
                
                cell.data = dataMovies
                
            }
            cell.reload()
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
}

extension MainPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10)
        label.text = URLApi.nothing.setTitleForSection(for: section)
        label.font = .boldSystemFont(ofSize: 20)
        
        headerView.addSubview(label)
        
        return headerView
    }
}

extension MainPresenter: MoviesTableViewCellDelagete {
    func didTapped(movie: Movie) {
        goToMovieDetail(data: movie) 
    }
}
