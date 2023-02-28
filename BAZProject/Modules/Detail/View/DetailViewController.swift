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
    private var errorGetData: Bool = false
    private var reviews: [ReviewResult] = []
    private var firstReview: [ReviewResult] = []

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
    @IBOutlet weak var heightReviewView: NSLayoutConstraint!
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

        if (presenter?.isLoading() ?? false) || errorGetData {
            showLoader()
        }

        if errorGetData {
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

    func getReview(_ index: Int) -> ReviewResult? {
        return firstReview[index]
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
        reviewsTableView.separatorColor = .white
    }

    private func setTableViewDelegates() {
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
    }

    private func registerCell() {
        reviewsTableView.register(CellReview.nib(),
                                  forCellReuseIdentifier: CellReview.identifier)
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

    private func hideButtonShowAllIfTotalDataIsMinium() {
        showAllTop.isHidden = reviews.count < LocalizedConstants.detailViewMinimumNumberToShowButton
        showAllBottom.isHidden = reviews.count < LocalizedConstants.detailViewMinimumNumberToShowButton
    }

    private func updateReviewsViewBottomConstraint() {
        heightReviewView.constant = reviewsTableView.contentSize.height +
        LocalizedConstants.detailViewAumentBottomCellConstraint +
        LocalizedConstants.detailViewAumentBottomConstraint
    }
}

extension DetailViewController: DetailViewProtocol {
    func updateView(data: [ReviewResult]) {
        if let first = data.first {
            self.firstReview.append(first)
        }
        self.reviews = data
        guaranteeMainThread {
            self.titleReviewsLabel.text = "\(String.detailViewReviewTitle) \(data.count)"
            self.reviewsTableView.reloadData {
                self.updateReviewsViewBottomConstraint()
            }
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

    func setErrorGettingData(_ status: Bool) {
        errorGetData = status
    }
}
