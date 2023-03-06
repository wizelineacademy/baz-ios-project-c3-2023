//
//  SearchView.swift
//  BAZProject
//
//  Created by Mario Arceo on 16/02/23.
//

import UIKit

class SearchView: UIViewController {
    
    let movieApi = MovieAPI()
    var movieImage = UIImage()
    var images: [UIImage] = []
    var moviesArray : [Movie] = []
    let itemsPerRow: CGFloat = 3
    
    private let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    @IBAction func searchByWord(_ sender: Any) {
        moviesCollectionView.backgroundColor = .white
        movieApi.searchText = searchBar.text ?? ""
        moviesArray.removeAll()
        images.removeAll()
        DispatchQueue.global().async { [weak self] in
            self?.moviesArray = self?.movieApi.getMovies(ofType: .search) ?? []
            guard let myMovies =  self?.moviesArray else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.images.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async {
                    self?.moviesCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: String(String(describing: MovieCollectionCell.self)), bundle: .main)
        self.moviesCollectionView.register(nib, forCellWithReuseIdentifier: MovieCollectionCell().identifier)
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
    }
    
}

extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
// MARK: - SectionsConfigurations
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
// MARK: - CellConfiguration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell().identifier, for: indexPath) as? MovieCollectionCell {
            cell.imgMovie.image = self.images[indexPath.row]
            return cell
        }
        return MovieCollectionCell()
    }
// MARK: - SelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getMovieDetails(view: self, movie: moviesArray[indexPath.row], movieImage: images[indexPath.row])
    }
}

extension SearchView: UICollectionViewDelegateFlowLayout {
// MARK: - CellSize
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath ) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
    }
// MARK: - SpacingForSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
// MARK: - SectionInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int ) -> UIEdgeInsets {
        sectionInsets
    }
// MARK: - LineSpacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int ) -> CGFloat {
        4.0
    }
}

