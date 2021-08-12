//
//  AccountsCVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 25/07/2021.
//

import UIKit


protocol AccountsCVCView {
    func didselecteAcc(accName: String)
}


protocol didSelectAddAccount {
    func dissmissAddTranAndPResentAddAcc()
    
}

class AccountsCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    var didSelectAddAccountView: didSelectAddAccount?
    let accounts = RealmManger.shared.getAllAccounts()
    let seprator = UIView()
    let nameLable: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.textColor = .white
        l.text = "Accounts"
        l.backgroundColor = UIColor(white: 0, alpha: 0.8)
        l.font = .systemFont(ofSize: 25, weight: .bold)
        return l
    }()
    
    var accountsCVCView : AccountsCVCView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = SMSColors.backGround
        self.collectionView!.register(AccountsCVCCell.self, forCellWithReuseIdentifier: AccountsCVCCell.reuseID)
        view.isHidden = true
        view.addSubview(nameLable)
        nameLable.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 51))
        
        seprator.backgroundColor = .white
        view.addSubview(seprator)
        seprator.anchorBySize(top: nil, leading: nameLable.leadingAnchor, bottom: nameLable.bottomAnchor, trailing: nameLable.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 1, right: 0), size: .init(width: 0, height: 1))
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return accounts.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountsCVCCell.reuseID, for: indexPath) as! AccountsCVCCell
    
        
        if indexPath.item  == accounts.count {
            cell.nameLable.text = "+"
        }else {
            cell.nameLable.text = accounts[indexPath.item].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width  / 3 , height: 55)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 50, left: -1, bottom: 1, right: 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item  == accounts.count {
            didSelectAddAccountView?.dissmissAddTranAndPResentAddAcc()
        }else {
            accountsCVCView?.didselecteAcc(accName: accounts[indexPath.item].name)
        }
    }
}


class AccountsCVCCell: UICollectionViewCell {
    
    static let reuseID = "sdaadsadsdasdas"
    
    let nameLable: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.textColor = .white
        
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.4
        layer.borderColor = UIColor(white: 0.33, alpha: 1).cgColor
        
        
        addSubview(nameLable)
        nameLable.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
