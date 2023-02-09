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
    
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func closeScreen(){
        dismiss(animated: true)
    }
}
