//
//  AccDetailsInteractor.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import Foundation


class AccDetailsInteractor {
    
    func getDailyTransactions() -> [Transaction] {
        var arrr = RealmManger.shared.getAllIncome() + RealmManger.shared.getAllExpense() + RealmManger.shared.getAllTransfer()
        arrr.sort(by: { $0.date.compare($1.date) == ComparisonResult.orderedDescending})
        
        return arrr
    }
    
}
