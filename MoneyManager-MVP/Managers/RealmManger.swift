//
//  RealmManger.swift
//  Union Play
//
//  Created by samer on 19/06/2021.
//

import Foundation
import RealmSwift



enum RealmTypes  {
    case live
    case series
    case movie
}


class RealmManger {
    static let shared   = RealmManger() //singleton
    
    
    lazy var realm = try! Realm()
    
    
    //MARK:- Account Section
    func addAccount(name: String, groupName: String, amount: Float) {
        
        let account = Account(name: name, groupName: groupName, amount: amount)
        
        do {
            try realm.write { realm.add(account) }
        }catch{
            print(error)
        }
    }
    
    func getAccByName(name: String) -> Account?{
        
        
        let obj = realm.objects(Account.self).filter("name = '\(name)'").first
        
        
        return obj
        
    }
    
    func deleteAccount(uuidString: String){
        
        do {
            try realm.write {
                guard let obj = realm.objects(Account.self).filter("uuidString = '\(uuidString)'").first else { return }
                
                let obj0 = realm.objects(Income.self).filter("accountName = '\(obj.name)'")
                let obj1 = realm.objects(Expense.self).filter("accountName = '\(obj.name)'")
                let obj2 = realm.objects(Transfer.self).filter("fromAccountName = '\(obj.name)'")
                let obj3 = realm.objects(Transfer.self).filter("toAccountName = '\(obj.name)'")
                
                realm.delete(obj)
                realm.delete(obj0)
                realm.delete(obj1)
                realm.delete(obj2)
                realm.delete(obj3)
            }
            
        }catch{
            print(error)
        }
    }
    
    func addAmountToAcc(name: String, amount: Float) {
        
        do {
            try realm.write {
                guard let obj = realm.objects(Account.self).filter("name = '\(name)'").first else { return }
                if amount > 0.0{obj.amount += amount}
            }
            
        }catch{
            print(error)
        }
    }
    
    func removeAmountToAcc(name: String, amount: Float) {
        
        do {
            try realm.write {
                guard let obj = realm.objects(Account.self).filter("name = '\(name)'").first else { return }
                if amount > 0.0{ obj.amount -= amount }
            }
            
        }catch{
            print(error)
        }
    }
    
    func TransferAccountsAmount(fromName: String, toName: String, amount: Float) {
        
        
        do {
            try realm.write {
                guard let fromObj = realm.objects(Account.self).filter("name = '\(fromName)'").first else { return }
                guard let toObj = realm.objects(Account.self).filter("name = '\(toName)'").first else { return }
                if amount != nil || amount > 0.0{
                    toObj.amount += amount
                    fromObj.amount -= amount
                }
            }
            
        }catch{
            print(error)
        }
    }
    
    
    func editeAccount(uuidString: String, newName: String?, newAmount: Float?){
        
        var a : Float = 0.0
        var n = ""
        do {
            try realm.write {
                guard let obj = realm.objects(Account.self).filter("uuidString = '\(uuidString)'").first else { return }
                a = obj.amount
                n = obj.name
                if newName != nil {
                    
                    let obj0 = realm.objects(Income.self).filter("accountName = '\(obj.name)'")
                    let obj1 = realm.objects(Expense.self).filter("accountName = '\(obj.name)'")
                    let obj2 = realm.objects(Transfer.self).filter("fromAccountName = '\(obj.name)'")
                    let obj3 = realm.objects(Transfer.self).filter("toAccountName = '\(obj.name)'")
                    obj.name = newName ?? ""
                    obj0.forEach { inc in
                        inc.accountName = newName ?? "NULL"
                    }
                    obj1.forEach { exp in
                        exp.accountName = newName ?? "NULL"
                    }
                    obj2.forEach { transfer in
                        transfer.fromAccountName = newName ?? "NULL"
                    }
                    obj3.forEach { transfer in
                        transfer.toAccountName = newName ?? "NULL"
                    }
                    
                }
                
                if newAmount != nil {
                    
                    
                    if newAmount ?? 0.0 > a {
                        
                        print(newAmount ?? 0.0)
                        print(a)
                        
                        let income = Income(accountName: n, incomeCategoryName: "Other", amount: newAmount! - a, note: "")
                        realm.add(income)
                        
                    }else{
                        
                        let expense = Expense(accountName: n, expenseCategoryName: "Other", amount: a - newAmount!, note: "")
                        realm.add(expense)
                    }
                    obj.amount = newAmount ?? 0.0
                }
                
                
            }
            
        }catch{
            print(error)
        }
    }
    
    
    //MARK:- Category Section
    func addCategory(name: String, categoryType: CategoryType) {
        
        
        switch categoryType {
        case .expense:
            let account = ExpenseCategory(name: name)
            
            do {
                try realm.write { realm.add(account) }
            }catch{
                print(error)
            }
        case .income:
            let account = IncomeCategory(name: name)
            
            do {
                try realm.write { realm.add(account) }
            }catch{
                print(error)
            }
        }
        
    }
    
