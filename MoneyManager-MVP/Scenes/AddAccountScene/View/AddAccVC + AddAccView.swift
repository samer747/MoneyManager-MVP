//
//  AddAccVC + AddAccView.swift
//  MoneyManager-MVP
//
//  Created by samer on 07/08/2021.
//

import Foundation


extension AddAccountVC: AddAccountView {
    func addAccSuccess() {
        dismiss(animated: true)
    }
    
    func error(error: String) {
        presentError(.invalidData, message: error, buttonText: "Ok")
    }
    
    
    
}
