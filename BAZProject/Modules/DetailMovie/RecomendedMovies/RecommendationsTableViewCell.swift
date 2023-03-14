//
//  RecommendationsTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 03/03/23.
//

import UIKit

class RecommendationsTableViewCell: UITableViewCell {
    @IBOutlet weak var recomCollectionView: UICollectionView!
    
    var recommendationsMovie: [Movie] = []
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
        apiManager.getRecommendationsMovies(idMovie: idMovie)
    }
    
    func setUpCollectionView(){
        recomCollectionView.dataSource = self
        recomCollectionView.delegate = self
        recomCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 110, height: 200)
        recomCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
}

//MARK: - CollectionView's DataSource

extension RecommendationsTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        apiManager.getImageMovie(profilePath: recommendationsMovie[indexPath.row].poster_path) { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title: self.recommendationsMovie[indexPath.row].title )
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationsMovie.count
    }
    
}

//MARK: - CollectionView's Delegate
extension RecommendationsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        destination.movie = recommendationsMovie[indexPath.row]
        view?.navigationController?.pushViewController(destination, animated: true)
    }
}

//MARK: - MovieAPIManagerDelegate
extension RecommendationsTableViewCell: MovieAPIManagerDelegate {
    func didReceiveMovies<T: Codable>(_ movies: T) {
        self.recommendationsMovie = movies as! [Movie]
        DispatchQueue.main.async {
            self.recomCollectionView.reloadData()
        }
    }
    
}
