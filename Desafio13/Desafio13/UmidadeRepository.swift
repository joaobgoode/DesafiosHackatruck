//
//  UmidadeRepository.swift
//  Desafio13
//
//  Created by Turma01-8 on 07/11/25.
//

import Foundation

class UmidadeRepository: ObservableObject {
    @Published var umidades: [Umidade] = []
    
    func fetch(_ n: Int) {
        guard let url = URL(string: "http://localhost:1880/umidade/\(n)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let parsed = try JSONDecoder().decode([Umidade].self, from: data)
                
                DispatchQueue.main.async {
                    self?.umidades = parsed
                    print(parsed)

                }
                
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
