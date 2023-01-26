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
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!

    var searchBar: UISearchBar?
    var delegate: HeaderBarViewControllerDelegate?
    
    func addSearchBar() {
        guard let searchBar = searchBar else { return }
        searchBar.backgroundColor = .red
        searchBar.delegate = self
        searchView.addSubview(searchBar)
    }
    
    func setData(title: String, urlImageView: String, width: CGFloat? = nil) {
        titleLabel.text = title
        photoImageView.loadImage(id: urlImageView)
        let heightView = width != nil ? containerView.bounds.height : headerView.bounds.height
        if let width = width {
            let customFrame = CGRect(x: 0, y: 0, width: width, height: searchView.bounds.height)
            searchBar = UISearchBar(frame: customFrame)
            addSearchBar()
        } else {
            searchView.isHidden = true
        }
        delegate?.resizeView(heightHeader: heightView)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
