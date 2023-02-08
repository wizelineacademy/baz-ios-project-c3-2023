//
//  StringExtension.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 02/02/23.
//

import Foundation

extension String {
    
    /**
     Convierte el valor de la cadena del formato inicial al nuevo, si el valor de la cadena no corresponde a una fecha regresa un nulo
     
     - Parameters:
        - format: corresponde al formato actual de la fecha
        - newFormat: corresponde al nuevo formato al que desea convertir la fecha
     - Returns: regresa una cadena con la fecha en el formato recibido, de no ser posible regresa un valor nulo
     
     ````
     publishedDate.convertDate(format: "yyyy-MM-dd", to: "dd MMMM yyyy")
     ````
    */
    func convertDate(format: String, to newFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let date = formatter.date(from: self) else {
            return nil
        }
        formatter.dateFormat = newFormat
        return formatter.string(from: date)
    }
}
