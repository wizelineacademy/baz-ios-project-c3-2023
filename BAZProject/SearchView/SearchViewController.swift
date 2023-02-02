//
//  SearchViewController.swift
//  BAZProject
//
//  Created by avirgilio on 02/02/23.
//

import UIKit

class SearchViewController: UIViewController {
    

    @IBOutlet weak var collectionSearch: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        registerCollectionViewCells()
        // Do any additional setup after loading the view.
    }

    
    func registerCollectionViewCells(){
        
        let detailViewCell = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionSearch.register(detailViewCell, forCellWithReuseIdentifier: "searchCollectionViewCell")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionSearch.dequeueReusableCell(withReuseIdentifier: "searchCollectionViewCell",
                                             for: indexPath) as! SearchCollectionViewCell
        
    }
    
}
