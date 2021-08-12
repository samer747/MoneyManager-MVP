//
//  AddTransactionRouter.swift
//  MoneyManager-MVP
//
//  Created by samer on 18/07/2021.
//

import UIKit



class AddTransactionRouter {
    
    
    class func CreateAddTransactionVC(homeP: HomeVCPresenter) -> UIViewController {
        
        let addTransactionVC = AddTransactionVC()
        addTransactionVC.homeVCPresenter = homeP
        if let view = addTransactionVC as? AddTransactionView {
            let router = AddTransactionRouter()
            let interactor = AddTransactionInteracor()
            let presenter = AddTransactionPresenter(interactor: interactor, router: router, view: view)
            view.presenter = presenter
        }
        return addTransactionVC
    }
    
    class func CreateAddTransactionVC(homeP: HomeVCPresenter , uuid: String, flag: Int) -> UIViewController {
        
        let addTransactionVC = AddTransactionVC()
        addTransactionVC.homeVCPresenter = homeP
        addTransactionVC.flag = flag
        addTransactionVC.editableTranUUID = uuid
        if let view = addTransactionVC as? AddTransactionView {
            let router = AddTransactionRouter()
            let interactor = AddTransactionInteracor()
            let presenter = AddTransactionPresenter(interactor: interactor, router: router, view: view)
            view.presenter = presenter
        }
        return addTransactionVC
    }
    
    func dismissTransactionVC ( view: AddTransactionView) {
        
        if let vieww = view as? AddTransactionVC {
            
            vieww.dismiss(animated: true)
        }
    }
}
