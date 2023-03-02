//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

final class DetailsMovieViewController: UIViewController, DetailsView {
    
    var movieDetail: MovieDetail? = nil {
        didSet {
            detailsMovie = movieDetail
        }
    }

    @IBOutlet weak var stackVerticalContainer: UIStackView!
    @IBOutlet weak var imgMovie: UIImageView!
    
    var specificMovie: Movie? = nil
    let viewModel: DetailsMovieViewModel? = nil
    var detailsMovie: MovieDetail? = nil
    let labelsMovieView: LabelsMovie = LabelsMovie()
    let notificationName = Notification.Name("CountMoviesNotification")
    let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = specificMovie?.title
        setUIBanner()
        viewModel?.view = self
        viewModel?.fetchDetailMovie(idMovie: specificMovie?.id ?? 0)
        viewLabelsAdded()
        centerNotifCreated()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUINavigation()
        loadValuesDetails()
        loadLabelOverview()
    }
    
    /**
     Create center notification name CountMoviesNotification to ViewController
     */
    private func centerNotifCreated() {
        notificationCenter.post(name: notificationName, object: nil, userInfo: nil)
    }
    
    private func setUINavigation() {
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .orange
    }
    
    private func setUIBanner() {
        let url = specificMovie?.getUrlImg(posterPath: specificMovie?.posterPath ?? "")
        if let urlString = url { imgMovie.load(url: urlString) }
        imgMovie.contentMode = .scaleAspectFill
        imgMovie.layer.cornerRadius = 20
        imgMovie.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func loadValuesDetails() {
        labelsMovieView.lblIsAdult.isHidden = !(detailsMovie?.adult ?? true)
        labelsMovieView.lblStatus.text = "Status: \(detailsMovie?.status ?? "")"
        labelsMovieView.lblLanguage.text = "Language \(detailsMovie?.originalLanguage ?? "")"
        labelsMovieView.lblStatus.textColor = .orange
        labelsMovieView.lblLanguage.textColor = .orange
    }
    
    private func loadLabelOverview() {
        let lblOverview = UILabel()
        lblOverview.numberOfLines = 0
        lblOverview.textAlignment = .center
        lblOverview.text = specificMovie?.overView ?? ""
        lblOverview.textColor = .white
        stackVerticalContainer.addArrangedSubview(lblOverview)
    }
    
    private func viewLabelsAdded() {
        stackVerticalContainer.addArrangedSubview(labelsMovieView)
    }
}
