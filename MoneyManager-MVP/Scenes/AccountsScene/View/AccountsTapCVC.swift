//
//  AccountsTapCVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 31/07/2021.
//

import UIKit



class AccountsTapCVC : UICollectionViewController{

    var presenter: AccountsTapPresenter? 
    let indecatorView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(AccountsTapCell.self, forCellWithReuseIdentifier: AccountsTapCell.reuseID)
        configue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoad()
    }
    
    private func configue() {
        
        collectionView.backgroundColor = SMSColors.backGround
        configureNavigationBar(largeTitleColor: SMSColors.yellow, backgoundColor: .black, tintColor: .brown, title: "Accounts", preferredLargeTitle: true)
    }




}
