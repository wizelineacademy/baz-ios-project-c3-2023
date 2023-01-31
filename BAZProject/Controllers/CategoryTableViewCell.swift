//
//  CategoryTableViewCell.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionToCarrucel: UICollectionView!
    
    var moviesToShow: [Movie] = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCollectionView(){
        collectionToCarrucel.delegate = self
        collectionToCarrucel.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 130, height: 220)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        self.collectionToCarrucel.setCollectionViewLayout(flowLayout, animated: false)
    }
    

}


extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesToShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGalleryCollectionViewCell", for: indexPath) as! MovieGalleryCollectionViewCell
        collectionCell.movieImage.image = UIImage(named: "poster")
        collectionCell.movieTitle.text = moviesToShow[indexPath.row].title
        return collectionCell
    }
    
    
}
