//
//  AddAccountPresenter.swift
//  MoneyManager-MVP
//
//  Created by samer on 07/08/2021.
//

import Foundation

protocol AddAccountView : AnyObject{
    var presenter : AddAccountPresenter? { get set }
    func addAccSuccess()
    func error(error: String)
}

class AddAccountPresenter {
    
    private var view: AddAccountView?
    private var router: AddAccountRouter
    private var interactor: AddAccountInteractor
    
    init(view: AddAccountView, router: AddAccountRouter, interactor: AddAccountInteractor) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    
    func addAcc(name: String, amount: String) {
        
        
        if name.count != 0 && amount.count != 0 {
            
            if let _ = RealmManger.shared.getAccByName(name: name) {
                
                view?.error(error: "There is account has the same name!")
                
            }
            else{
                guard let floatAmount = Float(amount) else { return }
                interactor.addAccount(name: name, amount: floatAmount)
                view?.addAccSuccess()
            }
        }else{
            view?.error(error: "Add Name and amount please")
        }
    }
}
