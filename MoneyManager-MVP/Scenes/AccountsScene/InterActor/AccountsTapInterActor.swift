//
//  AccountsTapInterActor.swift
//  MoneyManager-MVP
//
//  Created by samer on 31/07/2021.
//

import Foundation



class AccountsTapInterActor {
    
    func getAccounts() -> [Account] {
        
       return RealmManger.shared.getAllAccounts()
    }
    
    
}
