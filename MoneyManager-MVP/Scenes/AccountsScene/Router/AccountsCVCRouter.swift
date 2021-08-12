//
//  AccountsCVCRouter.swift
//  MoneyManager-MVP
//
//  Created by samer on 31/07/2021.
//

import UIKit


class AccountsTapCVCRouter {
    
    
    class func createAccountsTapCVC() -> UINavigationController {
        
        let accountsTapCVC = AccountsTapCVC(collectionViewLayout: UICollectionViewFlowLayout())
        let navAccountsTapCVC = UINavigationController(rootViewController: accountsTapCVC)
        if let view = accountsTapCVC as? AccountsTapView {
            let interactor = AccountsTapInterActor()
            let router = AccountsTapCVCRouter()
            let presenter = AccountsTapPresenter(interactor: interactor, router: router, view: view)
            view.presenter = presenter
        }
        
        return navAccountsTapCVC
        
    }
    
    
    func presentAddAcc(from view: AccountsTapView) {
        if let addAccVC = view as? AccountsTapCVC {

            
            addAccVC.present(AddAccountRouter.createAddAccount(), animated: true)
        }
    }
    
    func presentAccDetails(from view: AccountsTapView , accName: String) {
        if let addAccVC = view as? AccountsTapCVC {

            
            addAccVC.present(AccDetailsRouter.createAccDetailsCVC(accName: accName), animated: true)
        }
    }
}
