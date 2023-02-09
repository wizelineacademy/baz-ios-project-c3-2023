//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    @IBOutlet var poster: UIImageView!
    @IBOutlet var titleMovie: UILabel!
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func closeScreen(){
        dismiss(animated: true)
    }
}
