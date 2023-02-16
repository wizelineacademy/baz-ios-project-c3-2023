//
//  InformationMoviesView.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class InformationMoviesView: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var textOverview: UITextView!
    @IBOutlet weak var collectionMovieSimilar: UICollectionView!

    // MARK: - Properties
    var presenter: InformationMoviesPresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
    }
    
    private func setupview(){
        self.imageMovie.loadImage(urlStr: CellPath.imageUrl(urlString: presenter?.informationMovieData?.poster_path ?? "").completeImageURL)
        collectionMovieSimilar.register(UINib(nibName: MovieCollectionSimilarCell.cellIdentifier, bundle: Bundle(for: MovieCollectionSimilarCell.self)), forCellWithReuseIdentifier: MovieCollectionSimilarCell.cellIdentifier)
        self.presenter?.loadingView()
        self.labelTitle.text = presenter?.informationMovieData?.title
        self.labelDetail.text = "\(presenter?.informationMovieData?.original_title ?? "") | \(presenter?.informationMovieData?.genres?.first?.name ?? "") | \(presenter?.informationMovieData?.release_date ?? "")\(presenter?.informationMovieData?.adult ?? false ? " | 18+": " | 18-")"
        self.textOverview.text = presenter?.informationMovieData?.overview == nil || presenter?.informationMovieData?.overview == "" ? "Sin comentarios" : presenter?.informationMovieData?.overview
    }
}
