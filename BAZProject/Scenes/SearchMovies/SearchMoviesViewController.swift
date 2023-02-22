//
//  SearchMoviesViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol SearchMoviesDisplayLogic: AnyObject {
    func displayFetchMovies(viewModel: SearchMovies.FetchMovies.ViewModel)
    func displayResetCollection(viewModel: SearchMovies.ResetSearch.ViewModel)
}

class SearchMoviesViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var moviesSectionView: UIView!
    
    // MARK: Properties VIP
    var interactor: SearchMoviesInteractor?
    
    // MARK: Properties
    lazy var searchBar: UISearchBar? = {
        let view = UISearchBar(frame: .zero)
        view.sizeToFit()
        view.placeholder = "Search"
        return view
    }()
    lazy var loadMoreButton: UIButton = {
        let view = UIButton()
        view.setTitle("Load More", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    let manager = CarruselCollectionManager()
    let collectionView = CarruselCollectionView(direction: .vertical)
    var carruselCollectionDelegate: CarruselCollectionDelegate?
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSearchViewInNavigation()
        configureMoviesCollectionView()
        hideKeyboardWhenTappedAround()
        searchBar?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar?.becomeFirstResponder()
    }

    // MARK: Setup
    func setup() {
        let viewController = self
        let interactor = SearchMoviesInteractor()
        let presenter = SearchMoviesPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func addSearchViewInNavigation() {
        guard let searchBar = searchBar else {
            return
        }
        let rightButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func configureMoviesCollectionView() {
        manager.setupCollection(collection: collectionView, delegate: self)
        
        moviesSectionView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: moviesSectionView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: moviesSectionView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: moviesSectionView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: moviesSectionView.bottomAnchor).isActive = true
    }
    
    private func configureLoadMoreButton() {
        moviesSectionView.addSubview(loadMoreButton)
        loadMoreButton.centerXAnchor.constraint(equalTo: moviesSectionView.centerXAnchor).isActive = true
        loadMoreButton.bottomAnchor.constraint(equalTo: moviesSectionView.bottomAnchor, constant: -30).isActive = true
        loadMoreButton.leadingAnchor.constraint(equalTo: moviesSectionView.leadingAnchor, constant: 20).isActive = true
        loadMoreButton.trailingAnchor.constraint(equalTo: moviesSectionView.trailingAnchor, constant: -20).isActive = true
        loadMoreButton.heightAnchor.constraint(equalTo: moviesSectionView.heightAnchor, multiplier: 0.08).isActive = true
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        searchBar?.endEditing(true)
    }
}

extension SearchMoviesViewController: SearchMoviesDisplayLogic {
    func displayFetchMovies(viewModel: SearchMovies.FetchMovies.ViewModel) {
        if viewModel.displayedMovies.count != 0 {
            manager.dataCollection = viewModel.displayedNextPage ? (manager.dataCollection ?? []) + viewModel.displayedMovies : viewModel.displayedMovies
        }
    }
    
    func displayResetCollection(viewModel: SearchMovies.ResetSearch.ViewModel) {
        manager.dataCollection = viewModel.dataCollection
    }
}

extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor?.searchMoviesBy(request: SearchMovies.FetchMovies.Request(byKeyboards: searchBar.text ?? ""))
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            interactor?.resetSearch(request: SearchMovies.ResetSearch.Request())
        }
    }
}

extension SearchMoviesViewController: CarruselCollectionDelegate {
    func displayedLastItem() {
        interactor?.searchMoviesBy(request: SearchMovies.FetchMovies.Request(byKeyboards: searchBar?.text ?? "", nextPage: true))
    }
}
