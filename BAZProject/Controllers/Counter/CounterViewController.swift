//
//  CounterViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 27/02/23.
//

import UIKit

class CounterViewController: UIViewController {

    @IBOutlet weak var numOfMoviesSeen: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadNumbersOfMovies()
    }
    
    func reloadNumbersOfMovies() {
        numOfMoviesSeen.text = CounterSingleton.shared.returnMoviesCounter()
    }
    
}
