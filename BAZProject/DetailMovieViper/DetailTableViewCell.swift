//
//  DetailTableViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 13/02/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell{
    
    var presenter: DetailMoviePresenterProtocol?

    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    var indexPath: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        detailCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        detailCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "CastCollectionViewCell")
        detailCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        detailCollectionView.register(UINib(nibName: "MoviesCollectionViewCell", bundle: Bundle(for: DetailMovieView.self)), forCellWithReuseIdentifier: "MoviesCollectionViewCell")
        
    }
    
    func setupDetailsCollectionView(){
        DispatchQueue.main.async {
            self.detailCollectionView.reloadData()
        }
    }

}

extension DetailTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.indexPath{
        case 0:
            return 1
        case 1:
            return presenter?.getCastCount() ?? 0
        case 2:
            return presenter?.getReviewCount() ?? 0
        case 3:
            return presenter?.getSimilarCount() ?? 0
        case 4:
            return presenter?.getRecommendationCount() ?? 0
        default:
            return 0
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch self.indexPath{
        case 0:
            self.detailNameLabel.text = ""
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as? DetailsCollectionViewCell else { return UICollectionViewCell() }
            let name = self.presenter?.detailsMovie?.original_title ?? ""
            let genres = "\(self.presenter?.detailsMovie?.runtime ?? 000) min | \(self.presenter?.detailsMovie?.genres?[0].name ?? "") | \(self.presenter?.detailsMovie?.genres?[1].name ?? "")"
            let overview = self.presenter?.detailsMovie?.overview ?? ""
            cell.setupCell(name: name, genres: genres, overview: overview)
            return cell
        case 1:
            self.detailNameLabel.text = " Cast"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as? CastCollectionViewCell else { return UICollectionViewCell() }
            presenter?.getCastImage(index: indexPath.row, completion: { castImage in
                cell.setupCastImage(castImage: castImage)
                DispatchQueue.main.async {
                    cell.nameLabel.text = self.presenter?.getCast(index: indexPath.row).name ?? ""
                    cell.characterLabel.text = self.presenter?.getCast(index: indexPath.row).character ?? ""
                }
            })
            return cell
        case 2:
            self.detailNameLabel.text = " Reviews"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            cell.setupReviewCell(name: presenter?.getReview(index: indexPath.row).author, review: presenter?.getReview(index: indexPath.row).content, date: presenter?.getReview(index: indexPath.row).created_at)
            cell.addShadow()
            return cell
        case 3:
            self.detailNameLabel.text = " Similar"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
            presenter?.getSimilarImage(index: indexPath.row, completion: { similarImage in
                cell.setupCell(image: similarImage)
            })
            return cell
        case 4:
            self.detailNameLabel.text = " Recommendations"
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCollectionViewCell", for: indexPath) as? MoviesCollectionViewCell else { return UICollectionViewCell() }
            presenter?.getRecommendationImage(index: indexPath.row, completion: { recommendationImage in
                cell.setupCell(image: recommendationImage)
            })
           return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}

extension DetailTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.indexPath{
        case 0:
            return CGSize(width: 400, height: 150)
        case 1:
            return CGSize(width: 100, height: 130)
        case 2:
            return CGSize(width: 200, height: 100)
        case 3:
            return CGSize(width: 100, height: 120)
        case 4:
            return CGSize(width: 100, height: 120)
        default:
            return CGSize(width: 0, height: 0)
        }
        
    }
}

extension DetailTableViewCell: UICollectionViewDelegate{
    
}


