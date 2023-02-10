//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 02/02/23.
//


import Foundation
import UIKit

class DetailMovieViewController: UIViewController{
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var actorsMovie: UILabel!
    @IBOutlet weak var rateMovie: UILabel!
    @IBOutlet weak var resumeMovie: UILabel!
    @IBOutlet weak var datePremiere: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieNameLabel.text = "Megan"
        actorsMovie.text = "$ .00"
        rateMovie.text = "⭐️⭐️⭐️⭐️"
    }
}
