//
//  AccDetails + AccDetailsView.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import Foundation


extension AccountDetailsCVC : AccDetailsView {
    func showIndicator() {
        view.showActivityIndicator(loadingView: indecatorView)
    }
    
    func hideIndicator() {
        view.hideActivityIndicator(loadingView: indecatorView)
    }
    
    func fetchDataSuccess() {
        collectionView.reloadData()
    }
    
    func showError(error: String) {
        presentError(.unableToComplete, message: "Please Try again", buttonText: "Done")
    }
    
    
    
}
