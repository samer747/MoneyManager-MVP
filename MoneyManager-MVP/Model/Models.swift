//
//  Models.swift
//  MoneyManager-MVP
//
//  Created by samer on 16/07/2021.
//

import Foundation
import  RealmSwift


class Account: Object {
    @objc dynamic var name = ""
    @objc dynamic var groupName = ""
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var uuidString:String = NSUUID().uuidString
    
    override init() {
        super.init()
    }
    
    init(name: String, groupName: String, amount: Float) {
        uuidString = NSUUID().uuidString
        self.name = name
        self.groupName = groupName
        self.amount = amount
    }
}

class IncomeCategory: Object {
    @objc dynamic var name = ""
    @objc dynamic var uuidString:String = NSUUID().uuidString
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        uuidString = NSUUID().uuidString
        self.name = name
    }
}
class ExpenseCategory: Object {
    @objc dynamic var name = ""
    @objc dynamic var uuidString:String = NSUUID().uuidString
    
    override init() {
        super.init()
    }
    
    init(name: String) {
        uuidString = NSUUID().uuidString
        self.name = name
    }
}


class Transaction: Object {
    @objc dynamic var uuidString:String = NSUUID().uuidString
    @objc dynamic var date: Date = Date()
    @objc dynamic var amount: Float = 0.0
    @objc dynamic var note = ""
    
    override init() {
        super.init()
    }
    
    init(amount: Float, note: String) {
        
        self.amount = amount
        self.note = note
    }
}


class Income: Transaction {

    @objc dynamic var accountName = ""
    @objc dynamic var incomeCategoryName = ""
    
    override init() {
        super.init()
    }
    
    init(accountName: String, incomeCategoryName: String, amount: Float, note: String) {
        super.init(amount: amount, note: note)
        self.accountName = accountName
        self.incomeCategoryName = incomeCategoryName
    }
    
    init(accountName: String, incomeCategoryName: String, amount: Float, note: String, date: Date) {
        super.init(amount: amount, note: note)
        self.accountName = accountName
        self.incomeCategoryName = incomeCategoryName
        self.date = date
    }
}



class Expense: Transaction {

    @objc dynamic var accountName = ""
    @objc dynamic var expenseCategoryName = ""
    
    override init() {
        super.init()
    }
    
    init(accountName: String, expenseCategoryName: String, amount: Float, note: String) {
        super.init(amount: amount, note: note)
        self.accountName = accountName
        self.expenseCategoryName = expenseCategoryName
    }
    
    init(accountName: String, expenseCategoryName: String, amount: Float, note: String,date: Date) {
        super.init(amount: amount, note: note)
        self.accountName = accountName
        self.expenseCategoryName = expenseCategoryName
        self.date = date
    }
}



class Transfer: Transaction {

    @objc dynamic var fromAccountName = ""
    @objc dynamic var toAccountName = ""
    @objc dynamic var feesExpenseUUID: String?
    
    override init() {
        super.init()
    }
    
    init(fromAccountName: String, toAccountName: String, amount: Float, note: String, feesExpenseUUID: String?) {
        super.init(amount: amount, note: note)
        self.fromAccountName = fromAccountName
        self.toAccountName = toAccountName
        self.feesExpenseUUID = feesExpenseUUID
    }
    
    init(fromAccountName: String, toAccountName: String, amount: Float, note: String, date: Date, feesExpenseUUID: String?) {
        super.init(amount: amount, note: note)
        self.fromAccountName = fromAccountName
        self.toAccountName = toAccountName
        self.date = date
        self.feesExpenseUUID = feesExpenseUUID
    }
}

enum CategoryType: String  {
     case expense
     case income
}

