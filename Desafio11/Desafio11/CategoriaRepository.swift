//
//  CategoriaRepository.swift
//  Desafio11
//
//  Created by Turma01-8 on 03/11/25.
//

import Foundation

class CategoriaRepository: ObservableObject {
    @Published var categorias: [Categoria] = []
    
    func fetch() {
        guard let url = URL(string: "http://localhost:1880/api/categorias") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([CategoriaResponse].self, from: data)
                
                DispatchQueue.main.async {
                    self?.categorias = parsed.map { cat in
                        Categoria(
                            parent_id: cat.parent_id,
                            id: cat.id,
                            nome: cat.nome,
                            itens: [],
                            subcategorias: [],
                            image: cat.image
                        )
                    }
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
