//
//  SimilarMovieTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 22/02/23.
//

import UIKit

class SimilarMovieTableViewCell: UITableViewCell {
    
    //MARK: -IBOutlets
    @IBOutlet weak var collectionSimilarMovies: UICollectionView!
    
    //MARK: -Properties
    static let identifier = "SimilarMovieTableViewCell"
    var model:[SimilarMovie] = []
    
    //MARK: -Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with model:[SimilarMovie]) {
        self.model = model
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionSimilarMovies.delegate = self
        collectionSimilarMovies.dataSource = self
        collectionSimilarMovies.register(SimilarMovieCollectionViewCell.nib(), forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//MARK: -Extensions
extension SimilarMovieTableViewCell: UICollectionViewDelegate {}
extension SimilarMovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.identifier, for: indexPath)
                as? SimilarMovieCollectionViewCell else { return UICollectionViewCell() }
        let similarMovie = model[indexPath.row]
        cell.configure(withModel: similarMovie)
        return cell
    }
}

extension SimilarMovieTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 250)
    }
}

