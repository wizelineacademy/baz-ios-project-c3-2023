//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 15/02/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionMovieView: UICollectionView!
    
    static let identifier = "MovieTableViewCell"
    var models:[Movie] = []
    
    static func nib() -> UINib {
        return UINib(nibName: identifier , bundle: nil)
    }
    
    func configure(with models:[Movie]) {
        self.models = models
        collectionMovieView.reloadData()
    }
    
    override func prepareForReuse() {
        self.models = []
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionMovieView.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionMovieView.delegate = self
        collectionMovieView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

//MARK: -Extensions

extension MovieTableViewCell : UICollectionViewDelegate{
    
}

extension MovieTableViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        let movie = models[indexPath.row]
        cell.configure(withModel: movie)
        return cell
    }
}

extension MovieTableViewCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 300)
    }
}
