//
//  AccountsTapCell.swift
//  MoneyManager-MVP
//
//  Created by samer on 02/08/2021.
//

import UIKit

class AccountsTapCell: UICollectionViewCell {
    
    
    
    static let reuseID = "FollowerCgdssdgdfell"
    
    let amountLable: UILabel = {
       let l = UILabel()
        l.textColor = SMSColors.yellow
        l.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.3
        return l
    }()
    
    
    let accNameLable: UILabel = {
       let l = UILabel()
        l.textColor = .white
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.textAlignment = .center
        l.adjustsFontSizeToFitWidth = true
        l.lineBreakMode = .byWordWrapping
        l.minimumScaleFactor = 0.3
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = SMSColors.cellBackgrounds
        layer.borderWidth = 0.5
        layer.borderColor = SMSColors.yellow.cgColor
        layer.cornerRadius = 9
        
        
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayouts(){

        addSubview(amountLable)
        amountLable.centerInSuperview(size: .init(width: frame.width - 20, height: 0))
        addSubview(accNameLable)
        accNameLable.anchorBySize(top: amountLable.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 7, left: 5, bottom: 0, right: 5), size: .zero)
        
    }
    
    func setAmount(amount: Float) {
        amountLable.countAnimation(upto: Double(amount))
    }
    
    func setAccName(name: String) {
        accNameLable.text = name
    }
    
    func setAddCell() {
        accNameLable.text = ""
        amountLable.text = "+"
    }

}
extension UILabel {
    func countAnimation(upto: Double) {
        let from: Double = 0.0
        let steps: Int = 10
        let duration = 1.0
        let rate = duration / Double(steps)
        let diff = upto - from
        for i in 0...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + rate * Double(i)) {
                self.text = "\(Float(from + diff * (Double(i) / Double(steps))))"
            }
        }
    }
}
