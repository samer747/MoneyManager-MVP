//
//  HomeDayCell.swift
//  MoneyManager-MVP
//
//  Created by samer on 28/07/2021.
//

import UIKit

class HomeMainOuterCell: UICollectionViewCell {
    
    
    static let reuseID = "FdrsollowerCell"
    let collection = HomeCellCVC(collectionViewLayout: UICollectionViewFlowLayout())
    let headerView = MainOuterCellHeade()
    var homePresenter : HomeVCPresenter?{
        didSet{
            collection.homePresenter = homePresenter
        }
    }
    var trans : DayObj?{
        didSet{
            guard let t = trans?.transactions else { return }
            collection.transactions = t
            DispatchQueue.main.async{ self.collection.collectionView.reloadData() }
            var Esum : Float = 0.0
            var Isum : Float = 0.0
            t.forEach { tran in
                
                if let x = tran as? Expense {
                    Esum += x.amount
                }else if let x = tran as? Income {
                    Isum += x.amount
                }
            }
            
            headerView.totalIncome.text =  "$\(Isum)"
            headerView.totalExpense.text = "$\(Esum)"
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configue()
    }
    
    private func configue(){
        addSubview(headerView)
        headerView.anchorBySize(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 30))
        
        addSubview(collection.view)
        collection.view.anchorBySize(top: headerView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
