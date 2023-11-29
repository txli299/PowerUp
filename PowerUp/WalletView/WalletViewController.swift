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
    
    let uid = KeychainService.loadToken()
    
    let notificationCenter = NotificationCenter.default
    
    let checkoutController = CheckOutViewController()
    var checkoutNavController: UINavigationController!

    override func loadView() {
        view = walletView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCurrentBalance()
        
        walletView.addFundsButton.addTarget(self, action: #selector(onCheckOutButtonTapped), for: .touchUpInside)
        
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
                
                let userDetailsDictionary: [String: Any] = ["credit": doubleValue]
                addBalance(userDetails: userDetailsDictionary)
            } else {
                print("Failed to convert to Double")
            }
            
        }
               
    }
    
    func addBalance(userDetails: [String : Any]){
        
        UserService.updateUserDetails(uid: uid!, userDetails: userDetails){ success, error in
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
        
        UserService.getUserDetails(uid: uid! ){userData, error in
            
            if let error = error{
                print(error)
            } else if let userData = userData{
                let balance = "\(userData.credit)0"
                print("This is user credit \(userData.credit)")
                
                //refresh UI
                DispatchQueue.main.async {
                    self.walletView.balanceLabel.text = "$\(balance)"
                }
            }
        }
    }
    
    func setupCheckoutBottomSheet(){
        checkoutNavController = UINavigationController(rootViewController: checkoutController)
        checkoutNavController.modalPresentationStyle = .pageSheet
                
        if let bottomCheckoutSheet = checkoutNavController.sheetPresentationController{
            bottomCheckoutSheet.detents = [.medium(), .large()]
            bottomCheckoutSheet.prefersGrabberVisible = true
        }
    }
    
    @objc func onCheckOutButtonTapped(){
        setupCheckoutBottomSheet()
        present(checkoutNavController, animated: true)
       }
    
}
