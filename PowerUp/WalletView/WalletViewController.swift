//
//  WalletViewController.swift
//  PowerUp
//
//  Created by Hank Gu on 10/1/23.
//


import UIKit
import StripePaymentsUI

class WalletViewController: UIViewController {
    
    private let walletView = WalletView()
    
    let notificationCenter = NotificationCenter.default
    
    let checkoutController = CheckOutViewController()
    var checkoutNavController: UINavigationController!

    override func loadView() {
        view = walletView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCurrentBalance()
        
        walletView.addFundsButton.addTarget(self, action: #selector(onFindButtonTapped), for: .touchUpInside)
        walletView.stripePayButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        
        observeAmountSelected()
    }
    
    //MARK: Observe if the user selected a name from bottom sheet...
    func observeAmountSelected(){
            notificationCenter.addObserver(
                self,
                selector: #selector(onAmountSelected(notification:)),
                name: Notification.Name("selectedAmount"), object: nil)
        }
    
    @objc func onAmountSelected(notification: Notification){
        if let selectedAmount = notification.object{
            
            let uwAmount =  (selectedAmount as? String)!
            
            if let doubleValue = Double(uwAmount) {
                print("Converted value to Double: \(doubleValue)")
                
                //harcoded but will be updated
                let uid = "6552a2075c0eaa381c2c8c92"
                let userDetailsDictionary: [String: Any] = ["credit": doubleValue]
                addBalance(uid: uid, userDetails: userDetailsDictionary)
            } else {
                print("Failed to convert to Double")
            }
            
        }
               
    }
    
    //use keychain to extract uid
    func addBalance(uid: String, userDetails: [String : Any]){
        
        UserCreditService.updateUserDetails(uid: uid, userDetails: userDetails){ success, error in
            DispatchQueue.main.async {
                if success {
                    print("User details successfully updated in server")
                    self.loadCurrentBalance()
                } else {
                    print("Failed to update user details with error: \(error)")
                }
            }
        }
        
    }
    
    func loadCurrentBalance(){
        
        //hardcoded userid: change to current user id
        let uid = "6552a2075c0eaa381c2c8c92"
        
        UserCreditService.getUserDetails(uid: uid ){userData, error in
            
            if let error = error{
                print(error)
            } else if let userData = userData{
                let balance = userData.credit
                print("This is user credit \(userData.credit)")
                
                //refresh UI
                DispatchQueue.main.async {
                    self.walletView.balanceLabel.text = "$\(balance)"
                }
            }
        }
    }
    
    // shows stripe card component
    @objc func addFundsTapped() {
        walletView.stripeStackView.isHidden = false
    }
    
    func displayAlert(title: String){
        
    }
    
    @objc func pay() {
        print("Stripe Button: I was clicked!")
//        print(walletView.stripeCardTextField.paymentMethodParams.card)
    }

    func setupCheckoutBottomSheet(){
        checkoutNavController = UINavigationController(rootViewController: checkoutController)
        checkoutNavController.modalPresentationStyle = .pageSheet
                
        if let bottomCheckoutSheet = checkoutNavController.sheetPresentationController{
            bottomCheckoutSheet.detents = [.medium(), .large()]
            bottomCheckoutSheet.prefersGrabberVisible = true
        }
    }
    
    @objc func onFindButtonTapped(){
        setupCheckoutBottomSheet()
        present(checkoutNavController, animated: true)
       }
    
}
