//
//  AddTransactionTextField.swift
//  MoneyManager-MVP
//
//  Created by samer on 19/07/2021.
//

import UIKit

class AddTransactionTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    convenience init(textt: String?, type: UIKeyboardType) {
        self.init(frame: .zero)
        
        backgroundColor = SMSColors.backGround
        text = textt
        font = UIFont.systemFont(ofSize: 15)
        autocorrectionType = UITextAutocorrectionType.no
        keyboardType = type
        returnKeyType = UIReturnKeyType.next
        contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textColor = .white
        layer.borderWidth = 0.3
        layer.cornerRadius = 5
        layer.borderColor = .init(gray: 0.5, alpha: 0.8)
        layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
