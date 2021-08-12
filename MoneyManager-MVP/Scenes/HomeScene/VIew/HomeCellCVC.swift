//
//  HomeCellCVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 28/07/2021.
//

import UIKit

private let reuseIdentifier = "Cell"


class HomeCellCVC: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var homePresenter: HomeVCPresenter?
    var transactions = [Transaction]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .brown

        self.collectionView!.register(HomeSubInnerCell.self, forCellWithReuseIdentifier: HomeSubInnerCell.reuseID)

        self.collectionView.isScrollEnabled = false
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSubInnerCell.reuseID, for: indexPath) as! HomeSubInnerCell
        if let tran = transactions[indexPath.item] as? Expense {
            
            print(tran.note)
            cell.exchangeCell(category: tran.expenseCategoryName, account: tran.accountName, amount: "\(tran.amount)", note: tran.note, amountLableColor: SMSColors.red)
            
        }else if let tran = transactions[indexPath.item] as? Income {
            print(tran.note)
            cell.exchangeCell(category: tran.incomeCategoryName, account: tran.accountName, amount: "\(tran.amount)", note: tran.note, amountLableColor: SMSColors.blue)
            
        }else if let tran = transactions[indexPath.item] as? Transfer {
            print(tran.note)
            cell.transferCell(fromAccount: tran.fromAccountName, toAccount: tran.toAccountName, amount: "\(tran.amount)", note: tran.note)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if let tran = transactions[indexPath.item] as? Expense {
            
            homePresenter?.didSelectInnerCell(uuid: tran.uuidString, flag: 1)
        }else if let tran = transactions[indexPath.item] as? Income {
            
            homePresenter?.didSelectInnerCell(uuid: tran.uuidString, flag: 0)
        }else if let tran = transactions[indexPath.item] as? Transfer {
            
            homePresenter?.didSelectInnerCell(uuid: tran.uuidString, flag: 2)
        }
        
        
    }
    


}
