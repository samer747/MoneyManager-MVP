//
//  AddAccountPresenter.swift
//  MoneyManager-MVP
//
//  Created by samer on 07/08/2021.
//

import Foundation



class AddAccountInteractor {
    
    
    func addAccount(name: String , amount: Float){
        
        RealmManger.shared.addAccount(name: name, groupName: "", amount: amount)
    }
}
