//
//  DetalhesModel.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import Foundation
import SwiftUI


struct Detalhes: Decodable, Equatable {
    var TipoVeiculo: Int? = 0
    var Valor: String? = ""
    var Marca: String? = ""
    var Modelo: String? = ""
    var AnoModelo: Int? = 0
    var Combustivel: String? = ""
    var CodigoFipe: String? = ""
    var MesReferencia: String? = ""
    var SiglaCombustivel: String? = ""
}

class Detalhesview: ObservableObject {
    @Published var detalhes: Detalhes = Detalhes()
    
    func fetch(marca_id: String, modelo_id: Int, ano_id: String){
        guard let url = URL(string: "https://parallelum.com.br/fipe/api/v1/carros/marcas/\(marca_id)/modelos/\(modelo_id)/anos/\(ano_id)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode(Detalhes.self, from: data)
                
                print(url)
                print(parsed)
                
                DispatchQueue.main.async {
                    self?.detalhes = parsed
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
    }
}

