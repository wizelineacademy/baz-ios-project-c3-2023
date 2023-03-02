//
//  MoreMoviesView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 22/02/23.
//

import UIKit

class MoreMoviesView: UIView {
    
    weak var delegate: MoreMoviesDelegate?
    
    static func getView(delegate: MoreMoviesDelegate?) -> UIView? {
        let nib = UINib(nibName: String(describing: MoreMoviesView.self), bundle: .main)
        guard let view = nib.instantiate(withOwner: nil).first as? MoreMoviesView else { return nil }
        view.delegate = delegate
        return view
    }
    
    /**
     Call the delegate method to request more movies
     - Parameters:
        - sender: a Any object witch call this method
     */
    @IBAction func didSelectMoreMovies(_ sender: Any) {
        self.delegate?.didSelectMoreMovies()
    }
}
