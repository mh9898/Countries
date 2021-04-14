//
//  NetworkManager.swift
//  Countries
//
//  Created by MiciH on 4/13/21.
//

import Foundation

class NetworkManager {
    
    static let shard = NetworkManager()
    private let baseURL = "https://restcountries.eu"
    
    private init() {}
    
    func getCountries(completed: @escaping (Result<[Country], CTError>) -> Void){
        let endPoint = baseURL + "/rest/v2/all"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.domainError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error{
                completed(.failure(.InternetError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.dataError))
                return
            }
            
            guard let data = data else{
                completed(.failure(.dataError))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let countries = try decoder.decode([Country].self, from: data)
                completed(.success(countries))
            }catch{
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
}
