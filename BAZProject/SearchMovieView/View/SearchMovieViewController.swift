//
//  SearchMovieViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

final class SearchMovieViewController: UIViewController, SearchView {
    
    @IBOutlet weak var tfWordSearch: UITextField!
    @IBOutlet weak var collectionViewSearch: UICollectionView!
    @IBOutlet weak var viewConatinerSearch: UIView!
    
    let NUMBER_ONE = 1
    var moviesSearch: [Movie] = [] {
        didSet{
            DispatchQueue.main.async { [weak self] in
                self?.collectionViewSearch.reloadData()
            }
        }
    }
    let notificationCenter = NotificationCenter.default
    var viewModel: SearchMovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchMovieViewModel(view: self)
        addGestureKeyboard()
        registerCollectionViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationObserver()
        setUINavigation()
        setUISearchView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self)
    }
    
    /**
     Add center notification name CountMoviesNotification to ViewController
     */
    private func addNotificationObserver() {
        let notificationName = Notification.Name("CountMoviesNotification")
        notificationCenter.addObserver(self, selector: #selector(countMovies(_:)), name: notificationName, object: nil)
    }
    
    private func setUINavigation() {
        self.title = "Search movie"
        self.tabBarController?.tabBar.isHidden = false
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    private func setUISearchView() {
        viewConatinerSearch.layer.cornerRadius = 10
    }
    
    private func addGestureKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    private func registerCollectionViewCell() {
        let bundle = Bundle(for: CarouselCollectionViewCell.self)
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.register(UINib(nibName: "CarouselCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "CarouselCollectionViewCell")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func getNumberItemsCollcetionView() -> Int {
        moviesSearch.count > 6 ? 6 : moviesSearch.count
    }
    
    @IBAction func onTapSearchButton(_ sender: Any) {
        viewModel?.fetchSearchMovies(query: tfWordSearch.text ?? "")
        self.view.endEditing(true)
        self.collectionViewSearch.reloadData()
    }
    
    @objc func countMovies(_ sender: Any) {
        HomeMoviesViewController.countMoviesUser += 1
    }
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return UtilsMoviesApp.shared.NUMBER_ONE
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getNumberItemsCollcetionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewSearch.dequeueReusableCell(withReuseIdentifier: "CarouselCollectionViewCell", for: indexPath) as! CarouselCollectionViewCell
        
        let url = moviesSearch[indexPath.row].getUrlImg(posterPath: moviesSearch[indexPath.row].posterPath ?? "")
        if let urlString = url { cell.imgMovie.load(url: urlString) }
        
        cell.imgMovie.contentMode = .scaleAspectFill
        cell.delegate = self
        cell.idMovie = moviesSearch[indexPath.row].id ?? 0
        cell.addGestureImg()
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UtilsMoviesApp.shared.WIDTH_CELL, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth : CGFloat = UtilsMoviesApp.shared.WIDTH_CELL
        
        let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
        let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: 15, left: edgeInsets, bottom: 0, right: edgeInsets)        
    }
}

extension SearchMovieViewController: TapGestureImgMovieProtocol {
    func tapGestureImgMovie(idMovie: Int?, typeMovieList: TypeMovieList?) {
        let module = DetailsMovieViewController()
        module.specificMovie = moviesSearch.first(where: { $0.id == idMovie
        })
        self.navigationController?.pushViewController(module, animated: false)
    }
}
