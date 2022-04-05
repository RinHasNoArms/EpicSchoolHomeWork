//
//  NetworkService.swift
//  homeWork
//
//  Created by Александр Романов on 27.03.2022.
//

import UIKit

final class NetworkService {
    
    private var dataTask: URLSessionDataTask?
    
    func downloadData<T: Decodable>(for urlString: String, completion: @escaping (Result<[T]?, Error>) -> Void) {
    
        guard let url = URL(string: urlString) else { return}
        
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            defer {
                self.dataTask = nil
            }
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Empty response")
                return
            }
            print("Response status code \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode([T].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))}
                } catch {
                    completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
