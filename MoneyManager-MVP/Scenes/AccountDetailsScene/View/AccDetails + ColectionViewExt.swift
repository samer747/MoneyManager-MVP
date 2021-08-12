//
//  AccDetails + ColectionViewExt.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import UIKit

extension AccountDetailsCVC:  UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    func setupCollectionView() {
        
        collectionView.register(HomeMainOuterCell.self, forCellWithReuseIdentifier: HomeMainOuterCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainOuterCell.reuseID, for: indexPath) as! HomeMainOuterCell
//        cell.homePresenter = presenter
        presenter?.configueOutterCell(cell: cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: presenter?.calculateDaynamicCell(index: indexPath.item) ?? 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return presenter?.getArrCount() ?? 0
    }
    
}
