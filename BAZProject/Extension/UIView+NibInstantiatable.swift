//
//  NibInstantiatableProtocol.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

protocol NibInstantiatable {
    static var NibName: String { get }
}

extension NibInstantiatable {

    static var NibName: String { return String(describing: self) }

    /// This method  create  instance for a nib
    ///  - Returns: an instance of `Self`
    ///
    static func instantiate() -> Self {
        return instantiateWithName(name: NibName)
    }
    /// This method  create  instance for a nib with the owner property
    ///  - Parameters:
    ///   - owner: of type `AnyObject?`
    ///  - Returns: an instance of `Self`
    ///
    static func instantiateWithOwner(owner: AnyObject?) -> Self {
        return instantiateWithName(name: NibName, owner: owner)
    }

    /// This method  create  instance for a nib with the name of the nib and the owner property
    ///  - Parameters:
    ///   - name: the name of the nib as type `String`
    ///   - owner: of type `AnyObject?`
    ///  - Returns: an instance of `Self`
    ///
    static func instantiateWithName(name: String, owner: AnyObject? = nil) -> Self {
        let nib = UINib(nibName: name, bundle: nil)
        guard let view = nib.instantiate(withOwner: owner, options: nil).first as? Self else {
            fatalError("failed to load \(name) nib file")
        }
        return view
    }
}