    func deleteCategory(uuidString: String, categoryType: CategoryType){
        
        switch categoryType {
        
        case .expense:
            do {
                try realm.write {
                    guard let obj = realm.objects(ExpenseCategory.self).filter("uuidString = '\(uuidString)'").first else { return }
                    realm.delete(obj)
                }
                
            }catch{
                print(error)
            }
        case .income:
            do {
                try realm.write {
                    guard let obj = realm.objects(IncomeCategory.self).filter("uuidString = \(uuidString)").first else { return }
                    realm.delete(obj)
                }
                
            }catch{
                print(error)
            }
        }
    }
    
    
    func editeCategory(uuidString: String, newName: String, categoryType: CategoryType){
        switch categoryType {
        
        case .expense:
            do {
                try realm.write {
                    guard let obj = realm.objects(ExpenseCategory.self).filter("uuidString = \(uuidString)").first else { return }
                    obj.name = newName
                }
                
            }catch{
                print(error)
            }
        case .income:
            do {
                try realm.write {
                    guard let obj = realm.objects(IncomeCategory.self).filter("uuidString = \(uuidString)").first else { return }
                    obj.name = newName
                }
                
            }catch{
                print(error)
            }
        }
    }
    
    
    //MARK:- Income Section
    
    func getIncomeByID(uuid: String) -> Income?{
        
        
        let incomeObj = realm.objects(Income.self).filter("uuidString = '\(uuid)'").first
        
        
        return incomeObj
        
    }
    
    func addIncome(accountName: String, category: String, amount: Float, note: String) {
        
        let income = Income(accountName: accountName, incomeCategoryName: category, amount: amount, note: note)
        
        do {
            try realm.write { realm.add(income) }
        }catch{
            print(error)
        }
        addAmountToAcc(name: accountName, amount: amount)
    }
    
    func deleteIncome(uuidString: String){
        var name = ""
        var amount: Float = 0.0
        do {
            try realm.write {
                guard let obj = realm.objects(Income.self).filter("uuidString = '\(uuidString)'").first else { return }
                name = obj.accountName
                amount = obj.amount
                realm.delete(obj)
            }
        }catch{
            print(error)
        }
        
        print(name , amount)
        
        if name != "" && amount > 0.0 {
            removeAmountToAcc(name: name, amount: amount)
        }
        
        
    }
    
    
    func editeIncome(uuidString: String ,newAccountName: String, newIncomeCategoryName: String, newAmountt: Float, newNote: String){
        var name = ""
        var newAmount: Float = newAmountt
        var oldAmount: Float = 0.0
        
        do {
            guard let obj = realm.objects(Income.self).filter("uuidString = '\(uuidString)'").first else { return }
            try realm.write {
                
                name = obj.accountName
                oldAmount = obj.amount
                
                obj.accountName = newAccountName
                obj.incomeCategoryName = newIncomeCategoryName
                obj.amount = newAmountt
                obj.note = newNote
                
                
            }
            
        }catch{
            print(error)
        }
        
        if name != "" && oldAmount != newAmount{
            if oldAmount > newAmount {
                removeAmountToAcc(name: name, amount: (oldAmount - newAmount))
            }else {
                addAmountToAcc(name: name, amount: (newAmount - oldAmount))
            }
        }
        
    }
    
    
    //MARK:- Expense Section
    
    func getExpenseByID(uuid: String) -> Expense?{
        
        
        let expObj = realm.objects(Expense.self).filter("uuidString = '\(uuid)'").first
        
        
        return expObj
        
    }
    
