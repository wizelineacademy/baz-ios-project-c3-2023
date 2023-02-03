import UIKit

enum tipoSangre{
    case A,B,O,AB
}

enum RH:String{
    case negativo = "-", positivo = "+"
}

struct CaracteristicasSanguineas{
    var tipoSangre:tipoSangre
    var sangreRH:RH
}

class Persona{
    var nombre:String
    var genero: String
    var caracteristicasSangiuineas:CaracteristicasSanguineas
    init(nombre:String, genero:String , caracteristicasSanguineas:CaracteristicasSanguineas){
        self.nombre = nombre
        self.genero = genero
        self.caracteristicasSangiuineas = caracteristicasSanguineas
    }
    
    func printData(){
        print("nombre:\(self.nombre), genero:\(self.genero), tipoSangre \(self.caracteristicasSangiuineas.tipoSangre) \(self.caracteristicasSangiuineas.sangreRH.rawValue)")
    }
}

let mario = Persona(nombre: "Mario", genero: "Masculino", caracteristicasSanguineas: CaracteristicasSanguineas.init(tipoSangre: .B, sangreRH: .positivo))

mario.printData()
