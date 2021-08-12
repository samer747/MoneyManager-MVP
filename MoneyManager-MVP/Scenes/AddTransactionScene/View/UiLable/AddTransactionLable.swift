//
//  AddTransactionLable.swift
//  MoneyManager-MVP
//
//  Created by samer on 19/07/2021.
//

import UIKit

class AddTransactionLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    convenience init(textt: String) {
        self.init(frame: .zero)
        
        text = textt
        font = .systemFont(ofSize: 16, weight: .regular)
        textColor = UIColor(white: 0.92, alpha: 0.8)
        textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
