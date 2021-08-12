//
//  HomeVCInteractor.swift
//  MoneyManager-MVP
//
//  Created by samer on 16/07/2021.
//

import Foundation



class HomeVCInteractor {
    
    func getDailyTransactions() -> [Transaction] {
        var arrr = RealmManger.shared.getAllIncome() + RealmManger.shared.getAllExpense() + RealmManger.shared.getAllTransfer()
        arrr.sort(by: { $0.date.compare($1.date) == ComparisonResult.orderedDescending})
        
        return arrr
    }
    
}
