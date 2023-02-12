//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var castView: GenericCollectionDataView!
    @IBOutlet weak var similarMoviesView: GenericCollectionDataView!
    @IBOutlet weak var recomendedMovie: GenericCollectionDataView!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        castView.label.text = "Reparto:"
        similarMoviesView.label.text = "Peliculas similares:"
        recomendedMovie.label.text = "Peliculas recomendadas:"
    }
    
    @IBAction func closeScreen() {
        dismiss(animated: true)
    }
}
