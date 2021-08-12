//
//  HomeVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 13/07/2021.
//

import UIKit
import RealmSwift

class HomeVC: UIViewController {

    var collectionView: UICollectionView!
    
    var presenter: HomeVCPresenter?
    let indecatorView = UIView()
    
    let addButton : UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = SMSColors.yellow
        b.setImage(UIImage(named: "plusIcon"), for: .normal)
        b.layer.cornerRadius = 25
        b.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return b
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confige()
        setupCollectionView()
        configeLayout()
        ifFirstOpen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoad()
    }
    
    fileprivate func ifFirstOpen() {
        Persitence.retriveIfFirstOpen { res in
            switch res {
            
            case .success(let x):
                if x == 0 {
                    
                    // its first open
                    self.configeDataLocaly()
                    let _ = Persitence.saveFirstOpen(int: 1)
                }else{
                    print("Its Not First Open")
                }
            case .failure(let err):
                self.presentError(err, message: "there is a error", buttonText: "Ok")
            }
        }
    }
    
    private func configeDataLocaly(){
        
        RealmManger.shared.addCategory(name: "Home", categoryType: .expense)
        RealmManger.shared.addCategory(name: "Self-Devlopment", categoryType: .expense)
        RealmManger.shared.addCategory(name: "Gifts", categoryType: .expense)
        RealmManger.shared.addCategory(name: "Other", categoryType: .expense)
        
        RealmManger.shared.addCategory(name: "Salary", categoryType: .income)
        RealmManger.shared.addCategory(name: "Bounce", categoryType: .income)
        RealmManger.shared.addCategory(name: "Commerce", categoryType: .income)
        RealmManger.shared.addCategory(name: "Parents", categoryType: .income)
        
        RealmManger.shared.addAccount(name: "Wallet", groupName: "Cash", amount: 0.0)
        RealmManger.shared.addAccount(name: "PayPal", groupName: "Accounts", amount: 0.0)
        RealmManger.shared.addAccount(name: "BankAccount", groupName: "Accounts", amount: 0.0)
        RealmManger.shared.addAccount(name: "Keep Money", groupName: "Cash", amount: 0.0)
    }
    
    private func confige(){
        
        view.backgroundColor = SMSColors.backGround
    }
    
    private func configeLayout() {
        
        view.addSubview(addButton)
        addButton.anchorBySize(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 40, right: 30), size: .init(width: 50, height: 50))
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @objc private func addButtonTapped(){
        presenter?.presentAddTransactionVC()
    }
      
}



