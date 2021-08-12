//
//  AddTransactionPresenter.swift
//  MoneyManager-MVP
//
//  Created by samer on 18/07/2021.
//

import Foundation

protocol AddTransactionView: AnyObject {
    var presenter : AddTransactionPresenter? { get set }
}


class AddTransactionPresenter {
    
    
    private var interactor: AddTransactionInteracor
    private var router: AddTransactionRouter
    private weak var view: AddTransactionView?
    
    
    
    init(interactor: AddTransactionInteracor,router: AddTransactionRouter,view: AddTransactionView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func saveIncome(accountName: String, incomeCategoryName: String, amount: String, note: String) {
        if accountName != "" || incomeCategoryName != "" , amount != "" {
            
            RealmManger.shared.addIncome(accountName: accountName, category: incomeCategoryName, amount: Float(amount) ?? 0.0, note: note)
            router.dismissTransactionVC(view: view as! AddTransactionView)
        }
    }
    func saveExpence(accountName: String, expenseCategoryName: String, amount: String, note: String) {
        
        if accountName != "" || expenseCategoryName != "" , amount != "" {
            
            RealmManger.shared.addExpense(accountName: accountName, category: expenseCategoryName, amount: Float(amount) ?? 0.0, note: note)
        }
        router.dismissTransactionVC(view: view as! AddTransactionView)
    }
    
    func dismissAddTransactionView(){
        
        router.dismissTransactionVC(view: view as! AddTransactionView)
    }
    
    
    func saveTransfer(fees: String, fromAccountName: String, toAccountName: String, amount: String, note: String) {
        
        if amount != "" || fromAccountName != "" , toAccountName != "" {
            
            RealmManger.shared.addTransfer(fees: Float(fees) ?? 0.0, fromAccountName: fromAccountName, toAccountName: toAccountName, amount: Float(amount) ?? 0.0, note: note)
        }
        router.dismissTransactionVC(view: view!)
        
    }
    
    
}
