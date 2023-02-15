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
    let imageString: [String]
}

class MoviesSectionView: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var titleSectionMovies: UILabel!
    @IBOutlet weak var carruselMoviesView: UIView!
    
    // MARK: Properties
    var manager: CarruselCollectionManager!
    let carruselCollection = CarruselCollectionView()
    var model: MoviesSectionModel? {
        didSet {
            titleSectionMovies.text = model?.title
            manager.dataItem = model?.imageString
        }
    }
    
    init() {
        super.init(frame: .zero)
        self.configurateView()
        configureCarruselMoviesView()

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configurateView()
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
        manager = CarruselCollectionManager(collection: carruselCollection)
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
