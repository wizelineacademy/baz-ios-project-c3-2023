//
//  MovieView.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 16/04/23.
//

import Foundation
import UIKit

class CVCarouselView: UIView, UICollectionViewDataSource {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var componentView: UIView!
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    var items:[CVMovieHubViewEntityMovieItem] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var parentVC:UIViewController? = nil
    
    convenience init() {
        self.init(frame: .zero)
        loadFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)        
        loadFromNib()
    }
    
    func refreshItems(newItems:[CVMovieHubViewEntityMovieItem]) {
        self.items = newItems
    }

    
    func configureCollectionView() {
        let nib = UINib(nibName: "CVCarouselItemCollectionViewCell", bundle: Bundle(for: CVCarouselItemCollectionViewCell.self))
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CVCarouselItemCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self        
    }
    

    private func loadFromNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: Bundle(for: CVCarouselView.self))
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.configureCollectionView()
    }
    
    

}



extension CVCarouselView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        return CGSize(width: cellWidth, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCarouselItemCollectionViewCell", for: indexPath) as! CVCarouselItemCollectionViewCell
        cell.parentVC = self.parentVC
        cell.item = self.items[indexPath.row]
        DispatchQueue.main.async {
            cell.tryDrawImage(url: self.items[indexPath.row].image)
        }
        return cell
    }
    
}
