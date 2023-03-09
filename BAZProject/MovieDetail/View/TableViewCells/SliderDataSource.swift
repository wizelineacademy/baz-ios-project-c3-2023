//
//  SliderDataSource.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

final class SliderDataSource: NSObject {
    let rows: [any GenericCollectionViewRow]
    
    init(rows: [any GenericCollectionViewRow]) {
        self.rows = rows
    }
}

extension SliderDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.rows.count <= 20 ? self.rows.count : 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = self.rows[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: row.collectionCellClass.identifier, for: indexPath)
        if let customCell = cell as? any GenericCollectionViewCell {
            customCell.setupCell(with: row)
        }
        return cell
    }
}
