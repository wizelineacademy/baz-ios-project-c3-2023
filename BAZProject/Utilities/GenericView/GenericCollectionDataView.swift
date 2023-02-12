//
//  GenericCollectionDataView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 09/02/23.
//

import UIKit

class GenericCollectionDataView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewInit()
    }
    
    func viewInit(){
        let nib = UINib(nibName: "GenericCollectionDataView", bundle: Bundle(for: Self.self))
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension GenericCollectionDataView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }


}