    func getFeesAmountExpenseByID(uuid: String) -> Float{
        
        if uuid == "" {
            return 0.0
        }
        guard let expObj = realm.objects(Expense.self).filter("uuidString = '\(uuid)'").first else { return 0.0 }
        
        
        return expObj.amount
        
    }
    
    
    func addExpense(accountName: String, category: String, amount: Float, note: String) {
        
        let expense = Expense(accountName: accountName, expenseCategoryName: category, amount: amount, note: note)
        
        do {
            try realm.write { realm.add(expense) }
        }catch{
            print(error)
        }
        
        removeAmountToAcc(name: accountName, amount: amount)
    }
    
    
    func deleteExpense(uuidString: String){
        var dAmount: Float = 0.0
        var dName: String = ""
        do {
            try realm.write {
                guard let obj = realm.objects(Expense.self).filter("uuidString = '\(uuidString)'").first else { return }
                dAmount = obj.amount
                dName = obj.accountName
                realm.delete(obj)
            }
            
        }catch{
            print(error)
        }
        
        addAmountToAcc(name: dName, amount: dAmount)
    }
    
    
    func editeExpense(uuidString: String ,newAccountName: String, newExpenseCategoryName: String, newAmount: Float, newNote: String){
        
        var name = ""
        var newAmount: Float = newAmount
        var oldAmount: Float = 0.0
        do {
            try realm.write {
                guard let obj = realm.objects(Expense.self).filter("uuidString = '\(uuidString)'").first else { return }
                
                
                name = obj.accountName
                oldAmount = obj.amount
                
                obj.accountName = newAccountName
                obj.expenseCategoryName = newExpenseCategoryName
                obj.amount = newAmount
                obj.note = newNote
            }
            
        }catch{
            print(error)
        }
        if name != "" && oldAmount != newAmount{
            if oldAmount > newAmount {
                addAmountToAcc(name: name, amount: (oldAmount - newAmount))
            }else {
                removeAmountToAcc(name: name, amount: (newAmount - oldAmount))
            }
        }
    }
    
    //MARK:- Transfer Section
    
    func getTransferByID(uuid: String) -> Transfer?{
        let expObj = realm.objects(Transfer.self).filter("uuidString = '\(uuid)'").first
        
        return expObj
    }
    
    
    func addTransfer(fees: Float?,fromAccountName: String, toAccountName: String, amount: Float, note: String) {
        
        do {
            
            if fees == 0.0 || fees == nil {
                
                let transfer = Transfer(fromAccountName: fromAccountName, toAccountName: toAccountName, amount: amount, note: note, feesExpenseUUID: nil)
                try realm.write { realm.add(transfer) }
                
            }else{
                
                let exp = Expense(accountName: fromAccountName, expenseCategoryName: "Other", amount: fees!, note: "")
                
                let transfer = Transfer(fromAccountName: fromAccountName, toAccountName: toAccountName, amount: amount, note: note, feesExpenseUUID: exp.uuidString)
                try realm.write {
                    realm.add(transfer)
                    realm.add(exp)
                }
                
            }
            
            
            
        }catch{
            print(error)
        }
        
        if fees == 0.0 || fees == nil {
            TransferAccountsAmount(fromName: fromAccountName, toName: toAccountName, amount: amount)
        }else{
            TransferAccountsAmount(fromName: fromAccountName, toName: toAccountName, amount: amount)
            removeAmountToAcc(name: fromAccountName, amount: fees ?? 0.0)
        }
    }
    
