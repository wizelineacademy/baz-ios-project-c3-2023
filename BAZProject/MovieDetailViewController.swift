//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 03/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var movieCollection: UICollectionView!
    
    let colourList: [UIColor] = [UIColor.gray, UIColor.red, UIColor.blue, UIColor.systemTeal, UIColor.green, UIColor.yellow, UIColor.black ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollection.delegate = self
        movieCollection.dataSource = self
        movieCollection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
    
}

extension MovieDetailViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colourList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = colourList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return .zero
            }
        let numberOfItems: CGFloat = 4
            let collectionViewWidth = collectionView.bounds.width
            let spaceBetweenCells = flowLayout.minimumInteritemSpacing
            let adjustedWidth = (collectionViewWidth - (spaceBetweenCells*(numberOfItems-1)))/numberOfItems
            let height: CGFloat = 120
            return CGSize(width: adjustedWidth, height: height)
    }
}
 
