//
//  AccDetailsPresenter.swift
//  MoneyManager-MVP
//
//  Created by samer on 12/08/2021.
//

import UIKit




protocol AccDetailsView : AnyObject{
    var presenter : AccDetailsPresenter? { get set }
    
    func showIndicator()
    func hideIndicator()
    func fetchDataSuccess()
    func showError(error: String)
}




class AccDetailsPresenter {
    
    private weak var view : AccDetailsView?
    private var router: AccDetailsRouter
    private var interactor: AccDetailsInteractor
    private var daysArr = [DayObj]()
    var accName: String
    
    
    init(view: AccDetailsView, router: AccDetailsRouter, interactor: AccDetailsInteractor, accName: String) {
        
        self.interactor = interactor
        self.view = view
        self.router = router
        self.accName = accName
    }
    
    
    func viewDidLoad(){
        getThisMounthTransactions()
    }
    
    
    func  getThisMounthTransactions(){
        
        daysArr.removeAll()
        var err1 = [Int: [Transaction]]()
        let arr = interactor.getDailyTransactions()
        arr.forEach { transaction in
            
            
            
            
            if let X = transaction as? Expense {
                
                if X.accountName != self.accName {
                    return
                }
            }else if let X = transaction as? Income{
                
                if X.accountName != self.accName {
                    return
                }
            }else if let X = transaction as? Transfer{
                
                
                
                if X.fromAccountName != self.accName || X.toAccountName != self.accName {
                    return
                }
            }else{
                return
            }
            
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
    
    
    
    func configueOutterCell(cell: HomeMainOuterCell, index: Int){
        
        cell.trans = self.daysArr[index]
        
        let attText = NSMutableAttributedString(string: "\(self.daysArr[index].day ?? 0)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)])
        attText.append(NSAttributedString(string: " \(Utility.timeFormater(stringDate: nil, onlyDate: self.daysArr[index].transactions.first?.date, dateFormatt: .dayName))", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]))
        
        cell.headerView.dayDate.attributedText =  attText
    }
    
    func calculateDaynamicCell(index: Int) -> CGFloat {
        
        return CGFloat(30 + (60*daysArr[index].transactions.count))
    }
    
    func getArrCount() -> Int{
        return daysArr.count
    }
    
    func getAmount() -> String? {
        let x = RealmManger.shared.getAccByName(name: accName)
        
        return "\(x?.amount ?? 0.0)"
    }
    
    func getAccUUID() -> String {
        let x = RealmManger.shared.getAccByName(name: accName)
        
        return x?.uuidString ?? ""
    }
}
