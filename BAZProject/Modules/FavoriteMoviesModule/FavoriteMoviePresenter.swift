//
//  FavoriteMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class FavoriteMoviePresenter: NSObject {
    weak var view: FavoriteMovieViewProtocol?
    var interactor: FavoriteMovieInteractorInputProtocol?
    let imageProvider = ImageProvider.shared
    
    private func registerResumeTableViewCells(tableView: UITableView) {
        let textFieldCell = UINib(nibName: "GenericTableViewCell",
                                  bundle: nil)
        tableView.register(textFieldCell,
                           forCellReuseIdentifier: GenericTableViewCell.reusableCell)
    }
    
    private func setTableViewCell(cell: GenericTableViewCell, indexPath: Int, data: [Movie] ) {
        UIView.fillSkeletons(onView: cell)
        cell.nameMovie.text = data[indexPath].title
        if let image = data[indexPath].posterPath {
            setImage(cell: cell, image: image)
        }
    }
    
    private func setImage(cell: GenericTableViewCell, image: String) {
        imageProvider.fetchImage(from: image) { image in
            UIView.removeSkeletons(onView: cell)
            cell.posterImage.image = image
        }
    }
}

extension FavoriteMoviePresenter: FavoriteMoviePresenterProtocol, FavoriteMovieInteractorOutputProtocol {
    func goToMovieDetail(data: Movie) {
        guard let view = view as? UIViewController else { return }
        MovieDetailRouter().presentView(from: view, data: data)
    }
    
    func viewDidLoad(tableView: UITableView) {
        SetupUI(tableView: tableView)
    }
    
    public func getFavoriteMovies() {
        interactor?.setIdMovies()
        interactor?.getFavoriteMovies(from: .movie)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            self.view?.reloadData()
        }
    }
    
    private func SetupUI(tableView: UITableView) {
        registerResumeTableViewCells(tableView: tableView)
    }
    
    func getTableViewDataSource() -> UITableViewDataSource {
        return self
    }
    
    func getTableViewDelegate() -> UITableViewDelegate {
        return self
    }
}

extension FavoriteMoviePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let saveMovies = interactor?.getDataMovies else { return 0 }
        return saveMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.reusableCell, for: indexPath) as? GenericTableViewCell, let data = interactor?.getDataMovies  {
            setTableViewCell(cell: cell, indexPath: indexPath.row, data: data)
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoriteMoviePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataMovie = interactor?.getDataMovies {
            goToMovieDetail(data: dataMovie[indexPath.row])
        }
    }
}
