//
//  MoviesSectionView.swift
//  BAZProject
//
//  Created by 1034209 on 10/02/23.
//

import Foundation
import UIKit

protocol MoviesSectionDelegate: AnyObject {
    func seeMore()
    func didTapItem()
}

struct MoviesSectionModel {
    let title: String
    let images: [UIImage]
}

class MoviesSectionView: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var titleSectionMovies: UILabel! {
        didSet {
            titleSectionMovies.text = typeSection.title
        }
    }
    @IBOutlet weak var carruselMoviesView: UIView!
    
    // MARK: Properties
    var manager: CarruselCollectionManager!
    let typeSection: fetchMoviesTypes
    let carruselCollection = CarruselCollectionView(direction: .horizontal)

    var model: [Home.FetchMoviesBySection.ViewModel.Movie]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.configureCarruselMoviesView()
                self.manager.dataCollection = self.model
            }
        }
    }
    
    init(typeSection: fetchMoviesTypes) {
        self.typeSection = typeSection
        super.init(frame: .zero)
        self.configurateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configurateView() {
        guard let view = loadViewFromNib(nibName: "MoviesSectionView") else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func configureCarruselMoviesView() {
        carruselMoviesView.addSubview(carruselCollection)
        carruselCollection.leadingAnchor.constraint(equalTo: carruselMoviesView.leadingAnchor).isActive = true
        carruselCollection.trailingAnchor.constraint(equalTo: carruselMoviesView.trailingAnchor).isActive = true
        carruselCollection.topAnchor.constraint(equalTo: carruselMoviesView.topAnchor).isActive = true
        carruselCollection.bottomAnchor.constraint(equalTo: carruselMoviesView.bottomAnchor).isActive = true
        manager = CarruselCollectionManager()
        manager.setupCollection(collection: carruselCollection)
    }
}

extension UIView {
    func loadViewFromNib(nibName: String) -> UIView?{
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return nil
        }
        return view
    }
}
