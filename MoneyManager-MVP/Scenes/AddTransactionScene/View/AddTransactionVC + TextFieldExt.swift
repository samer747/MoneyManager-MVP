//
//  AddTransactionVC + TextFieldExt.swift
//  MoneyManager-MVP
//
//  Created by samer on 25/07/2021.
//

import UIKit


extension AddTransactionVC: UITextFieldDelegate {
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == thirdTF {
            if transferChoiceButton.isSelectedd {
                view.endEditing(true)
                categoriesCVC.view.isHidden = true
                accountsCVC.view.isHidden = false
                changeSelectedColorTf(textField)
                textFieldShouldEndEditing(secondTF)
            }else {
                textFieldShouldEndEditing(secondTF)
                accountsCVC.view.isHidden = true
                categoriesCVC.view.isHidden = false
                view.endEditing(true)
                changeSelectedColorTf(textField)
            }
            return false; //do not show keyboard nor cursor
        }else if textField == secondTF{
            
            view.endEditing(true)
            categoriesCVC.view.isHidden = true
            accountsCVC.view.isHidden = false
            changeSelectedColorTf(textField)
            textFieldShouldEndEditing(thirdTF)
            return false; //do not show keyboard nor cursor
        }else {
            textFieldShouldEndEditing(thirdTF)
            textFieldShouldEndEditing(secondTF)
            changeSelectedColorTf(textField)
            accountsCVC.view.isHidden = true
            categoriesCVC.view.isHidden = true
            return true
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == thirdTF {
            changeNotSelectedColorTf(textField)
            return true
        }
        else if textField == secondTF{
            changeNotSelectedColorTf(textField)
            return true
        }
        else if textField == amountTF{
            textField.text = "\(Float(textField.text ?? "0.0") ?? 0.0)"
            return true
        }
        else if textField == feesTF{
            textField.text = "\(Float(textField.text ?? "0.0") ?? 0.0)"
            return true
        }
        else {
            changeNotSelectedColorTf(textField)
            return true
        }
    }
    
    
    private func changeSelectedColorTf(_ tf : UITextField) {
        if incomeChoiceButton.isSelectedd {
            tf.layer.borderColor = SMSColors.blue.cgColor
        }else if expenseChoiceButton.isSelectedd {
            tf.layer.borderColor = SMSColors.red.cgColor
        }else {
            tf.layer.borderColor = SMSColors.yellow.cgColor
        }
    }
    
    
    private func changeNotSelectedColorTf(_ tf : UITextField) {
        tf.layer.borderColor = .init(gray: 0.5, alpha: 0.8)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTF || textField == feesTF {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }else if textField == noteTF{
            
            // get the current text, or use an empty string if that failed
            let currentText = textField.text ?? ""

            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else { return false }

            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            // make sure the result is under 16 characters
            return updatedText.count <= 40
        }else{
            return true
        }
        
    }

}


