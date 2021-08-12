//
//  AddTransactionVC.swift
//  MoneyManager-MVP
//
//  Created by samer on 18/07/2021.
//

import UIKit

class AddTransactionVC: UIViewController {
    
    var presenter: AddTransactionPresenter?
    var flag : Int?{
        didSet{
            switch flag {
            case 2:
                transferChoiceTapped()
            case 1:
                expenseChoiceTapped()
            default:
                incomeChoiceTapped()
            }
        }
    }
    var editableTranUUID: String?{
        didSet{
            guard let uuid = editableTranUUID else { return }
            guard let f = flag else { return }
            switch f {
            case 0:
                let inc = RealmManger.shared.getIncomeByID(uuid: uuid)
                secondTF.text = inc?.accountName
                thirdTF.text = inc?.incomeCategoryName
                amountTF.text = "\(inc?.amount ?? 0.0)"
                noteTF.text = inc?.note
            case 1:
                let inc = RealmManger.shared.getExpenseByID(uuid: uuid)
                secondTF.text = inc?.accountName
                thirdTF.text = inc?.expenseCategoryName
                amountTF.text = "\(inc?.amount ?? 0.0)"
                noteTF.text = inc?.note
            default:
                let inc = RealmManger.shared.getTransferByID(uuid: uuid)
                secondTF.text = inc?.fromAccountName
                thirdTF.text = inc?.toAccountName
                feesTF.text = "\(RealmManger.shared.getFeesAmountExpenseByID(uuid: inc?.feesExpenseUUID ?? ""))"
                amountTF.text = "\(inc?.amount ?? 0.0)"
                noteTF.text = inc?.note
            }
            RealmManger.shared.getIncomeByID(uuid: uuid)
        }
    }
    
    var lablesStack         : SMSStackView!
    var textfieldsStack     : SMSStackView!
    var doneButtonsStack    : SMSStackView!
    var  choiceStack        : SMSStackView!
    var homeVCPresenter     : HomeVCPresenter!
    
    // UiButtons
    let incomeChoiceButton      = AddTransactionChoiceButton(title: "Income")
    let expenseChoiceButton     = AddTransactionChoiceButton(title: "Expense")
    let transferChoiceButton    = AddTransactionChoiceButton(title: "Transfer")
    
    // Ui Lables
    let dateLable               = AddTransactionLable(textt: "Date")
    let secondLable             = AddTransactionLable(textt: "Account")
    let thirdLable              = AddTransactionLable(textt: "Category")
    let amountLable             = AddTransactionLable(textt: "Amount")
    let feesLable               = AddTransactionLable(textt: "Fees")
    let noteLable               = AddTransactionLable(textt: "Note")
    
    // Ui TextFields
    let dateTF                  = AddTransactionTextField(textt: Utility.timeFormater(stringDate: nil, onlyDate: Date(), dateFormatt: .dayMonthYear), type: .default)
    let secondTF                = AddTransactionTextField(textt: nil, type: .default)
    let thirdTF                 = AddTransactionTextField(textt: nil, type: .default)
    let amountTF                = AddTransactionTextField(textt: nil, type: .numberPad)
    let feesTF                  = AddTransactionTextField(textt: nil, type: .numberPad)
    let noteTF                  = AddTransactionTextField(textt: nil, type: .default)
    
    
    // Views
    let accountsCVC             = AccountsCVC(collectionViewLayout: UICollectionViewFlowLayout())
    let categoriesCVC           = CategoriesCVC(collectionViewLayout: UICollectionViewFlowLayout())
    var delegate                : AddTransactionDelegate?
    
