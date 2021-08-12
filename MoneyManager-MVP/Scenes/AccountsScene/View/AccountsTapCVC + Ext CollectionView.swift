//
//  AccountsTapCVC + Ext CollectionView.swift
//  MoneyManager-MVP
//
//  Created by samer on 02/08/2021.
//

import UIKit



extension AccountsTapCVC  :  UICollectionViewDelegateFlowLayout{
    


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (presenter?.getAccountsCount() ?? 0) + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountsTapCell.reuseID, for: indexPath) as! AccountsTapCell
    
        
        
        if indexPath.item == (presenter?.getAccountsCount() ?? 0) {
            presenter?.funcConfigueCellToLastCell(cell: cell)
        }else{
        presenter?.funcConfigueCell(cell: cell, index: indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width / 3) - 20
        

        
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == (presenter?.getAccountsCount() ?? 0) {
            presenter?.presentAddAccountVC()
        }else{
            presenter?.presentAccDetails(indexPath: indexPath.item)
        }
    }
}

