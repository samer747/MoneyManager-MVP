//
//  AddAccVC+TextFExt.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import UIKit


extension AddAccountVC: UITextFieldDelegate {

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTF  {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else if textField == nameTF{
            
            let currentText = textField.text ?? ""
            
            guard let stringRange = Range(range, in: currentText) else { return false }

            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            return updatedText.count <= 40
        }else{
            return true
        }
        
    }

}


