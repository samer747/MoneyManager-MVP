//
//  Persitence.swift
//  MoneyManager-MVP
//
//  Created by samer on 07/08/2021.
//

import Foundation


enum Persitence {
    
    static private let defaults = UserDefaults.standard
    
    static func saveFirstOpen(int : Int) -> SMSError? {
        do {
            let encoder = JSONEncoder()
            
            
            let encodedArray = try encoder.encode(int)
            defaults.set(encodedArray, forKey: "samer")
            
            // No Error
            return nil
        }catch{
            return .unableToComplete
        }
    }
    
    
    static func retriveIfFirstOpen(completed: @escaping (Result<Int,SMSError>) -> Void){
        
        guard let dataUser = defaults.object(forKey: "samer") as? Data else {
            completed(.success(0))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let decodedArray = try decoder.decode(Int.self, from: dataUser)
            completed(.success(decodedArray))
        }catch{
            completed(.failure(.unableToComplete))
        }
    }
    
    
}
