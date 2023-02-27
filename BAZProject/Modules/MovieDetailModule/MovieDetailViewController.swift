//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

enum ImageBarButtonItem {
    case heart
    case heartFill
    
    var nameImage: String {
        switch self {
        case .heart:
            return "heart"
        case .heartFill:
            return "heart.fill"
        }
    }
}

final class MovieDetailView: UIViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playVideo: UIButton!
    
    var presenter: MovieDetailPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(poster: &poster, tableView: tableView)
        setDelegates()
        
        playVideo.setTitle("", for: .normal)
        navigationItem.backButtonTitle = ""
        setupUI()
    }
    
    func setupUI() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        isFavorite()
    }
    
    private func isFavorite() {
        if IsSaveMovie() {
            makeUIBarButtonItem(image: .heartFill)
        } else {
            makeUIBarButtonItem(image: .heart)
        }
    }
    
    private func makeUIBarButtonItem(image: ImageBarButtonItem) {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: image.nameImage), style: .plain, target: self, action: #selector(addFavorite))
        self.navigationItem.rightBarButtonItem  = rightButton
    }
    
    private func setImageToBarButtonItem(image: ImageBarButtonItem) {
        self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: image.nameImage)
    }
    
    private func setDelegates() {
        tableView.delegate = presenter?.getTableViewDelegate()
        tableView.dataSource = presenter?.getTableViewDataSource()
    }
    
    @objc func addFavorite() {
        if IsSaveMovie() {
            presenter?.deleteToFavoriteMovie()
            setImageToBarButtonItem(image: .heart)
        } else {
            presenter?.saveFavoriteMovie()
            setImageToBarButtonItem(image: .heartFill)
        }
    }
    
    private func IsSaveMovie() -> Bool {
        if let idMovie = presenter?.interactor?.data?.id, !(presenter?.interactor?.saveData.isSave(title: .favoriteMovies, idMovie: idMovie) ?? true) {
            return false
        } else {
            return true
        }
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    func reloadData(){
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
