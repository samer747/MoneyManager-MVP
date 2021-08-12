//
//  AccDetailsRouter.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import UIKit

class AccDetailsRouter {
    
    
    class func createAccDetailsCVC(accName: String) -> UICollectionViewController {
        
        let accountDetailsCVC = AccountDetailsCVC(collectionViewLayout: UICollectionViewFlowLayout())
        if let view = accountDetailsCVC as? AccDetailsView {
            let router = AccDetailsRouter()
            let interactor = AccDetailsInteractor()
            let presenter = AccDetailsPresenter(view: view, router: router, interactor: interactor, accName: accName)
            view.presenter = presenter
        }
        return accountDetailsCVC
    }
}
