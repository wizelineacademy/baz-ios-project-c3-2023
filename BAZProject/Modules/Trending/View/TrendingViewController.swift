//
//  TrendingViewController+HeaderBarViewControllerDelegate.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController, TrendingViewProtocol {

    @IBOutlet weak var moviesTableView: UITableView!
    
    var movies: [MovieResult] = []
    let mediaType: MediaType = .movie
    var errorGetData: Bool = false
    
    var presenter: TrendingPresenterProtocol?
    static let nibName = "TrendingView"

    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesTableView.register(CellMovie.nib(), forCellReuseIdentifier: CellMovie.identifier)
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if errorGetData {
            getData()
        }
    }

    func getData() {
        view.showLoader()
        presenter?.getTrendingMedia(mediaType: mediaType, timeWindow: .day)
    }
    
    func updateView(data: [MovieResult]) {
        movies = data
        moviesTableView.reloadData()
    }
    
    func stopLoading() {
        view.removeLoader()
    }
    
    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}


