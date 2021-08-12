//
//  MainOuterCellHeade.swift
//  MoneyManager-MVP
//
//  Created by samer on 29/07/2021.
//

import UIKit

class MainOuterCellHeade: UIView {
    
    
    let dayDate : UILabel = {
       let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .init(white: 0.92, alpha: 0.88)
        return l
    }()
    
    let totalExpense : UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        l.textColor = SMSColors.red
        return l
    }()
    
    let totalIncome : UILabel = {
       let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        l.textColor = SMSColors.blue
        return l
    }()
    
    let seprator: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = SMSColors.cellBackgrounds
        
        addSubview(dayDate)
        dayDate.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 10, bottom: 6, right: 0), size: .init(width: 150, height: 0))
        
        
        addSubview(seprator)
        seprator.anchorBySize(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 0.5))
        
        
        let stack = SMSStackView(arrangedSubs: [totalIncome,totalExpense], axe: .horizontal, dist: .fill, space: 25)
        addSubview(stack)
        stack.anchorBySize(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 25), size: .init(width: frame.width/2, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
