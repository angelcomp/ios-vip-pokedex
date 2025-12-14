//
//  ApiManager.swift
//  ios-vip-pokedex
//
//  Created by Angelica dos Santos on 30/06/23.
//

import Foundation

protocol ApiManagerProtocol {
    var baseURL: String { get }
    func getPokemons(endpoint: String, params: [String:String]?, completion: @escaping (Result<Pokemon, Error>?) -> Void)
    func getBerry(endpoint: String, params: [String:String]?, completion: @escaping (Result<Berry, Error>?) -> Void)
}

class ApiManager: ApiManagerProtocol {
    var baseURL: String = "http://localhost:3000"
    
    func getBerry(endpoint: String, params: [String : String]?, completion: @escaping (Result<Berry, Error>?) -> Void) {
        if let url = URL(string: baseURL + endpoint) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    completion(.failure(error!))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                        guard let safeData = data else { return }
                        let decoder = JSONDecoder()
                        do {
                            let decodedData: Berry = try decoder.decode(Berry.self, from: safeData)
                            
                            completion(.success(decodedData))
                            
                        } catch  {
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    func getPokemons(endpoint: String, params: [String:String]?, completion: @escaping (Result<Pokemon, Error>?) -> Void) {
        if let url = URL(string: baseURL + endpoint) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    completion(.failure(error!))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if (200...299).contains(httpResponse.statusCode) {
                        guard let safeData = data else { return }
                        let decoder = JSONDecoder()
                        do {
                            let decodedData: Pokemon = try decoder.decode(Pokemon.self, from: safeData)
                            
                            completion(.success(decodedData))
                            
                        } catch  {
                            print(error)
                            completion(.failure(error))
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
}
