//
//  ItemModel.swift
//  Desafio11
//
//  Created by Turma01-8 on 03/11/25.
//

import Foundation

struct Item: Identifiable, Decodable, Equatable {
    var categoria_id: Int
    var id: Int
    var nome: String
    var image: String
}
