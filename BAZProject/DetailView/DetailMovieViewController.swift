//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

enum SectionsDetailMovie: Int, CaseIterable {
    case header = 0
    case reviews = 1
    case similar = 2
    case recommendations = 3
}

class DetailMovieViewController: UIViewController {
    
    @IBOutlet weak var tblDetailMovie: UITableView!
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movie?.title
        setupTable()
        // Do any additional setup after loading the view.
    }
    
    private func setupTable(){
        tblDetailMovie.delegate = self
        tblDetailMovie.dataSource = self
        tblDetailMovie.register(InfoMovieTableViewCell.nib, forCellReuseIdentifier: InfoMovieTableViewCell.identifier)
        tblDetailMovie.register(CarruselMovieTableViewCell.nib, forCellReuseIdentifier: CarruselMovieTableViewCell.identifier)
        tblDetailMovie.register(ReviewsTableViewCell.nib, forCellReuseIdentifier: ReviewsTableViewCell.identifier)
    }
    
}

// MARK: - TableView's DataSource

extension DetailMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionsDetailMovie.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionsDetailMovie.init(rawValue: indexPath.section){
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoMovieTableViewCell.identifier, for: indexPath) as? InfoMovieTableViewCell,let movie = movie else{return UITableViewCell()}
            
            cell.setInfo(for: movie)
            return cell
        case .recommendations, .similar:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarruselMovieTableViewCell.identifier, for: indexPath) as? CarruselMovieTableViewCell else{return UITableViewCell()}
            
      
            return cell
        case .reviews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell else{return UITableViewCell()}

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
