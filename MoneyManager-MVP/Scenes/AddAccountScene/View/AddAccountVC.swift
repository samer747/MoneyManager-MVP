//
//  AddAccountVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 07/08/2021.
//

import UIKit

class AddAccountVC: UIViewController {
    
    var presenter: AddAccountPresenter?
    
    let titleLable : UILabel = {
       let l = UILabel()
        l.text = "Add Account"
        l.textColor = SMSColors.yellow
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.textAlignment = .center
        return l
    }()
    
    
    
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
        t.text = "0.0"
        t.autocorrectionType = UITextAutocorrectionType.no
        t.keyboardType = .numberPad
        t.returnKeyType = UIReturnKeyType.done
        t.textAlignment = .center
        t.borderStyle = .roundedRect
        t.backgroundColor = SMSColors.cellBackgrounds
        return t
    }()

    
    let doneButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Done", for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.setTitleColor(SMSColors.yellow, for: .normal)
        b.layer.borderColor = SMSColors.yellow.cgColor
        b.backgroundColor = SMSColors.cellBackgrounds
        b.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        configue()
        configueLayout()
    }


    private func configueLayout(){
        let stack = SMSStackView(arrangedSubs: [titleLable,nameTF,amountTF,doneButton], axe: .vertical, dist: .fillEqually, space: 15)
        view.addSubview(stack)
        stack.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 25, left: 18, bottom: 0, right: 18), size: .init(width: 0, height: 220))
    }
    
    private func configue(){
        view.backgroundColor = SMSColors.backGround
        nameTF.delegate = self
        amountTF.delegate = self
    }
    
    @objc private func donePressed(){
        
        guard let name = nameTF.text else { return }
        guard let amount = amountTF.text else { return }
        
        
        presenter?.addAcc(name: name, amount: amount)
        
    }
}
