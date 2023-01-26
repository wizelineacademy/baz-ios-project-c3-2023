//
//  HeaderBarViewController.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

protocol HeaderBarViewControllerDelegate {
    func resizeView(heightHeader: Double)
}

class HeaderBarViewController: CustomView, UISearchBarDelegate {
    
    override var nameXIB: String {"HeaderBarView"}
    
    @IBOutlet weak var imgErrorLogo: UIImageView! {
        didSet {
            if let icon = UIImage(named: .nameIcon404) {
                imgErrorLogo.image = icon
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    var delegate: HeaderBarViewControllerDelegate?
    
    func addSearchBar(title: String, width: CGFloat, urlImageView: String) {
        setData(title: title)
        lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width, height: searchView.bounds.height))
        photoImageView.loadImage(id: urlImageView)
        searchBar.backgroundColor = .red
        searchBar.delegate = self
        searchView.addSubview(searchBar)
        delegate?.resizeView(heightHeader: containerView.bounds.height)
    }
    
    func setData(title: String) {
        titleLabel.text = title
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
