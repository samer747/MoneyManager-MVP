//
//  AccountDetailsCVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class AccountDetailsCVC: UICollectionViewController {
    
    var presenter: AccDetailsPresenter?
    let indecatorView = UIView()
    
    let nameTF : UITextField = {
       let t = UITextField()
        t.placeholder = "Name"
        t.autocorrectionType = UITextAutocorrectionType.no
        t.keyboardType = .default
        t.returnKeyType = UIReturnKeyType.next
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        t.backgroundColor = SMSColors.cellBackgrounds
        return t
    }()
    
    let amountTF : UITextField = {
       let t = UITextField()
        t.placeholder = "Amount"
        t.autocorrectionType = UITextAutocorrectionType.no
        t.keyboardType = .numberPad
        t.returnKeyType = UIReturnKeyType.done
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        t.backgroundColor = SMSColors.cellBackgrounds
        return t
    }()

    
    let deleteButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Delete", for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.setTitleColor(.red, for: .normal)
        b.layer.borderColor = UIColor.red.cgColor
        b.backgroundColor = SMSColors.cellBackgrounds
        b.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        return b
    }()
    
    let editeButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Edite", for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.setTitleColor(.init(white: 0.92, alpha: 0.88), for: .normal)
        b.layer.borderColor = UIColor.gray.cgColor
        b.backgroundColor = SMSColors.cellBackgrounds
        b.addTarget(self, action: #selector(editePressed), for: .touchUpInside)
        return b
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        confige()
        configeLayouts()
    }
    
    private func confige(){
        
        collectionView.backgroundColor = SMSColors.backGround
        view.backgroundColor = SMSColors.backGround
        setupCollectionView()
        presenter?.viewDidLoad()
        nameTF.text = presenter?.accName
        amountTF.text = presenter?.getAmount()
    }
    
    private func configeLayouts(){
        
        collectionView.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 210, left: 0, bottom: 0, right: 0), size: .zero)
        
        let buttonsStack = SMSStackView(arrangedSubs: [editeButton,deleteButton], axe: .horizontal, dist: .fillEqually, space: 15)
        let allStack = SMSStackView(arrangedSubs: [nameTF,amountTF,buttonsStack], axe: .vertical, dist: .fillEqually, space: 15)
        
        view.addSubview(allStack)
        allStack.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 180))
        
        view.sendSubviewToBack(allStack)
    }

    @objc private func deletePressed(){
        let actionSheet = UIAlertController(title: "Delete \(presenter?.accName) Account?", message: "you can't get it back.", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            RealmManger.shared.deleteAccount(uuidString: self.presenter?.getAccUUID() ?? "")
            self.dismiss(animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
        
    }
    
    @objc private func editePressed(){
        
        if presenter?.getAmount() != amountTF.text && presenter?.accName != nameTF.text {
            
            RealmManger.shared.editeAccount(uuidString: presenter?.getAccUUID() ?? "", newName: nameTF.text, newAmount: Float(amountTF.text ?? ""))
        } else if presenter?.accName != nameTF.text {
            
            RealmManger.shared.editeAccount(uuidString: presenter?.getAccUUID() ?? "", newName: nameTF.text, newAmount: nil)
        }else if presenter?.getAmount() != amountTF.text {
            
            RealmManger.shared.editeAccount(uuidString: presenter?.getAccUUID() ?? "", newName: nil, newAmount: Float(amountTF.text ?? ""))
        }
        
        dismiss(animated: true)
    }
}
