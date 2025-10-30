//
//  MarcaModel.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import Foundation

struct Marca: Identifiable, Codable, Item {
    var codigo: String
    var nome: String
    var id: String { codigo }
}

class MarcaModel: ObservableObject {
    @Published var marcas: [Marca] = []
    
    func fetch(){
        guard let url = URL(string: "https://parallelum.com.br/fipe/api/v1/carros/marcas") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Marca].self, from: data)
                
                DispatchQueue.main.async {
                    self?.marcas = parsed
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
}
