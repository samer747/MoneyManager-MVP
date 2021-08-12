//
//  AccountTapCVC + AccTapView.swift
//  MoneyManager-MVP
//
//  Created by samer on 02/08/2021.
//

import Foundation


extension AccountsTapCVC : AccountsTapView {
    
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
        presentError(.unableToComplete, message: "Try Again", buttonText: "Done")
    }
    
    
}

