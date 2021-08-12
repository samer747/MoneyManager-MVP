//
//  CategoriesCVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 25/07/2021.
//

import UIKit

protocol CategoriesCVCView {
    func didselecteCat(catName: String)
}

class CategoriesCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
   lazy var incomeCats : [IncomeCategory] = RealmManger.shared.getAllIncomeCategories()
    lazy var expenseCats : [ExpenseCategory] = RealmManger.shared.getAllExpenseCategories()

    var viewType : CategoryType = .income
    
    let seprator = UIView()
    let nameLable: UILabel = {
       let l = UILabel()
        l.textAlignment = .center
        l.textColor = .white
        l.text = "Categories"
        l.backgroundColor = UIColor(white: 0, alpha: 0.8)
        l.font = .systemFont(ofSize: 25, weight: .bold)
        return l
    }()
    
    var categoriesCVCView : CategoriesCVCView?
    
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
        switch viewType {
        case .expense:
            return expenseCats.count + 1
        case .income:
            return incomeCats.count + 1
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountsCVCCell.reuseID, for: indexPath) as! AccountsCVCCell
    
        
        switch viewType {
        
        case .expense:
            if indexPath.item  == expenseCats.count {
                cell.nameLable.text = "+"
            }else {
                    cell.nameLable.text = expenseCats[indexPath.item].name
                
            }
        case .income:
            if indexPath.item  == incomeCats.count {
                cell.nameLable.text = "+"
            }else {
                    cell.nameLable.text = incomeCats[indexPath.item].name
                
            }
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
        
        
        switch viewType {
        case .expense:
            if indexPath.item  == expenseCats.count {
                print("go to add acc view controller")
            }else {
                categoriesCVCView?.didselecteCat(catName: expenseCats[indexPath.item].name)
            }
        case .income:
            if indexPath.item  == incomeCats.count {
                print("go to add acc view controller")
            }else {
                categoriesCVCView?.didselecteCat(catName: incomeCats[indexPath.item].name)
            }
        }
    }
}