    func deleteTransfer(uuidString: String){
        
        var objFeess = ""
        var fromAcc = ""
        var toAcc = ""
        var amount:Float = 0.0
        var fees:Float = 0.0
        
        
        do {
            try realm.write {
                guard let obj = realm.objects(Transfer.self).filter("uuidString = '\(uuidString)'").first else { return }
                objFeess = obj.feesExpenseUUID ?? ""
                fromAcc = obj.fromAccountName
                toAcc = obj.toAccountName
                amount = obj.amount
                realm.delete(obj)
                if objFeess != ""{
                    guard let objFees = realm.objects(Expense.self).filter("uuidString = '\(objFeess)'").first else { return }
                    fees = objFees.amount
                    realm.delete(objFees)
                }
                
            }
            
        }catch{
            print(error)
        }
        
        if fees != 0.0{
            addAmountToAcc(name: fromAcc, amount: fees)
        }
        TransferAccountsAmount(fromName: toAcc, toName: fromAcc, amount: amount)
    }
    
    
    func editeTransfer(uuidString: String ,toAccountName: String, fromAccountName: String, newAmount: Float, newNote: String,fees: Float){
        
        var oldToAcc = ""
        var oldFromAcc = ""
        var oldAmount: Float = 0.0
        var oldFees: Float = 0.0
        
        do {
            try realm.write {
                guard let obj = realm.objects(Transfer.self).filter("uuidString = '\(uuidString)'").first else { return }
                
                oldAmount = obj.amount
                oldToAcc = obj.toAccountName
                oldFromAcc = obj.fromAccountName
                
                obj.fromAccountName = fromAccountName
                obj.toAccountName = toAccountName
                obj.amount = newAmount
                obj.note = newNote
                
                if obj.feesExpenseUUID != nil  {
                    if let objF = realm.objects(Expense.self).filter("uuidString = '\(obj.feesExpenseUUID ?? "")'").first {
                        oldFees = objF.amount
                        objF.amount = fees
                        if fees == 0 {
                            realm.delete(objF)
                        }
                    }else{
                        let exp = Expense(accountName: fromAccountName, expenseCategoryName: "Other", amount: fees, note: "", date: obj.date)
                        realm.add(exp)
                        obj.feesExpenseUUID = exp.uuidString
                    }
                } else{
                    if fees != 0.0 {
                        let exp = Expense(accountName: fromAccountName, expenseCategoryName: "Other", amount: fees, note: "", date: obj.date)
                        realm.add(exp)
                        obj.feesExpenseUUID = exp.uuidString
                    }
                }
            }
        }catch{
            print(error)
        }
        
        if oldFees != fees {
            if oldFees != 0.0 {
                
                addAmountToAcc(name: oldFromAcc, amount: oldFees)
            }
            if fees != 0.0 {
                removeAmountToAcc(name: fromAccountName, amount: fees)
            }
        }
        
        
        if toAccountName != oldToAcc || oldFromAcc != fromAccountName {
            
            if toAccountName != oldToAcc {
                removeAmountToAcc(name: oldToAcc, amount: oldAmount)
                addAmountToAcc(name: toAccountName, amount: newAmount)
            }
            
            if oldFromAcc != fromAccountName {
                addAmountToAcc(name: oldFromAcc, amount: oldAmount)
                removeAmountToAcc(name: fromAccountName, amount: newAmount)
            }
        }else{
            
            if oldAmount > newAmount {
                
                addAmountToAcc(name: fromAccountName, amount: (oldAmount - newAmount))
                removeAmountToAcc(name: toAccountName, amount: (oldAmount - newAmount))
            }else{
                
                addAmountToAcc(name: toAccountName, amount: (newAmount - oldAmount))
                removeAmountToAcc(name: fromAccountName, amount: (newAmount - oldAmount))
            }
        }
        
    }
    
    
    //MARK:- Get Accounts Section
    
    func getAllAccounts() -> [Account] {
        
        let obj = realm.objects(Account.self)
        
        var arr: [Account] = []
        obj.forEach { acc in
            arr.append(acc)
        }
        return arr
    }
    
    //MARK:- Get Income Categories Section
    
    func getAllIncomeCategories() -> [IncomeCategory] {
        
        let obj = realm.objects(IncomeCategory.self)
        
        var arr: [IncomeCategory] = []
        obj.forEach { acc in
            arr.append(acc)
        }
        return arr
    }
    
    //MARK:- Get Expense Categories Section
    
    func getAllExpenseCategories() -> [ExpenseCategory] {
        
        let obj = realm.objects(ExpenseCategory.self)
        
        var arr: [ExpenseCategory] = []
        obj.forEach { acc in
            arr.append(acc)
        }
        return arr
    }
    
    //MARK:- Get Transactions Section
    
    func getAllIncome() -> [Income] {
        
        let obj = realm.objects(Income.self)
        
        var arr: [Income] = []
        obj.forEach { acc in
            arr.append(acc)
            
        }
        return arr
    }
    
    func getAllExpense() -> [Expense] {
        
        let obj = realm.objects(Expense.self)
        
        var arr: [Expense] = []
        obj.forEach { acc in
            arr.append(acc)
            
        }
        return arr
    }
    
    func getAllTransfer() -> [Transfer] {
        
        let obj = realm.objects(Transfer.self)
        
        var arr: [Transfer] = []
        obj.forEach { acc in
            arr.append(acc)
            
        }
        return arr
    }
    
    
}
