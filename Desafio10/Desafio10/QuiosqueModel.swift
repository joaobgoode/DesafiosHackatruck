//
//  QuiosqueModel.swift
//  Desafio10
//
//  Created by Turma01-8 on 31/10/25.
//

import Foundation
import MapKit


struct Quiosque: Identifiable, Hashable, Decodable {
    let _id: String
    let _rev: String
    let praia_id: String
    let nome: String
    let latitude: Double
    let longitude: Double
    var id: String { _id }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
