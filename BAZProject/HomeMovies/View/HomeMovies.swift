//
//  HomeMovies.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class HomeMoviesView: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnAddFilters: UIButton!
    @IBOutlet weak var dateHeaderView: DateHeaderView!
    @IBOutlet weak var collectionHomeMovie: UICollectionView!

    // MARK: - Properties
    typealias Constants = MovieConstants
    var presenter: HomeMoviesPresenterProtocol?
    var isSearching: Bool = false
    var searchTerm: String = ""
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    let categoryPickerData: [MovieCategory] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]
    var limitControlCell: Int = 0
    var foundResults: Bool = true

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createPickerView()
        createToolbar()
    }
    
    private func setupView(){
        self.title = "\(self.presenter?.selectedCategory?.typeName ?? MovieCategory.trending.typeName)"
        self.dateHeaderView.initConfig(title: Constants.headerTitleView)
        self.btnAddFilters.setTitle("", for: .normal)
        self.searchBar.delegate = self
        self.presenter?.loadingView()

        collectionHomeMovie.register(UINib(nibName: MovieCollectionCell.cellIdentifier, bundle: Bundle(for: MovieCollectionCell.self)),
                                     forCellWithReuseIdentifier: MovieCollectionCell.cellIdentifier)
        collectionHomeMovie.register(EmptyMoviesCollectionCell.self, forCellWithReuseIdentifier: EmptyMoviesCollectionCell.cellIdentifier)

        self.collectionHomeMovie.delegate = self
        self.collectionHomeMovie.dataSource = self
        hideKeyboardWhenTappedAround()
    }

    @IBAction func filterPicker(_ sender: UIButton) {
        self.view.addSubview(picker)
        self.view.addSubview(toolBar)
    }
}
