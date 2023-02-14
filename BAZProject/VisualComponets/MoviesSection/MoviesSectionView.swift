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

struct MoviesSectionViewModel {
    let title: String
    let movies: [String]
}

class MoviesSectionView: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var titleSectionMovies: UILabel!
    @IBOutlet weak var carruselMoviesView: UIView!
    
    // MARK: Properties
    var viewModel: MoviesSectionViewModel? 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configurateView()
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
