//
//  AccountsTapPresenter.swift
//  MoneyManager-MVP
//
//  Created by samer on 31/07/2021.
//

import Foundation

protocol AccountsTapView: AnyObject {
    var presenter : AccountsTapPresenter? { get set }
    
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

class AccountsTapPresenter {
    
    var interactor : AccountsTapInterActor
    var router: AccountsTapCVCRouter
    var view:  AccountsTapView
    
    
    var accounts = [Account]()
    
    func getData(){
        
        accounts = interactor.getAccounts()
        view.fetchDataSuccess()
    }
    
    init(interactor: AccountsTapInterActor, router: AccountsTapCVCRouter,view:  AccountsTapView) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
    
    func viewDidLoad(){
        getData()
    }
    
    func getAccountsCount() -> Int {
        return accounts.count
    }
    
    func funcConfigueCell(cell: AccountsTapCell, index: Int) {
        cell.setAmount(amount: accounts[index].amount)
        cell.setAccName(name: accounts[index].name)
    }
    
    func funcConfigueCellToLastCell(cell: AccountsTapCell) {
        cell.setAddCell()
    }
    
    
    func presentAddAccountVC() {
        router.presentAddAcc(from: view)
    }
    
    func presentAccDetails(indexPath: Int) {
        router.presentAccDetails(from: view , accName: accounts[indexPath].name)
    }
    
}
