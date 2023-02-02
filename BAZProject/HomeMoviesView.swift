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
    
    @IBOutlet weak var categoriesMoviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var presenter: HomeMoviesPresenterProtocol?
    internal let minimumInterItemSpacing: CGFloat = CGFloat(8.0)
    internal let cellsPerRow: Int = 2
    internal let insets: CGFloat = CGFloat(8.0)
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoriesCollectionView()
        setupMoviesColletionView()
        presenter?.getTrendingMovies()
    }
    
    func setupCategoriesCollectionView(){
        self.categoriesMoviesCollectionView.delegate = self
        self.categoriesMoviesCollectionView.dataSource = self
        self.categoriesMoviesCollectionView.register(UINib(nibName: "CategoriesMoviesCollectionViewCell", bundle: Bundle(for: HomeMoviesView.self)), forCellWithReuseIdentifier: "CategoriesMoviesCollectionViewCell")
    }
    
    func setupMoviesColletionView(){
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle(for: HomeMoviesView.self)), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
}

extension HomeMoviesView: HomeMoviesViewProtocol {
  
    // TODO: implement view output methods
    
    func loadTrendingMovies() {
        DispatchQueue.main.async {
            self.categoriesMoviesCollectionView.reloadData()
        }
    }
    
    func loadMovies() {
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
    
}


