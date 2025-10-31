
import Foundation

class QuiosqueView: ObservableObject {
    @Published var quiosque: [Quiosque] = []
    
    func fetch(){
        guard let url = URL(string: "http://localhost:1880/quiosque") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let parsed = try JSONDecoder().decode([Quiosque].self, from: data)
                
                DispatchQueue.main.async {
                    self?.quiosque = parsed
                }
            }
            
            catch{
                print(error)
            }
            
        }
        
        task.resume()
        
    }
}
