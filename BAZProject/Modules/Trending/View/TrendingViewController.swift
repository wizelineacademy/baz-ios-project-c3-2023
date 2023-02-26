//
//  TrendingViewController+HeaderBarViewControllerDelegate.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UIViewController, TrendingViewProtocol {
    @IBOutlet weak private var titleFilterLabel: UILabel! {
        didSet {
            titleFilterLabel.text = .trendingTitleFilterTime
        }
    }
    @IBOutlet weak private var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak private var filterTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak private var moviesTableView: UITableView!

    static let identifier: String = .trendingXibIdentifier

    // MARK: - Protocol properties
    var presenter: TrendingPresenterProtocol?

    // MARK: - Private properties
    let mediaType: MediaType = .movie
    private let timeWindowType: TimeWindowType = .day
    private var errorGetData: Bool = false
    private var refreshControl: UIRefreshControl?
    private var loadingMoreView: InfiniteScrollActivityView?
    private var isMoreDataLoading = false
    private var movies: [MovieResult] = []
    private var moviesBack: [MovieResult] = []
    private var isLoading: Bool = true
    private var scrollOffsetThreshold: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLoading || errorGetData {
            showLoader()
        }

        if errorGetData {
            callService()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
        stopLoading()
    }

    @IBAction private func switchedFilterSegmented(_ sender: Any) {
        // TODO: add logic in switched
    }

    @IBAction private func switchedFilterTimeSegmented(_ sender: Any) {
        // TODO: add logic in switched
    }

    func updateView(data: [MovieResult]) {
        movies = data
        moviesBack = data
        guaranteeMainThread {
            self.moviesTableView.reloadData()
        }
    }

    func stopLoading() {
        guaranteeMainThread {
            self.view.removeLoader()
            self.refreshControl?.endRefreshing()
            self.loadingMoreView?.stopAnimating()
            self.presenter?.willHideAlertLoading()
        }
        self.isLoading = false
        self.isMoreDataLoading = false
    }

    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }

    func getTableTitle() -> String {
        return mediaType.getMediaTypeTitle()
    }

    func getDataCount() -> Int {
        return movies.count
    }

    func getMovie(_ index: Int) -> MovieResult? {
        return movies[index]
    }

    // MARK: - Private methods
    private func showLoader() {
        guaranteeMainThread {
            self.view.showLoader()
        }
    }

    private func setupView() {
        initRegister()
        navigationItem.searchController?.searchResultsUpdater = self
        setupRefreshControl()
        setupInfiniteScrollLoadingIndicator()
        setupFilterSegmentedControl()
        addSearchBar()
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .notificacionCenterNameShowDetail, object: nil)
    }

    private func setupFilterSegmentedControl() {
        filterSegmentedControl.removeAllSegments()
        filterTimeSegmentedControl.removeAllSegments()
        setStyleSegmentedControls()

        String.trendingFilterTitles.enumerated().forEach { title in
            filterSegmentedControl.insertSegment(withTitle: title.element, at: title.offset, animated: true)
        }
        String.trendingFilterByTimeTitles.enumerated().forEach { title in
            filterTimeSegmentedControl.insertSegment(withTitle: title.element, at: title.offset, animated: true)
        }
        filterSegmentedControl.selectedSegmentIndex = mediaType.getRawValue()
        filterTimeSegmentedControl.selectedSegmentIndex = timeWindowType.getRawValue()
    }

    private func setStyleSegmentedControls() {
        let titleTextAttributes = [
            NSAttributedString.Key.font: LocalizedConstants.commonSubTitleFont,
            NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor.black]
        filterSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        filterTimeSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        filterSegmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        filterTimeSegmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
    }

    private func setupInfiniteScrollLoadingIndicator() {
        loadingMoreView = InfiniteScrollActivityView(frame: getUIFrame())
        loadingMoreView!.isHidden = true
        moviesTableView.addSubview(loadingMoreView!)
    }

    private func getUIFrame() -> CGRect {
        let frame: CGRect = CGRect(x: 0,
                                   y: getMoviesTableViewContentSizeHeight(),
                                   width: moviesTableView.bounds.size.width,
                                   height: InfiniteScrollActivityView.defaultHeight)
        return frame
    }

    private func initRegister() {
        setTableViewDelegates()
        registerCell()
        moviesTableView.rowHeight = UITableView.automaticDimension
        moviesTableView.separatorColor = .white
    }

    private func setTableViewDelegates() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }

    private func registerCell() {
        moviesTableView.register(CellMovie.nib(),
                                 forCellReuseIdentifier: CellMovie.identifier)
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        guard let refreshControl = refreshControl else { return }
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = String.trendingTitleUpdateTable.getColoredString(color: .white)
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        moviesTableView.insertSubview(refreshControl, at: LocalizedConstants.trendingFirstSubview)
    }

    private func callService() {
        isLoading = true
        getData()
    }

    private func getData() {
        presenter?.willFetchTrendingMedia(mediaType: mediaType, timeWindow: timeWindowType)
    }

    @objc private func refreshControlAction(_ refreshControl: UIRefreshControl) {
        showLoader()
        getData()
    }

    private func getMoviesTableViewContentSizeHeight() -> CGFloat {
        return moviesTableView.contentSize.height
    }

    private func showAlertLoader() {
        presenter?.willShowAlertLoading(with: ErrorType(title: .commonTitleShowAlertLoading,
                                                        message: .commonMessageShowAlertLoading))
    }
}

// MARK: - UIScrollViewDelegate
extension TrendingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffsetThreshold = getMoviesTableViewContentSizeHeight() - moviesTableView.bounds.size.height
        // When the user has scrolled past the threshold, start requesting
        if isMoreDataLoading && (scrollView.contentOffset.y > scrollOffsetThreshold) {
            loadingMoreView?.frame = getUIFrame()
            loadingMoreView?.startAnimating()
            isMoreDataLoading = true
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let scrollPositionY: Double = scrollView.contentOffset.y
        if isMoreDataLoading && (scrollPositionY > scrollOffsetThreshold) || (scrollPositionY < 0) {
            self.showAlertLoader()
            self.getData()
        } else {
            isMoreDataLoading = true
        }
    }
}

extension TrendingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let textSearching = searchController.searchBar.text else { return }
        if !textSearching.isEmpty {
            var moviesTemp: [MovieResult] = []
            movies.forEach { movie in
                if let title = movie.title,
                   title.lowercased().contains(textSearching.lowercased()) {
                    moviesTemp.append(movie)
                }
            }
            movies = moviesTemp
            moviesTableView.reloadData()
        } else {
            movies = moviesBack
            moviesTableView.reloadData()
        }
    }
}
