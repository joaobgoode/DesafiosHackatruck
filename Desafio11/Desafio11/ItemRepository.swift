//
//  ItemRepository.swift
//  Desafio11
//
//  Created by Turma01-8 on 03/11/25.
//

import Foundation

class ItemRepository: ObservableObject {
    @Published var items: [Item] = []
    
    func fetch(){
        guard let url = URL(string: "http://localhost:1880/api/items") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Item].self, from: data)
                
                DispatchQueue.main.async {
                    self?.items = parsed
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
}
