//
//  SearchMoviesViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol SearchMoviesDisplayLogic: AnyObject {
    // TODO: create functions to manage display logic
    
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
        view.becomeFirstResponder()
        
        return view
    }()
    let manager = CarruselCollectionManager()
    let collectionView = CarruselCollectionView(direction: .vertical)
    
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
        collectionView.backgroundColor = .brown
        manager.setupCollection(collection: collectionView)
        
        moviesSectionView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: moviesSectionView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: moviesSectionView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: moviesSectionView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: moviesSectionView.bottomAnchor).isActive = true
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
    // TODO: conform SearchMoviesDisplayLogic protocol

}
