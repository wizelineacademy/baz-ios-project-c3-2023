//
//  DetailViewController.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

final class DetailViewController: UIViewController {
    static let identifier: String = .detailXibIdentifier
    // MARK: - Protocol properties
    var presenter: DetailPresenterProtocol?
    var idMovie: String?

    // MARK: - Private properties
    private var reviews: [ReviewResult] = []
    private var firstReview: [ReviewResult] = []
    private var similarMovies: [SimilarMovieModelResult] = []
    private var movieRecomendations: [RecomendationMovieModelResult] = []

    var heightCells: [Int: CGFloat] = [:]

    @IBOutlet weak private var backdropPathSlider: ImageSlider!
    @IBOutlet weak private var similarMoviesSlider: ImageSlider!
    @IBOutlet weak var movieRecomendationsSlider: ImageSlider!
    @IBOutlet weak private var titleLabelText: UILabel! {
        didSet {
            titleLabelText.addShadow()
        }
    }
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var titleReviewsLabel: UILabel! {
        didSet {
            titleReviewsLabel.font = LocalizedConstants.commonTitleFont
            titleReviewsLabel.addShadow()
        }
    }
    @IBOutlet weak var reviewsTableView: UITableView!
    @IBOutlet weak var heightReviewTableView: NSLayoutConstraint!
    @IBOutlet weak private var showAllTop: UIButton! {
        didSet {
            showAllTop.setTitle(.detailShowAllTitle, for: .normal)
            showAllTop.addShadow(.white)
        }
    }
    @IBOutlet weak private var showAllBottom: UIButton! {
        didSet {
            showAllBottom.setTitle(.detailShowAllTitle, for: .normal)
            showAllBottom.addShadow(.white)
        }
    }
    @IBOutlet weak var titleSimilarMoviesLabel: UILabel! {
        didSet {
            titleSimilarMoviesLabel.text = .detailTitleSimilarMovies
        }
    }
    @IBOutlet weak var titleMovieRecomendationsLabel: UILabel! {
        didSet {
            titleMovieRecomendationsLabel.text = .detailTitleMovieRecomendations
        }
    }
    @IBOutlet weak var uiViewContainerMovieRecomendations: UIView!
    @IBOutlet weak private var uiViewContainerSimilarMovie: UIView!
    @IBOutlet weak var starRatedView: StarRatedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initRegister()
        getData()
        postIdMedia()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let presenter = presenter else { return }
        if presenter.isLoading() {
            showLoader()
        }

        if presenter.errorGettingData() {
            getData()
        }

        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        backdropPathSlider.stopTimmer()
        similarMoviesSlider.stopTimmer()
        movieRecomendationsSlider.stopTimmer()
        navigationController?.navigationBar.prefersLargeTitles = true
        stopLoading()
    }

    func getReviewsCount() -> Int {
        return firstReview.count
    }

    func dataIsEmpty() -> Bool {
        return firstReview.isEmpty
    }

    func getReview(_ index: Int) -> ReviewResult? {
        return firstReview[index]
    }

    func getTableViewCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if dataIsEmpty() {
            cell = getCellEmptyState(tableView: tableView, indexPath: indexPath)
        } else {
            cell = getCellReview(tableView: tableView, indexPath: indexPath)
        }
        return cell
    }

    // MARK: - Private methods
    private func showLoader() {
        guaranteeMainThread {
            self.view.showLoader()
        }
    }

    private func setupView(imageUrlArray: [String]) {
        backdropPathSlider.setUp(imageUrlArray: imageUrlArray)
    }

    private func initRegister() {
        setTableViewDelegates()
        registerCell()
        reviewsTableView.rowHeight = UITableView.automaticDimension
    }

    private func setTableViewDelegates() {
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
    }

    private func registerCell() {
        reviewsTableView.register(CellReview.nib(),
                                  forCellReuseIdentifier: CellReview.identifier)
        reviewsTableView.register(CellEmptyState.nib(),
                                  forCellReuseIdentifier: CellEmptyState.identifier)
    }

    private func showImageSlider() {
        guaranteeMainThread {
            self.backdropPathSlider.isHidden = false
        }
    }

    private func getData() {
        if let idMovie = idMovie {
            presenter?.willFetchMovie(of: idMovie)
            presenter?.willFetchReview(of: idMovie)
            presenter?.willFetchSimilarMovie(of: idMovie)
            presenter?.willFetchMovieRecomendation(of: idMovie)
        }
    }

    private func postIdMedia() {
        NotificationCenter.default.post(name: .notificacionCenterNameShowDetail,
                                        object: self)
    }

    private func reloadTableView() {
        reviewsTableView.reloadData { [weak self] in
            guard let self = self else { return }
            self.heightReviewTableView.constant = self.heightCells.values.reduce(.zero, {$0 + $1})
        }
    }

    private func hideButtonShowAllIfTotalDataIsMinium() {
        showAllTop.isHidden = reviews.count < LocalizedConstants.detailViewMinimumNumberToShowButton
        showAllBottom.isHidden = reviews.count < LocalizedConstants.detailViewMinimumNumberToShowButton
    }

    private func saveData(with data: [ReviewResult]) {
        if let first = data.first {
            self.firstReview.append(first)
        }
        self.reviews = data
    }
    private func getCellEmptyState(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellEmptyState.identifier) as? CellEmptyState {
            cell.setData(message: .detailReviewsEmptyState)
            return cell
        }
        return UITableViewCell()
    }

    private func getCellReview(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellReview.identifier) as? CellReview,
           let review = getReview(indexPath.row) {
            cell.backgroundColor = LocalizedConstants.commonPrimaryColor
            let review: ReviewType = ReviewType(title: "\(String.cellReviewWriteBy) \(review.author ?? "")",
                                                urlPhoto: review.authorDetails?.avatarPath ?? "",
                                                rate: Double(review.authorDetails?.rating ?? .zero),
                                                date: review.createdAt ?? "",
                                                content: review.content ?? "")
            cell.setNumberLineInZero()
            cell.hideButtonShowMore()
            cell.setData(with: review)
            return cell
        }
        return UITableViewCell()
    }
}

