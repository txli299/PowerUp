//
//  PaymentViewController.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 11/13/23.
//

import UIKit

class PaymentViewController: UIViewController {
    
    let paymentView = PaymentView()
    
    let notificationCenter = NotificationCenter.default
    
    var delegate: CheckOutViewController!
    
    override func loadView() {
        view = paymentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paymentView.stripePayButton.addTarget(self, action: #selector(addFunds), for: .touchUpInside)
    }
    
    func updateAddAmount(){
        paymentView.stripePayButton.setTitle("Add $\(delegate.selectedAmount)", for: .normal)
    }
    
    @objc func addFunds(){
        //validate payment was successful
        // if successful, update backend user.credit with posted amount: endpoint to ping backend and pass in data
        // otherwise throw error
        //post amount notification to main
        //        notificationCenter.post(name: .nameSelected, object: namesForTableView[indexPath.row])
        
        onButtonSendBack()
        //close modal
        delegate.dismiss(animated: true)
    }
    
    func onButtonSendBack(){
        //MARK: posting text to NotificationCenter...
        notificationCenter.post(
            name: Notification.Name("selectedAmount"),
            object: "\(delegate.selectedAmount).00")
    }
}
            
