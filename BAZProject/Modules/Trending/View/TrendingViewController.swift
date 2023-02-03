//
//  TrendingViewController+HeaderBarViewControllerDelegate.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UIViewController, TrendingViewProtocol {

    @IBOutlet weak var moviesTableView: UITableView!
    
    var movies: [MovieResult] = []
    private let mediaType: MediaType = .movie
    private var errorGetData: Bool = false
    
    var presenter: TrendingPresenterProtocol?
    static let identifier: String = .trendingXibIdentifier

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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopLoading()
    }

    func updateView(data: [MovieResult]) {
        movies = data
        guaranteeMainThread {
            self.moviesTableView.reloadData()
        }
    }
    
    func stopLoading() {
        guaranteeMainThread {
            self.view.removeLoader()
        }
    }
    
    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
    
    func getTableTitle() -> String {
        return mediaType.getMediaTypeTitle()
    }
    
    // MARK: - Private methods
    private func getData() {
        view.showLoader()
        presenter?.getTrendingMedia(mediaType: mediaType, timeWindow: .day)
    }
}
