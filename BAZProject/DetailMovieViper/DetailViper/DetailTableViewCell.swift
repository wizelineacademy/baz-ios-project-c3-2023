//
//  DetailTableViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 13/02/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell{
    
    var presenter: DetailMoviePresenterProtocol?

    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    var indexPath: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        detailCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "CastCollectionViewCell")
        detailCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        detailCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
    }
    
    func setupDetailsCollectionView(){
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
    }

}

extension DetailTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getCollectionCount(indexPath: indexPath ?? 0) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        presenter?.getCell(collectionView: collectionView, indexPath: indexPath, indexPathTable: self.indexPath ?? 0, nameLabel: detailNameLabel) ?? UICollectionViewCell()
    }
    
    
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter?.getTableSize(indexPath: self.indexPath ?? 0) ?? CGSize(width: 0, height: 0)
    }
}
