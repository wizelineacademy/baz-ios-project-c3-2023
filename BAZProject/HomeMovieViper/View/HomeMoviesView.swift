//
//  HomeMoviesView.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import UIKit

class HomeMoviesView: UIViewController, CategoriesMoviesCellDelegate {
    // MARK: Properties
    
    @IBOutlet weak var categoriesMoviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var presenter: HomeMoviesPresenterProtocol?
    internal let minimumInterItemSpacing: CGFloat = CGFloat(8.0)
    internal let cellsPerRow: Int = 2
    internal let insets: CGFloat = CGFloat(8.0)
    weak var currentlySelected: CategoriesMoviesCollectionViewCell?
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoriesCollectionView()
        setupMoviesColletionView()
        presenter?.viewDidLoad()
    }
    
    func setupCategoriesCollectionView() {
        self.categoriesMoviesCollectionView.delegate = self
        self.categoriesMoviesCollectionView.dataSource = self
        self.categoriesMoviesCollectionView.register(UINib(nibName: "CategoriesMoviesCollectionViewCell", bundle: Bundle(for: HomeMoviesView.self)), forCellWithReuseIdentifier: "CategoriesMoviesCollectionViewCell")
    }
    
    func setupMoviesColletionView() {
        self.moviesCollectionView.delegate = self
        self.moviesCollectionView.dataSource = self
        self.moviesCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle(for: HomeMoviesView.self)), forCellWithReuseIdentifier: "MovieCollectionViewCell")
    }
    
    func didSelectCell(indexPath: IndexPath, cell: CategoriesMoviesCollectionViewCell) {
        if currentlySelected?.indexPathRow != indexPath.row{
            currentlySelected?.setCellDeselected()
            currentlySelected = cell
            presenter?.selectFilterMovies(index: indexPath.row)
            categoriesMoviesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @IBAction func didSelectSearchButton(_ sender: Any) {
        presenter?.goToSearch()
    }
    
    @IBAction func didSelectRecentButton(_ sender: Any) {
        presenter?.goToRecent()
    }
}

extension HomeMoviesView: HomeMoviesViewProtocol {
    
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
    
    func showNotRecentAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Not Recents", message: "You haven´t seen a movie yet", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func poopToRoot() {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}


