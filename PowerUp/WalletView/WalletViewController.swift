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
    
    var paymentIntentClientSecret: String?

    override func loadView() {
        view = walletView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        walletView.addFundsButton.addTarget(self, action: #selector(addFundsTapped), for: .touchUpInside)
        walletView.stripePayButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        startCheckout()
    }
    
    // shows stripe card component
    @objc func addFundsTapped() {
        walletView.stripeStackView.isHidden = false
    }
    
    func displayAlert(title: String){
        
    }
    
    @objc func pay() {
        print("Stripe Button: I was clicked!")
        
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
                    return
                }
                 //Collect card details
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
                paymentIntentParams.paymentMethodParams = walletView.stripeCardTextField.paymentMethodParams
//                print(walletView.stripeCardTextField.paymentMethodParams.card)

                // Submit the payment
                let paymentHandler = STPPaymentHandler.shared()
                paymentHandler.confirmPayment(paymentIntentParams, with: self) { (status, paymentIntent, error) in
                    switch (status) {
                    case .failed:
                        self.displayAlert(title: "Payment failed")
                        break
                    case .canceled:
                        self.displayAlert(title: "Payment canceled")
                        break
                    case .succeeded:
                        self.displayAlert(title: "Payment succeeded")
                        break
                    @unknown default:
                        fatalError()
                        break
                    }
                }
        }
    
    func startCheckout() {
          // Request a PaymentIntent from your server and store its client secret
          // Click View full sample to see a complete implementation
      }
    
}

extension WalletViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}
