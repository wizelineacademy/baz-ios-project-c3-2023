//
//  DetailsMovieViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

final class DetailsMovieViewController: UIViewController {

    @IBOutlet weak var stackVerticalContainer: UIStackView!
    @IBOutlet weak var imgMovie: UIImageView!
    
    var specificMovie: Movie? = nil
    let movieApi = MovieAPI()
    var detailsMovie: MovieDetail? = nil
    let labelsMovieView: LabelsMovie = LabelsMovie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = specificMovie?.title
        setUIBanner()
        fetchDetailsMovie()
        loadValuesDetails()
        loadLabelOverview()
        viewLabelsAdded()
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
    
    private func fetchDetailsMovie() {
        movieApi.getDetailMovie(idMovie: specificMovie?.id ?? 0) { details in
            self.detailsMovie = details
        }
    }
    
    private func loadValuesDetails() {
        labelsMovieView.lblIsAdult.isHidden = !(detailsMovie?.adult ?? true)
        labelsMovieView.lblStatus.text = "Status: \(detailsMovie?.status ?? "")"
        labelsMovieView.lblLanguage.text = "Language \(detailsMovie?.originalLanguage ?? "")"
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
