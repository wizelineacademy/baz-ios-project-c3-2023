//
//  TrendingViewController+HeaderBarViewControllerDelegate.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UIViewController, TrendingViewProtocol {
    
    @IBOutlet weak var titleFilterLabel: UILabel! {
        didSet {
            titleFilterLabel.text = .trendingTitleFilterTime
        }
    }
    @IBOutlet weak var filterSegmentedControl: UISegmentedControl!
    @IBOutlet weak var filterTimeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var moviesTableView: UITableView!
    
    static let identifier: String = .trendingXibIdentifier

    // MARK: - Protocol properties
    var presenter: TrendingPresenterProtocol?
    
    // MARK: - Private properties
    private let mediaType: MediaType = .movie
    private let timeWindowType: TimeWindowType = .day
    private var errorGetData: Bool = false
    private var refreshControl: UIRefreshControl?
    private var loadingMoreView: InfiniteScrollActivityView?
    private var isMoreDataLoading = false
    private var movies: [MovieResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        callServiceAndShowLoader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if errorGetData {
            callServiceAndShowLoader()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopLoading()
    }

    @IBAction func switchedFilterSegmented(_ sender: Any) {
        // TODO: add logic in switched
    }
    
    @IBAction func switchedFilterTimeSegmented(_ sender: Any) {
        // TODO: add logic in switched
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
            self.refreshControl?.endRefreshing()
            self.loadingMoreView?.stopAnimating()
        }
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
    
    private func callServiceAndShowLoader() {
        view.showLoader()
        getData()
    }
    
    private func setupView() {
        initRegister()
        setupRefreshControl()
        setupInfiniteScrollLoadingIndicator()
        setupFilterSegmentedControl()
    }

    private func setupFilterSegmentedControl() {
        filterSegmentedControl.removeAllSegments()
        filterTimeSegmentedControl.removeAllSegments()
        String.trendingFilterTitles.enumerated().forEach { title in
            filterSegmentedControl.insertSegment(withTitle: title.element, at: title.offset, animated: true)
        }
        String.trendingFilterByTimeTitles.enumerated().forEach { title in
            filterTimeSegmentedControl.insertSegment(withTitle: title.element, at: title.offset, animated: true)
        }
        filterSegmentedControl.selectedSegmentIndex = mediaType.getRawValue()
        filterTimeSegmentedControl.selectedSegmentIndex = timeWindowType.getRawValue()
        
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
        refreshControl.tintColor = .blue
        refreshControl.attributedTitle = String.trendingTitleUpdateTable.getColoredString(color: .blue)
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControl.Event.valueChanged)
        moviesTableView.insertSubview(refreshControl, at: LocalizedConstants.trendingFirstSubview)
    }

    private func getData() {
        presenter?.willFetchTrendingMedia(mediaType: mediaType, timeWindow: timeWindowType)
    }
    
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getData()
    }
    
    private func getMoviesTableViewContentSizeHeight() -> CGFloat {
        return moviesTableView.contentSize.height
    }
}

// MARK: - UIScrollViewDelegate
extension TrendingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreDataLoading {
            let scrollOffsetThreshold = getMoviesTableViewContentSizeHeight() - moviesTableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if (scrollView.contentOffset.y > scrollOffsetThreshold) && moviesTableView.isDragging {
                isMoreDataLoading = true
                loadingMoreView?.frame = getUIFrame()
                loadingMoreView?.startAnimating()
                getData()
            }
        }
    }
}
