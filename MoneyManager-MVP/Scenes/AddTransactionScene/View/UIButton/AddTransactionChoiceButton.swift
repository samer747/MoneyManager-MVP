//
//  AddTransactionChoiceButton.swift
//  MoneyManager-MVP
//
//  Created by samer on 19/07/2021.
//

import UIKit

class AddTransactionChoiceButton: UIButton {
    
    
    var isSelectedd = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    
    convenience init (title: String) {
        self.init(type: .system)
        
        
        setTitle(title, for: .normal)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        setTitleColor(.gray, for: .normal)
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
