//
//  HomeViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol HomeDisplayLogic: AnyObject {
    // TODO: create functions to manage display logic
}

class HomeViewController: UIViewController {
    
    // MARK: Properties VIP
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: IBOutlet
    @IBOutlet weak var section1: MoviesSectionView!
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {

    }
    override func viewWillAppear(_ animated: Bool) {

    }
    
    // MARK: Setup
    func setup() {
        // TODO: setup VIP Module
    }
}

extension HomeViewController: HomeDisplayLogic {
    // TODO: conform HomeDisplayLogic protocol
}
