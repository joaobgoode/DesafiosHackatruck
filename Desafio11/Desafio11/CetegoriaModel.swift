//
//  CetegoriaModel.swift
//  Desafio11
//
//  Created by Turma01-8 on 03/11/25.
//

import Foundation

struct Categoria: Identifiable, Equatable {
    var parent_id: Int
    var id: Int
    var nome: String
    var itens: [Item]
    var subcategorias: [Categoria]
    var image: String
    
    func isParentOf(other: Categoria) -> Bool {
        return id == other.parent_id
    }
    
    mutating func getSubcategorias(categorias: [Categoria]){
        subcategorias = categorias.filter{
            isParentOf(other: $0)
        }
    }
    
    func containsItem(item: Item) -> Bool {
        return id == item.categoria_id
    }
    
    mutating func getItems(items: [Item]){
        itens = items.filter{
            containsItem(item: $0)
        }
    }
}

struct CategoriaResponse: Decodable {
    var parent_id: Int
    var id: Int
    var nome: String
    var image: String
}
