//
//  HomeVCRouter.swift
//  MoneyManager-MVP
//
//  Created by samer on 13/07/2021.
//

import UIKit

class HomeVCRouter {
    
    
    class func createHomeVC() -> UIViewController {
        let homeVC = HomeVC()
        if let view = homeVC as? HomeVCView {
            let router = HomeVCRouter()
            let interactor = HomeVCInteractor()
            let presenter = HomeVCPresenter(view: view, router: router, interactor: interactor)
            view.presenter = presenter
        }
        return homeVC
    }
    
    
    
    func presentAddTransactionVC(from view: HomeVCView) {
        
        if let addtransactionVC = view as? HomeVC {
            
            if let aaddtransactionVC = AddTransactionRouter.CreateAddTransactionVC(homeP: view.presenter!) as? AddTransactionVC {
                aaddtransactionVC.delegate = addtransactionVC
                addtransactionVC.present(aaddtransactionVC, animated: true)
            }
        }
    }
    
    func presentEditeTransactionVC(from view: HomeVCView, uuid: String, flag: Int) {
        
        if let addtransactionVC = view as? HomeVC {
            
            let aaddtransactionVC = AddTransactionRouter.CreateAddTransactionVC(homeP: view.presenter!, uuid: uuid, flag: flag)
            addtransactionVC.present(aaddtransactionVC, animated: true)
        }
    }
    
    func reloadData(view: HomeVCView) {
        
        if let addtransactionVC = view as? HomeVC {
            addtransactionVC.collectionView.reloadData()
        }
    }
    
    
    func presentAddAccountVC(from view: HomeVCView) {
        
        if let homeVC = view as? HomeVC {
            
            let aaddtransactionVC = AddAccountRouter.createAddAccount()
            homeVC.present(aaddtransactionVC, animated: true)
        }
    }
    
}
