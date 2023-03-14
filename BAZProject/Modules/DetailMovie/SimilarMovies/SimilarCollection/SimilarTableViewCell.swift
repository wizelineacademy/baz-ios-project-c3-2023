//
//  SimilarTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class SimilarTableViewCell: UITableViewCell {
    
    @IBOutlet weak var similarCollectionView: UICollectionView!
    
    var similarMovie: [Movie] = []
    private let apiManager = MovieAPIManager()
    var imagesMovies: [UIImage] = []
    var idMovie: Int = 0
    weak var view: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpCell()
    }
    
    func loadView(){
        apiManager.delegate = self
        apiManager.getSimilarMovies(idMovie: idMovie)
    }
    
    func setUpCollectionView(){
        similarCollectionView.dataSource = self
        similarCollectionView.delegate = self
        similarCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        similarCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource
extension SimilarTableViewCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        
        apiManager.getImageMovie(profilePath: similarMovie[indexPath.row].poster_path) { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title: self.similarMovie[indexPath.row].title )
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovie.count
    }
    
}

//MARK: - CollectionView's Delegate
extension SimilarTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = similarMovie[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}

//MARK: - MovieAPIManagerDelegate
extension SimilarTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.similarMovie = movies as! [Movie]
        DispatchQueue.main.async {
            self.similarCollectionView.reloadData()
        }
    }
}
