//
//  AnosModel.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import Foundation

struct Ano: Codable, Identifiable, Item {
    var codigo: String
    var nome: String
    var id: String { codigo }
}

class AnosView: ObservableObject {
    @Published var anos: [Ano] = []
    
    func fetch(marca_id: String, modelo_id: Int){
        guard let url = URL(string: "https://parallelum.com.br/fipe/api/v1/carros/marcas/\(marca_id)/modelos/\(modelo_id)/anos") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Ano].self, from: data)
                
                DispatchQueue.main.async {
                    self?.anos = parsed
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
}
