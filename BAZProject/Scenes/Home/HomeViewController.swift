//
//  HomeViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol HomeDisplayLogic: AnyObject {
    // TODO: create functions to manage display logic
}

class HomeViewController: UIViewController {
    
    // MARK: Properties VIP
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Properties
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let sections: [fetchMoviesTypes] = [.nowPlaying, .popular, .topRated, .trending, .upComing]
    
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollViewToView()
        loadMoviesSectionViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Setup
    func setup() {
        // TODO: setup VIP Module
    }
    
    private func loadMoviesSectionViews() {
        sections.forEach { section in
            addMoviesSectionView(section: section)
        }
    }
    
    private func addMoviesSectionView(section: fetchMoviesTypes) {
        let sectionView = MoviesSectionView()
        sectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        scrollViewContainer.addArrangedSubview(sectionView)
    }
    
    private func addScrollViewToView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}

extension HomeViewController: HomeDisplayLogic {
    // TODO: conform HomeDisplayLogic protocol
}