    // Done
    let saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = SMSColors.blue
        b.layer.cornerRadius = 7
        b.setAttributedTitle(NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .heavy),NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        b.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return b
    }()
    
    let deleteButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = .systemRed
        b.layer.cornerRadius = 7
        b.setAttributedTitle(NSAttributedString(string: "Delete", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .heavy),NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
        b.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return b
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configue()
        configueLayouts()
    }
    
    private func configue() {
        
        view.backgroundColor = SMSColors.backGround
        
        // UiButtons
        incomeChoiceButton.addTarget(self, action: #selector(incomeChoiceTapped), for: .touchUpInside)
        expenseChoiceButton.addTarget(self, action: #selector(expenseChoiceTapped), for: .touchUpInside)
        transferChoiceButton.addTarget(self, action: #selector(transferChoiceTapped), for: .touchUpInside)
        if flag == nil {changeButtonToSelectedState(button: incomeChoiceButton, color: SMSColors.blue)}
        secondTF.delegate   = self
        thirdTF.delegate    = self
        amountTF.delegate   = self
        noteTF.delegate     = self
        feesTF.delegate     = self
        dateTF.isEnabled    = false
        accountsCVC.accountsCVCView         = self
        categoriesCVC.categoriesCVCView     = self
        textFieldShouldBeginEditing(secondTF)
        accountsCVC.didSelectAddAccountView = self
    }
    
    
    private func configueLayouts() {
        var arr: [AddTransactionChoiceButton]
        switch flag {
        case 0:
            arr = [incomeChoiceButton]
            incomeChoiceButton.isEnabled = false
            break
        case 1:
            arr = [expenseChoiceButton]
            expenseChoiceButton.isEnabled = false
            break
        case 2:
            arr = [transferChoiceButton]
            transferChoiceButton.isEnabled = false
            break
        default:
            arr = [incomeChoiceButton,expenseChoiceButton,transferChoiceButton]
            break
        }
        
        choiceStack = SMSStackView(arrangedSubs: arr, axe: .horizontal, dist: .fillEqually, space: 10)
        view.addSubview(choiceStack)
        choiceStack.anchorBySize(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 12, bottom: 0, right: 12), size: .init(width: 0, height: 40))
        
        
        // UiLables
        lablesStack = SMSStackView(arrangedSubs: [dateLable,secondLable,thirdLable,amountLable,noteLable], axe: .vertical, dist: .fillEqually, space: 18)
        view.addSubview(lablesStack)
        lablesStack.anchorBySize(top: choiceStack.bottomAnchor, leading: choiceStack.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 5, bottom: 0, right: 0), size: .init(width: 100, height: 0))
        
        // TextFields
        textfieldsStack = SMSStackView(arrangedSubs: [dateTF,secondTF,thirdTF,amountTF,noteTF], axe: .vertical, dist: .fillEqually, space: 8)
        view.addSubview(textfieldsStack)
        textfieldsStack.anchorBySize(top: dateLable.topAnchor, leading: lablesStack.trailingAnchor, bottom: lablesStack.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 15), size: .zero)
        
        //Done
        doneButtonsStack = SMSStackView(arrangedSubs: [saveButton], axe: .horizontal, dist: .fillEqually, space: 15)
        view.addSubview(doneButtonsStack)
        doneButtonsStack.anchorBySize(top: noteTF.bottomAnchor, leading: noteLable.leadingAnchor, bottom: nil, trailing: noteTF.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 48))
        
        if flag != nil {
            saveButton.setAttributedTitle(NSAttributedString(string: "Edite", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .heavy),NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
            doneButtonsStack.addArrangedSubview(deleteButton)
        }
        
        view.addSubview(accountsCVC.view)
        accountsCVC.view.anchorBySize(top: saveButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 15, right: 0), size: .zero)
        
        
        view.addSubview(categoriesCVC.view)
        categoriesCVC.view.anchorBySize(top: saveButton.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 0, bottom: 15, right: 0), size: .zero)
    }
    
    
    
    
    // UiButtons
    @objc private func incomeChoiceTapped() {
        
        if incomeChoiceButton.isSelectedd { return }
        
        accountsCVC.view.isHidden = true
        categoriesCVC.view.isHidden = true
        changeButtonToSelectedState(button: incomeChoiceButton, color: SMSColors.blue)
        changeButtonToUnSelectedState(button: expenseChoiceButton)
        changeButtonToUnSelectedState(button: transferChoiceButton)
        saveButton.backgroundColor = SMSColors.blue
        categoriesCVC.viewType = .income
        textFieldShouldBeginEditing(secondTF)
        thirdTF.text = ""
        feesTF.text = ""
        hideFees()
        categoriesCVC.collectionView.reloadData()
    }
    @objc private func expenseChoiceTapped() {
        
        if expenseChoiceButton.isSelectedd { return }
        
        accountsCVC.view.isHidden = true
        categoriesCVC.view.isHidden = true
        changeButtonToSelectedState(button: expenseChoiceButton, color: SMSColors.red)
        changeButtonToUnSelectedState(button: incomeChoiceButton)
        changeButtonToUnSelectedState(button: transferChoiceButton)
        saveButton.backgroundColor = SMSColors.red
        textFieldShouldBeginEditing(secondTF)
        thirdTF.text = ""
        feesTF.text = ""
        hideFees()
        categoriesCVC.viewType = .expense
        categoriesCVC.collectionView.reloadData()
    }
    @objc private func transferChoiceTapped() {
        
        if transferChoiceButton.isSelectedd { return }
        
        accountsCVC.view.isHidden = true
        categoriesCVC.view.isHidden = true
        changeButtonToSelectedState(button: transferChoiceButton, color: SMSColors.yellow)
        changeButtonToUnSelectedState(button: expenseChoiceButton)
        changeButtonToUnSelectedState(button: incomeChoiceButton)
        thirdTF.text = ""
        textFieldShouldBeginEditing(secondTF)
        saveButton.backgroundColor = SMSColors.yellow
        showFees()
    }
    
    @objc private func saveTapped() {
        
        guard let secTF = secondTF.text else { return }
        guard let thirdTF = thirdTF.text else { return }
        guard let amountTF = amountTF.text else { return }
        guard let feesTF = feesTF.text else { return }
        guard let noteTF = noteTF.text else { return }
        
        if secTF != "" && thirdTF != "" && amountTF != "" {
            if incomeChoiceButton.isSelectedd {

                if flag != nil {
                    
                    guard let uuid = editableTranUUID else { return }
                    RealmManger.shared.editeIncome(uuidString: uuid, newAccountName: secTF, newIncomeCategoryName: thirdTF, newAmountt: Float(amountTF) ?? 0.0, newNote: noteTF)
                    presenter?.dismissAddTransactionView()
                    homeVCPresenter.getThisMounthTransactions()
                    
                }else{
                presenter?.saveIncome(accountName: secTF, incomeCategoryName: thirdTF, amount: amountTF, note: noteTF)
                homeVCPresenter.getThisMounthTransactions()
                }
            }else if expenseChoiceButton.isSelectedd {

                if flag != nil {
                    
                    guard let uuid = editableTranUUID else { return }
                    RealmManger.shared.editeExpense(uuidString: uuid, newAccountName: secTF, newExpenseCategoryName: thirdTF, newAmount: Float(amountTF) ?? 0.0, newNote: noteTF)
                    presenter?.dismissAddTransactionView()
                    homeVCPresenter.getThisMounthTransactions()
                }else{
                
                presenter?.saveExpence(accountName: secTF, expenseCategoryName: thirdTF, amount: amountTF, note: noteTF)
                homeVCPresenter.getThisMounthTransactions()
                }
            }else if transferChoiceButton.isSelectedd {

                if flag != nil {
                    
                    guard let uuid = editableTranUUID else { return }
                    RealmManger.shared.editeTransfer(uuidString: uuid, toAccountName: thirdTF, fromAccountName: secTF, newAmount: Float(amountTF) ?? 0.0, newNote: noteTF, fees: Float(feesTF) ?? 0.0)
                    presenter?.dismissAddTransactionView()
                    homeVCPresenter.getThisMounthTransactions()
                }else{
                
                presenter?.saveTransfer(fees: feesTF, fromAccountName: secTF, toAccountName: thirdTF, amount: amountTF, note: noteTF)
                homeVCPresenter.getThisMounthTransactions()
                }
            }
        }else {
            
            print("Not passed")
            presentError(.invalidData, message: "Enter All Required Data about the Transaction.", buttonText: "Ok")
        }
    }
    
    @objc private func deleteTapped() {
        
        guard let uuid = editableTranUUID else { return }
        
        switch flag {
        case 0:
            RealmManger.shared.deleteIncome(uuidString: uuid)
        case 1:
            RealmManger.shared.deleteExpense(uuidString: uuid)
        default:
            RealmManger.shared.deleteTransfer(uuidString: uuid)
        }
        presenter?.dismissAddTransactionView()
        homeVCPresenter.getThisMounthTransactions()
        
    }
    
    
    
    private func changeButtonToUnSelectedState(button: AddTransactionChoiceButton) {
        
        if button.isSelectedd {
            button.isSelectedd = false
            button.setTitleColor(.gray, for: .normal)
            button.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    private func changeButtonToSelectedState(button: AddTransactionChoiceButton, color: UIColor) {
        
        if button.isSelectedd != true {
            button.isSelectedd = true
            button.setTitleColor(color, for: .normal)
            button.layer.borderColor = color.cgColor
        }
    }
    
    //Lables
    private func showFees(){
        
        lablesStack.insertArrangedSubview(feesLable, at: 4)
        feesLable.isHidden = false
        
        textfieldsStack.insertArrangedSubview(feesTF, at: 4)
        feesTF.isHidden = false
        
        secondLable.text = "From"
        thirdLable.text = "To"
    }
    
    private func hideFees(){
        
        lablesStack.removeArrangedSubview(feesLable)
        feesLable.isHidden = true
        
        textfieldsStack.removeArrangedSubview(feesTF)
        feesTF.isHidden = true
        
        secondLable.text = "Account"
        thirdLable.text = "Category"
    }
    
    
}
