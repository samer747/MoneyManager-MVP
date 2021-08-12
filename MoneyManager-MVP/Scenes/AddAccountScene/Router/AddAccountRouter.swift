//
//  AddAccountRouter.swift
//  MoneyManager-MVP
//
//  Created by samer on 07/08/2021.
//

import UIKit





class AddAccountRouter {
    
    
    
    class func createAddAccount() -> UIViewController {
        
        let addAccVC = AddAccountVC()
        
        if let view = addAccVC as? AddAccountView {
            let interactor = AddAccountInteractor()
            let router = AddAccountRouter()
            let presenter = AddAccountPresenter(view: view, router: router, interactor: interactor)
            addAccVC.presenter = presenter
        }
        
        return addAccVC
    }
}
