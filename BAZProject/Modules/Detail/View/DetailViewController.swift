//
//  DetailViewController.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

final class DetailViewController: UIViewController, DetailViewProtocol {
    var presenter: DetailPresenterProtocol?
    
    static let identifier: String = .detailXibIdentifier
}
