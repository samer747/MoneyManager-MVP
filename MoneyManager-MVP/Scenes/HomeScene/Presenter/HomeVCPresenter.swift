//
//  HomeVCPresenter.swift
//  MoneyManager-MVP
//
//  Created by samer on 16/07/2021.
//

import UIKit

protocol HomeVCView : AnyObject{
    var presenter : HomeVCPresenter? { get set }
    
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}

protocol HomeVCCellView : AnyObject {
    func exchangeCell(category: String, account: String, amount: String, note: String, amountLableColor: UIColor)
    func transferCell( fromAccount: String,toAccount: String, amount: String, note: String)
}



class HomeVCPresenter {
    
    
    private weak var view : HomeVCView?
    private var router: HomeVCRouter
    private var interactor: HomeVCInteractor
    private var daysArr = [DayObj]()
    
    
    init(view: HomeVCView, router: HomeVCRouter, interactor: HomeVCInteractor) {
        
        self.interactor = interactor
        self.view = view
        self.router = router
    }
    
    func viewDidLoad(){
        getThisMounthTransactions()
    }
    
    
    func configueOutterCell(cell: HomeMainOuterCell, index: Int){
        
        cell.trans = self.daysArr[index]
        
        let attText = NSMutableAttributedString(string: "\(self.daysArr[index].day ?? 0)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        attText.append(NSAttributedString(string: " \(Utility.timeFormater(stringDate: nil, onlyDate: self.daysArr[index].transactions.first?.date, dateFormatt: .dayName))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]))
        
        cell.headerView.dayDate.attributedText =  attText
    }
    
    func  getThisMounthTransactions(){
        
        daysArr.removeAll()
        var err1 = [Int: [Transaction]]()
        let arr = interactor.getDailyTransactions()
        arr.forEach { transaction in
            
            let now = Utility.timeFormater(stringDate: nil, onlyDate: Date(), dateFormatt: .monthYear)
            let tranDate = Utility.timeFormater(stringDate: nil, onlyDate: transaction.date, dateFormatt: .monthYear)
            
            if tranDate == now {
                for index in 1...Int(Utility.timeFormater(stringDate: nil, onlyDate: Date(), dateFormatt: .day))! {
                    
                    if Int(Utility.timeFormater(stringDate: nil, onlyDate: transaction.date, dateFormatt: .day))! == index {
                        if err1[index] == nil {
                            err1[index] = [transaction]
                            
                        }else {
                            
                             err1[index]!.append(transaction)
                        }
                    }
                }
            }
        }
        err1.forEach { key, tran in
            
            daysArr.append(DayObj(day: key, trans: tran))
        }
        
        daysArr.sort { $0.day > $1.day }
        view?.fetchDataSuccess()
    }
    
    func getArrCount() -> Int{
        return daysArr.count
    }
    
    
    func presentAddTransactionVC(){
        guard let v = view else { return }
        router.presentAddTransactionVC(from: v)
    }
    
    func presentAddAccVC(){
        guard let v = view else { return }
        router.presentAddAccountVC(from: v)
    }
    
    
    func calculateDaynamicCell(index: Int) -> CGFloat {
        
        return CGFloat(30 + (60*daysArr[index].transactions.count))
    }
    
    func didSelectInnerCell(uuid: String, flag: Int){
        
        guard let vieww = view else { return }
        router.presentEditeTransactionVC(from: vieww, uuid: uuid, flag: flag)
    }
    
}


struct DayObj: Hashable {
    var day : Int!
    var transactions: [Transaction]!
    
    init(day: Int, trans: [Transaction]) {
        self.day = day
        self.transactions = trans
    }
}
