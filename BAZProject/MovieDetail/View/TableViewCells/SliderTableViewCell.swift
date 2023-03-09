//
//  SliderTableViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

final class SliderTableViewCell: UITableViewCell {

    static var nib: UINib = UINib(nibName: String(describing: SliderTableViewCell.self), bundle: .main)
    static var identifier: String = String(describing: SliderTableViewCell.self)
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var collectionHeight: NSLayoutConstraint!
    
    private var dataSource: SliderDataSource?
    private var delegate: UICollectionViewDelegate?
    
    weak var eventHandler: SliderMovieDelegate?
}

extension SliderTableViewCell: GenericTableViewCell {
    
    /// Configures cell properties with the given data
    /// - Parameter model: a GenericTableViewRow object
    func setupCell(with model: GenericTableViewRow) {
        self.selectionStyle = .none
        self.collection.allowsMultipleSelection = false
        self.collection.showsHorizontalScrollIndicator = false
        self.collection.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        switch model {
        case is Actors:
            guard let actors = model as? Actors else { return }
            self.title.text = actors.detail?.title
            self.collection.register(ActorCollectionViewCell.nib, forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
            self.dataSource = SliderDataSource(rows: actors.actors)
            self.delegate = SliderActorDelegate()
            self.collectionHeight.constant = 165
        case is Reviews:
            guard let reviews = model as? Reviews else { return }
            self.title.text = reviews.detail?.title
            self.collection.register(ReviewCollectionViewCell.nib, forCellWithReuseIdentifier: ReviewCollectionViewCell.identifier)
            self.dataSource = SliderDataSource(rows: reviews.reviews)
            self.delegate = SliderReviewDelegate()
            self.collectionHeight.constant = 160
        default:
            guard let movies = model as? PagedMovies else { return }
            self.title.text = movies.detail?.title
            self.collection.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
            self.dataSource = SliderDataSource(rows: movies.movies)
            self.delegate = SliderMoviesDelegate(delegate: self)
            self.collectionHeight.constant = 190
        }
        self.collection.dataSource = self.dataSource
        self.collection.delegate = self.delegate
        self.collection.reloadData()
    }
}

extension SliderTableViewCell: DetailDelegateOutput {
    
    /// Calls the even handler method to return the movie created by the correcponding row
    /// - Parameter indexPath: a IndexPath object
    func didSelectRow(at indexPath: IndexPath) {
        guard let movie = dataSource?.rows[indexPath.row] as? Movie else { return }
        self.eventHandler?.didSelect(movie)
    }
}
