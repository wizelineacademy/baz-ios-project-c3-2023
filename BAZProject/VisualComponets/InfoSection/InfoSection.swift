//
//  InfoSection.swift
//  BAZProject
//
//  Created by 1034209 on 27/02/23.
//

import Foundation
import UIKit

class InfoSection: UIView {
    
    // MARK: Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    // MARK: Init
    init() {
        super.init(frame: .zero)
        configurateView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateView() {
        addLabelToView()
        addContentViewToView()
    }
    
    /**
    Agrega label de titulo en la vista
    */
    private func addLabelToView() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10)
        ])
    }
    
    /**
    Agrega un UIView para contenido en la vista
    */
    private func addContentViewToView() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    /**
    Setea un UIView dentro del contentView
    - Parameters:
        - view: View que quiere ser agregada como contenido
    */
    public func setContentView(view: UIView) {
        contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
