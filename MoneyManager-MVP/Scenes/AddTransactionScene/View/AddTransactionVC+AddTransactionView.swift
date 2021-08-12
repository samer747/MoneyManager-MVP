//
//  AddTransactionVC+AddTransactionView.swift
//  MoneyManager-MVP
//
//  Created by samer on 18/07/2021.
//

import Foundation


extension AddTransactionVC: AddTransactionView {
    
    
    
}
extension AddTransactionVC: didSelectAddAccount {
    func dissmissAddTranAndPResentAddAcc() {
        
        dismiss(animated: true) {
            self.delegate?.dissmissAddTran()
        }
    }
    
}

protocol AddTransactionDelegate {
    func dissmissAddTran()
}

extension AddTransactionVC: AccountsCVCView {
    
    
    func didselecteAcc(accName: String) {
        
        if transferChoiceButton.isSelectedd {
            if secondTF.layer.borderColor == SMSColors.yellow.cgColor {
                
                secondTF.text = accName
                accountsCVC.view.isHidden = true
                textFieldShouldBeginEditing(thirdTF)
            }else {
                thirdTF.text = accName
                accountsCVC.view.isHidden = true
                amountTF.becomeFirstResponder()            }
            
        }else{
            secondTF.text = accName
            accountsCVC.view.isHidden = true
            textFieldShouldBeginEditing(thirdTF)
        }
        
    }
}
    
    extension AddTransactionVC: CategoriesCVCView {
        func didselecteCat(catName: String) {
    
            thirdTF.text = catName
            categoriesCVC.view.isHidden = true
            amountTF.becomeFirstResponder()
            
        }
    }
