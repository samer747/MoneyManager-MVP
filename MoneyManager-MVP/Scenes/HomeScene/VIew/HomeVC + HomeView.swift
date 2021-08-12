//
//  HomeVC + HomeView.swift
//  MoneyManager-MVP
//
//  Created by samer on 16/07/2021.
//

import Foundation



extension HomeVC: HomeVCView{

    func showIndicator() {
        DispatchQueue.main.async { self.view.showActivityIndicator(loadingView: self.indecatorView) }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async { self.view.hideActivityIndicator(loadingView: self.indecatorView) }
    }
    
    func fetchDataSuccess() {
        collectionView.reloadData()
    }
    
    func showError(error: String) {
        presentError(.unableToComplete, message: error, buttonText: "Ok")
    }
    
    
}


extension HomeVC: AddTransactionDelegate{
    func dissmissAddTran() {
        presenter?.presentAddAccVC()
    }
    
    
    
}
