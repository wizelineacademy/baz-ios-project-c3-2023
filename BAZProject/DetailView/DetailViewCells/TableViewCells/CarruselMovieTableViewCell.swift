//
//  CarruselMovieTableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

final class CarruselMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movies: [Movie] = []
    
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollection()
    }

    ///This method configure the collection view and register the cells
    private func setUpCollection(){
        movieCollection.dataSource = self
        movieCollection.delegate = self
        movieCollection.register(SearchMovieViewCollectioCell.nib, forCellWithReuseIdentifier: SearchMovieViewCollectioCell.identifier)
    }
    
    ///This method fill the info of the view for cell
    /// - Parameter for: recibes the  `Array` of type`Review`
    func setInfo(for movies: [Movie]){
        self.movies = movies
        self.movieCollection.reloadData()
    }
}


// MARK: - UICollectionViewDataSource
extension CarruselMovieTableViewCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchMovieViewCollectioCell.identifier,
            for: indexPath) as? SearchMovieViewCollectioCell else {return UICollectionViewCell()}
        let movie = movies[indexPath.row]
        cell.setInfo(for: movie)
        return cell
    }
}


// MARK: - Collection View Flow Layout Delegate
extension CarruselMovieTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let numberOfItems: CGFloat = 3
        let collectionViewWidth = collectionView.bounds.width
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing
        let adjustedWidth = (collectionViewWidth - (spaceBetweenCells * numberOfItems - 1) - sectionInsets.left - sectionInsets.right)/numberOfItems
        let height: CGFloat = 200
        return CGSize(width: adjustedWidth, height: height)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
