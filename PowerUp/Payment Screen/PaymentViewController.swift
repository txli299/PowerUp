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
    
    func displayAlert(message: String){
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func isValidZip(_ zip: String) -> Bool {
        //if zip is not exactly 5 digit long return false
        let length = zip.count
        
        if length != 5 {
            return false
        }
        
        if let num = Int(zip) {
            // if zip digits not in range 00001 - 99950 return false
            if num < 0 || num > 99950 {
                return false
            }
        } else {
            return false
        }
      
        return true
    }
    
    @objc func addFunds(){
  
        if paymentView.stripeCardTextField.isValid && isValidZip(paymentView.stripeCardTextField.postalCode!) {
            print("credit card is valid")
            onButtonSendBack()
            //close modal
            delegate.dismiss(animated: true)
        } else {
            let msg = "All fields are required and must be valid"
            displayAlert(message: msg )
        }
    
    }
    
    func onButtonSendBack(){
        //MARK: posting text to NotificationCenter...
        notificationCenter.post(
            name: Notification.Name("selectedAmount"),
            object: "\(delegate.selectedAmount).00")
    }
}
            
