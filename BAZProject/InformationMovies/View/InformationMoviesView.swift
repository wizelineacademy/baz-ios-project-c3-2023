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
    let numberOfSections = 1
    let insets: CGFloat = 8
    let heightAditionalConstant : CGFloat = 75
    let minimumLineSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow:Int = 3

    // MARK: - Properties
    var presenter: InformationMoviesPresenterProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .clear
        self.setupview()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = presenter?.informationMovieData?.title
    }
    
    private func setupview(){
        self.imageMovie.loadImage(urlStr: CellPath.imageUrl(urlString: presenter?.informationMovieData?.poster_path ?? "").completeImageURL)
        collectionMovieSimilar.register(UINib(nibName: MovieCollectionCell.cellIdentifier, bundle: Bundle(for: InformationMoviesView.self)), forCellWithReuseIdentifier: MovieCollectionCell.cellIdentifier)
        self.presenter?.loadingView()
        self.labelTitle.text = presenter?.informationMovieData?.title
        self.labelDetail.text = "\(presenter?.informationMovieData?.original_title ?? "") | \(presenter?.informationMovieData?.genres?.first?.name ?? "") | \(presenter?.informationMovieData?.release_date ?? "")\(presenter?.informationMovieData?.adult ?? false ? " | 18+": " | 18-")"
        self.textOverview.text = presenter?.informationMovieData?.overview == nil || presenter?.informationMovieData?.overview == "" ? "Sin comentarios" : presenter?.informationMovieData?.overview
    }
}
