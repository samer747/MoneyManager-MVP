//
//  MainTabBarController.swift
//  MoneyManager-MVP
//
//  Created by samer on 13/07/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    

    
    private func setupViews(){
        
        tabBar.barTintColor = .black
        
        let home = HomeVCRouter.createHomeVC()
        let accounts = AccountsTapCVCRouter.createAccountsTapCVC()
        
        
        home.setupTabBarAtt(imageSysName: "homekit", selectedTintColor: SMSColors.yellow, titleX: Utility.timeFormater(stringDate: nil, onlyDate: nil, dateFormatt: .dayMonth))
        accounts.setupTabBarAtt(imageSysName: "creditcard.fill", selectedTintColor: SMSColors.yellow, titleX: "Accounts")
        
        viewControllers = [home,accounts,UIViewController(),UIViewController()]
        
        
        
    }


    
    
}
