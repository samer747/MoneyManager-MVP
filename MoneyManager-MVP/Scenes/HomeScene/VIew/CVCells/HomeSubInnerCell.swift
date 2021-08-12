//
//  HomeDailyCell.swift
//  MoneyManager-MVP
//
//  Created by samer on 16/07/2021.
//

import UIKit

class HomeSubInnerCell: UICollectionViewCell, HomeVCCellView {

    

    static let reuseID = "FollowerCell"
    lazy var noteAccCon = accountLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    lazy var botAccCon = accountLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
    
    
    let categoryLable: UILabel = {
       let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textAlignment = .left
        return l
    }()
    
    let accountLable: UILabel = {
       let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        l.textAlignment = .left
        return l
    }()
    
    let amountLable: UILabel = {
       let l = UILabel()
        l.textColor = .gray
        l.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        l.textAlignment = .right
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.3
        return l
    }()
    
    let noteLable: UILabel = {
       let l = UILabel()
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.alpha = 0.8
        return l
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = SMSColors.cellBackgrounds
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayouts(){
        let lableWidth = frame.width / 5
        
        addSubview(categoryLable)
        categoryLable.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 5, left: 15, bottom: 5, right: 0), size: .init(width: lableWidth, height: 0))
        
        
        addSubview(amountLable)
        amountLable.anchorBySize(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 5, right: 15), size: .init(width: lableWidth, height: 0))
        
        
        addSubview(noteLable)
        noteLable.anchorBySize(top: nil, leading: categoryLable.trailingAnchor, bottom: bottomAnchor, trailing: amountLable.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 5, right: 5), size: .zero)
        
        addSubview(accountLable)
        accountLable.anchorBySize(top: topAnchor, leading: categoryLable.trailingAnchor, bottom: nil, trailing: amountLable.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 5), size: .zero)
        noteAccCon.isActive = true
        
    }
    
    
    
    func exchangeCell(category: String, account: String, amount: String, note: String, amountLableColor: UIColor) {
        self.accountLable.text = account
        self.categoryLable.text = category
        self.amountLable.text = amount + "$"
        if note == "" {
            self.noteLable.isHidden = true
            noteAccCon.isActive = false
            botAccCon.isActive = true
        }
        else { self.noteLable.text = note }
        amountLable.textColor = amountLableColor
    }
    
    func transferCell(fromAccount: String, toAccount: String, amount: String, note: String) {
        self.categoryLable.text = "Transfer"
        self.accountLable.text = "\(fromAccount)" + " > " + "\(toAccount)"
        self.amountLable.text = amount + "$"
        print(note)
        if note == "" {
            self.noteLable.isHidden = true
            noteAccCon.isActive = false
            botAccCon.isActive = true
        }
        else {
            self.noteLable.isHidden = false
            noteAccCon.isActive = true
            botAccCon.isActive = false
            self.noteLable.text = note
            
        }
        amountLable.textColor = .gray
        
    }
}
