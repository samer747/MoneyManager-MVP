//
//  Constants.swift
//  Stars Face
//
//  Created by samer on 9/29/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

enum SMSColors {
    
    static let backGround       = UIColor(red: 33/255, green: 35/255, blue: 38/255, alpha: 1)
    static let yellow           = UIColor(red: 243/255, green: 198/255, blue: 35/255, alpha: 1)
    static let red              = UIColor(red: 201/255, green: 88/255, blue: 78/255, alpha: 1)
    static let blue             = UIColor(red: 63/255, green: 107/255, blue: 169/255, alpha: 1)
    static let cellBackgrounds  = UIColor(red: 39/255, green: 41/255, blue: 46/255, alpha: 1)
    
    
}


enum SMSImages {

}


enum SMSFonts {
    static let ArialRoundedMTBold       = UIFont(name:  "Arial Rounded MT Bold", size: 20)
    static let ArialRoundedMTBold25     = UIFont(name:  "Arial Rounded MT Bold", size: 25)
    static let Kohinoor                 = UIFont(name: "Kohinoor Bangla", size: 25)
}

enum UIHelper { //el enum mn2dr4 n3ml mno object el struct momken
    
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {

        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset         = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0) //el insits bta3t el cells kolha msh kol cel lwa7daha
        flowLayout.itemSize             = .init(width: view.bounds.width, height: 60) //size for Cell
        
        return flowLayout
    }
}



struct Utility {
    
    static func timeFormater (stringDate: String?,onlyDate: Date?,dateFormatt : dateFormat) -> String{
        
        
        var date = Date()
        
        if stringDate != nil {
            let unixTimestamp = Double(stringDate!)
            date = Date(timeIntervalSince1970: unixTimestamp!)
        }
        
        if onlyDate != nil {
            date = onlyDate!
        }
        
        
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = dateFormatt.rawValue
        let myStringafd = formatter.string(from: date)
        
        return myStringafd
    }
    
}


enum dateFormat : String{
    case dayMonth = "dd/MM"
    case yearMonthDay = "yyyy-MM-dd"
    case dayMonthYear = "dd/MM/yyyy"
    case monthYear = "MM/yyyy"
    case year = "yyyy"
    case day = "dd"
    case month = "MM"
    case dayName = "EEEE"
}



class SMSStackView: UIStackView {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(arrangedSubs:[UIView], axe: NSLayoutConstraint.Axis, dist: UIStackView.Distribution, space: CGFloat ) {
        self.init(frame: .zero)
        
        arrangedSubs.forEach { v in
            addArrangedSubview(v)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        axis = axe
        distribution = dist
        spacing = space
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
