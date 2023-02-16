//
//  HomeMovies.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class HomeMoviesView: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAddFilters: UIButton!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var collectionHomeMovie: UICollectionView!

    // MARK: - Properties
    private typealias Constants = MovieConstants
    var presenter: HomeMoviesPresenterProtocol?
    var isSearching: Bool = false
    var searchTerm: String = ""
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    let categoryPickerData: [MovieCategory] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createPickerView()
        createToolbar()
    }
    
    private func setupView(){
        self.title = "\(self.presenter?.selectedCategory?.typeName ?? MovieCategory.trending.typeName)"
        self.headerView.initConfig(title: Constants.headerTitleView)
        self.btnAddFilters.setTitle(MovieConstants.titleFilterButton, for: .normal)
        self.searchBar.delegate = self
        self.presenter?.loadingView()

        collectionHomeMovie.register(UINib(nibName: MovieCollectionCell.cellIdentifier, bundle: Bundle(for: MovieCollectionCell.self)),
                                     forCellWithReuseIdentifier: MovieCollectionCell.cellIdentifier)
    }

    @IBAction func filterPicker(_ sender: UIButton) {
        self.view.addSubview(picker)
        self.view.addSubview(toolBar)
    }
}
