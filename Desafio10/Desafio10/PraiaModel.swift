//
//  PraiaModel.swift
//  Desafio10
//
//  Created by Turma01-8 on 31/10/25.
//

import Foundation
import MapKit


struct Praia: Identifiable, Hashable, Decodable {
    let _id: String
    let _rev: String
    let nome: String
    let latitude: Double
    let longitude: Double
    let descricao: String
    var id: String { _id }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
