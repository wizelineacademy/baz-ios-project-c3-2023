//
//  HomeMoviesView.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation
import UIKit

class HomeMoviesView: UIViewController{

    // MARK: Properties
    
    @IBOutlet weak var trendingMoviesCollectionView: UICollectionView!
    
    var presenter: HomeMoviesPresenterProtocol?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrendingCollectionView()
        presenter?.getTrendingMovies()
    }
    
    func setupTrendingCollectionView(){
        self.trendingMoviesCollectionView.dataSource = self
        self.trendingMoviesCollectionView.register(UINib(nibName: "TrendingMoviesCollectionViewCell", bundle: Bundle(for: HomeMoviesView.self)), forCellWithReuseIdentifier: "TrendingMoviesCollectionViewCell")
    }
}

// MARK: - TableView's DataSource

extension HomeMoviesView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getTrendingMovieCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMoviesCollectionViewCell", for: indexPath) as? TrendingMoviesCollectionViewCell
        else { return UICollectionViewCell() }
        
        cell.setupTrendingImage(urlImage: presenter?.getOneTrendingMovie(index: indexPath.row).backdrop_path ?? "")
        cell.titleTrendingMovieLabel.text = presenter?.getOneTrendingMovie(index: indexPath.row).title ?? ""
        
        return cell
    }
    
}

extension HomeMoviesView: HomeMoviesViewProtocol {
    // TODO: implement view output methods
    
    func loadTrendingMovies() {
        DispatchQueue.main.async {
            self.trendingMoviesCollectionView.reloadData()
        }
    }
    
}


