//
//  ModelosModel.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import Foundation

struct Modelo: Codable, Identifiable, Item {
    var codigo: Int
    var nome: String
    var id: Int { codigo }
}



struct ModeloResponse: Codable {
    var anos: [Ano]
    var modelos: [Modelo]
}

class ModeloView: ObservableObject {
    @Published var modelosResponse: ModeloResponse = ModeloResponse(anos: [], modelos: [])
    @Published var modelos: [Modelo] = []
    
    func fetch(codigo: String){
        guard let url = URL(string: "https://parallelum.com.br/fipe/api/v1/carros/marcas/\(codigo)/modelos") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode(ModeloResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.modelosResponse = parsed
                    self?.modelos = parsed.modelos
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
}
