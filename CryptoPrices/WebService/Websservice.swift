//
//  Websservice.swift
//  CryptoPrices
//
//  Created by Halil Kaya on 18.09.2021.
//

import Foundation


class Webservice{
    
    func downloadCurrencies(url : URL, completion: @escaping (Result<[CryptoCurrency]?,DownloaderError>)-> Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.errorFromURL))
            }
            guard let data = data, error == nil else{
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else{
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))
        }.resume()
    }
}
enum DownloaderError : Error{
    
    case errorFromURL
    case noData
    case dataParseError
}