extension DetailViewController: DetailViewProtocol {
    func updateView(data: [RecomendationMovieModelResult]) {
        if data.isEmpty {
            guaranteeMainThread {
                self.uiViewContainerMovieRecomendations.isHidden = true
            }
            return
        }
        movieRecomendations = data
        var posterUrlString: [String] = []
        data.forEach { movie in
            if let poster = movie.posterPath {
                posterUrlString.append(poster)
            }
        }

        movieRecomendationsSlider.setUp(imageUrlArray: posterUrlString, imageContentMode: .scaleAspectFit)
        movieRecomendationsSlider.delegate = self
    }

    func updateView(data: [ReviewResult]) {
        saveData(with: data)
        guaranteeMainThread {
            self.titleReviewsLabel.text = "\(String.detailViewReviewTitle) \(data.count)"
            self.reloadTableView()
            self.hideButtonShowAllIfTotalDataIsMinium()
        }
    }

    func updateView(data: [SimilarMovieModelResult]) {
        if data.isEmpty {
            guaranteeMainThread {
                self.uiViewContainerSimilarMovie.isHidden = true
            }
            return
        }
        similarMovies = data
        var posterUrlString: [String] = []
        data.forEach { movie in
            if let poster = movie.posterPath {
                posterUrlString.append(poster)
            }
        }

        similarMoviesSlider.setUp(imageUrlArray: posterUrlString, imageContentMode: .scaleAspectFit)
        similarMoviesSlider.delegate = self
    }

    func updateView(data: MovieDetailResult) {
        if let data = data.imagesArrayUrlString, !data.isEmpty {
            showImageSlider()
            setupView(imageUrlArray: data)
        }

        var voteAverage: Int = .zero
        if let vote = data.voteAverage {
            voteAverage = Int(floor(vote / LocalizedConstants.cellMovieDivisorNumberHeight))
        }

        guaranteeMainThread {
            self.titleLabelText.text = data.title
            self.descriptionLabel.text = data.overview
            self.starRatedView.setData(selectedRate: voteAverage)
        }
    }

    func stopLoading() {
        guaranteeMainThread {
            self.view.removeLoader()
        }
    }
}

extension DetailViewController: ImageSliderDelegate {
    func indexDidSelect(_ index: Int, object: ImageSlider) {
        var idMovie: Int = .zero
        if object.isEqual(similarMoviesSlider),
           let id = similarMovies[index].id {
            idMovie = id
        } else if object.isEqual(movieRecomendationsSlider),
                  let id = movieRecomendations[index].id {
            idMovie = id
        }
        presenter?.willShowDetail(of: idMovie.description)
    }
}
