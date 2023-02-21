//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by hlechuga on 16/02/23.
//

import UIKit

class MovieDetailView: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var tblDetailsMovie: UITableView!
    
    //MARK: - Properties
    var presenter: MovieDetailViewOutputProtocol?
    var movie: Movie?
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //presenter?.fetchModel()
        setupView()
    }
    
    //MARK: - Functions
    private func setupView() {
        tblDetailsMovie.delegate = self
        tblDetailsMovie.dataSource = self
        tblDetailsMovie.register(PosterTableViewCell.nib(), forCellReuseIdentifier: PosterTableViewCell.identifier)
        tblDetailsMovie.register(ReviewTableViewCell.nib() , forCellReuseIdentifier: ReviewTableViewCell.identifier)
       }
}

//MARK: - Extensions
extension MovieDetailView: MovieDetailViewIntputProtocol {
    func loadView(from model: Movie) {
        title = model.title
    }
}

//MARK: - UITableViewDetegate and DataSource
extension MovieDetailView: UITableViewDelegate {}
extension MovieDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 1:
            return "Reseña"
        case 2:
            return "Reparto"
        case 3:
            return "Peliculas Similares"
        case 4:
            return "Peliculas Recomendadas"
        case 5:
            return "Reseñas de la película"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: PosterTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as? PosterTableViewCell else { return UITableViewCell()}
            cell.configure(with: movie?.posterImagefullPath ?? "")
            return cell
        case 1:
            guard let cell: ReviewTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell()}
            cell.configure(with: movie?.overview ?? "")
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 300.0
        case 1:
            return 200.0
        default:
            return 50.0
        }
    }
    
}
