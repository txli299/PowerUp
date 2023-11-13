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
                walletView.balanceLabel.text = selectedAmount as! String
            }
    }
    
    //get current balance by pinging backend endpoint
    func getCurrentBalance(){
        //get current balance
        //then update walletView.balanceLabel
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
