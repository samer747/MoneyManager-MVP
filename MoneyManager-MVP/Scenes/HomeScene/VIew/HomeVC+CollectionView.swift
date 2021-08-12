//
//  HomeVC+CollectionView.swift
//  MoneyManager-MVP
//
//  Created by samer on 13/07/2021.
//

import UIKit


extension HomeVC: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    
    
    
    
    
    func setupCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(HomeMainOuterCell.self, forCellWithReuseIdentifier: HomeMainOuterCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        configureCVUI()

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    fileprivate func configureCVUI() {
        //init collectionView
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        collectionView.backgroundColor = SMSColors.backGround
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainOuterCell.reuseID, for: indexPath) as! HomeMainOuterCell
        cell.homePresenter = presenter
        presenter?.configueOutterCell(cell: cell, index: indexPath.row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: presenter?.calculateDaynamicCell(index: indexPath.item) ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return presenter?.getArrCount() ?? 0
    }
    
}
