//
//  NetworkingProvider+Protocol.swift
//  BAZProject
//
//  Created by 1058889 on 23/01/23.
//

import Foundation

protocol NetworkingProviderProtocol: AnyObject {
    func sendRequest(requestType: RequestType,
                     completion: @escaping (_ success: Bool,
                                            _ result: Data?
                     ) -> Void )
}
