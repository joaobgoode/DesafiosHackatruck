//
//  MarcaModel.swift
//  Desafio09
//
//  Created by Turma01-8 on 29/10/25.
//

import Foundation

class PraiaView: ObservableObject {
    @Published var praias: [Praia] = []
    
    func fetch(){
        guard let url = URL(string: "http://localhost:1880/praia") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Praia].self, from: data)
                                
                DispatchQueue.main.async {
                    self?.praias = parsed
                    print("✅ Praias carregadas:", parsed.count)
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
}
