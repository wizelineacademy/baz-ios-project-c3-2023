//
//  CastTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var castCollectionView: UICollectionView!
    
        let movieApi = MovieAPI()
        var cast: [Cast] = []
        var imageActor: [UIImage] = []
        var idMovie: Int = 0
        weak var view: UIViewController?
    
        override func awakeFromNib() {
            super.awakeFromNib()
            configCollectionView()
            setUpCell()
        }
    
    func loadView() {
        movieApi.getMovieCast(idMovie: idMovie) { [weak self] cast in
            self?.cast = cast
            DispatchQueue.main.async {
                self?.castCollectionView.reloadData()
            }
        }
    }
        
        func configCollectionView(){
            castCollectionView.dataSource = self
            castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "castCell")
        }
        
        func setUpCell() {
            let configureCell = UICollectionViewFlowLayout()
            configureCell.scrollDirection = .horizontal
            configureCell.itemSize =  CGSize(width: 110, height: 200)
            castCollectionView.setCollectionViewLayout(configureCell, animated: false)
        }
    }

//MARK: - CollectionView's DataSource
extension CastTableViewCell: UICollectionViewDataSource{
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as? CastCollectionViewCell
            else { return UICollectionViewCell() }
            
            movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(cast[indexPath.row].profile_path ?? "")") { imageMovie in
                cell.setupCell(image: imageMovie ?? UIImage(), name: self.cast[indexPath.row].name ?? "", character: self.cast[indexPath.row].character ?? "")
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cast.count
        }
        
    }

    


