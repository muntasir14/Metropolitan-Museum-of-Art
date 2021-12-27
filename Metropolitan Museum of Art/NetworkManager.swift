//
//  NetworkManager.swift
//  Metropolitan Museum of Art
//
//  Created by Mobile Apps Team on 27/12/21.
//

import Foundation


class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() { }
    
    
    public func get<T : Decodable>(urlString: String, responseType: T.Type, completionHandler: @escaping (_ dataModel: T) -> Void) {
        
        
        guard let url = URL(string: urlString) else {
            
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            print("url", url)
            print("data", data)
            print("response", response)
            print("error", error)
            
            var decodedData: T?
            do{
                decodedData = try JSONDecoder().decode(T.self, from: data!)
                print("Decoded Data", decodedData as Any)
            } catch {
                
                // handle error
                print("decode error:", error)
            }
            
            guard let safelyDecodedData = decodedData else {
                return
            }
            
            completionHandler(safelyDecodedData)
            
        }.resume()
        
    }
    
}
