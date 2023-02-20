//
//  InformationMoviesView.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class InformationMoviesView: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var textOverview: UITextView!
    @IBOutlet weak var collectionMovieSimilar: UICollectionView!

    // MARK: - Properties
    var presenter: InformationMoviesPresenterProtocol?
    typealias Constants = MovieConstants

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupview()
    }
    
    private func setupview(){
        self.imageMovie.loadImage(urlStr: CellPath.imageUrl(urlString: presenter?.informationMovieData?.posterPath ?? "").completeImageURL)
        self.presenter?.loadingView()
        self.labelTitle.text = presenter?.informationMovieData?.title
        self.labelDetail.text = loadInformationMovie(informationMovie: presenter?.informationMovieData)
        self.textOverview.text = presenter?.informationMovieData?.overview == nil || presenter?.informationMovieData?.overview == "" ? "Sin comentarios" : presenter?.informationMovieData?.overview
        self.collectionMovieSimilar.register(UINib(nibName: ReleatedMovieCollectionCell.cellIdentifier, bundle: Bundle(for: ReleatedMovieCollectionCell.self)), forCellWithReuseIdentifier: ReleatedMovieCollectionCell.cellIdentifier)
        self.collectionMovieSimilar.delegate = self
        self.collectionMovieSimilar.dataSource = self
    }
}
