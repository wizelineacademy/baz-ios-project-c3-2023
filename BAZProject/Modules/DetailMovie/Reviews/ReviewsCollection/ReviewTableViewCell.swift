//
//  ReviewTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    
    let movieApi = MovieAPI()
    var review: [Reviews] = []
    var imageActor: [UIImage] = []
    var idMovie: Int = 0
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setUpCell()
    }
    
    func loadView() {
        movieApi.getReviews(idMovie: idMovie) { [weak self] review in
            self?.review = review
            DispatchQueue.main.async {
                self?.reviewCollectionView.reloadData()
            }
        }
    }
    
    func configCollectionView(){
        reviewCollectionView.dataSource = self
        reviewCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reviewCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 390, height: 200)
        reviewCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource
extension ReviewTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as? ReviewCollectionViewCell
        else { return UICollectionViewCell() }
        
        let reviewAtIndex = review[indexPath.row]
        cell.setUpReviews(authorLabel: " Autor:  \(reviewAtIndex.author ?? "")", reviewLabel: reviewAtIndex.content ?? "", createdLabel: " Fecha de Creacion: \(reviewAtIndex.created_at ?? "")")
        cell.addShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return review.count
    }
    
    
}

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }
}



