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
    var detailType: DetailType?

    // MARK: - Private properties
    private var reviews: [ReviewResult] = []
    private var firstReview: [ReviewResult] = []

    var heightCells: [Int:CGFloat] = [:]

    @IBOutlet weak private var imageSlider: ImageSlider!
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

    override func viewDidLoad() {
        super.viewDidLoad()
        initRegister()
        getData()
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
        postIdMedia()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageSlider.stopTimmer()
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
        imageSlider.setUp(imageUrlArray: imageUrlArray)
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
            self.imageSlider.isHidden = false
        }
    }

    private func getData() {
        if let detailType = detailType {
            presenter?.willFetchMedia(detailType: detailType)
            presenter?.willFetchReview(of: detailType.idMedia.description)
        }
    }

    private func postIdMedia() {
        if let id = detailType?.idMedia as? Int {
            NotificationCenter.default.post(name: .notificacionCenterNameShowDetail,
                                            object: self,
                                            userInfo: [LocalizedConstants.notificationCenterNameParamId: String(id)])
        }
    }

    private func reloadTableView() {
        reviewsTableView.reloadData { [weak self] in
            guard let self = self else { return }
            self.heightReviewTableView.constant = self.heightCells.values.reduce(0, {$0 + $1})
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
    func updateView(data: [ReviewResult]) {
        saveData(with: data)
        guaranteeMainThread {
            self.titleReviewsLabel.text = "\(String.detailViewReviewTitle) \(data.count)"
            self.reloadTableView()
            self.hideButtonShowAllIfTotalDataIsMinium()
        }
    }

    func updateView(data: MovieDetailResult) {
        if let data = data.imagesArrayUrlString, !data.isEmpty {
            showImageSlider()
            setupView(imageUrlArray: data)
        }
        guaranteeMainThread {
            self.titleLabelText.text = data.title
            self.descriptionLabel.text = data.overview
        }
    }

    func stopLoading() {
        guaranteeMainThread {
            self.view.removeLoader()
        }
    }
}
