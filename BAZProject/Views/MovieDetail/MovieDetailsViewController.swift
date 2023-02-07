//
//  MovieDetailsViewController.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/02/23.
//
import UIKit

class MovieDetailsViewController: UIViewController {
    
    var myMovie: Movie?
    
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var tableCategorys: UITableView!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = myMovie?.title
        imgMovie.image = myMovie?.imagePrincipal
        lblMovieTitle.text = myMovie?.title
        lblDescription.text = myMovie?.overview
    }
}
