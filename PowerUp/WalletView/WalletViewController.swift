//
//  WalletViewController.swift
//  PowerUp
//
//  Created by Hank Gu on 10/1/23.
//


import UIKit

class WalletViewController: UIViewController {
    
    private let walletView = WalletView()

    override func loadView() {
        view = walletView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        walletView.addFundsButton.addTarget(self, action: #selector(addFundsTapped), for: .touchUpInside)
    }
    
    @objc func addFundsTapped() {
        print("Add Funds Button: I was clicked!")
        // Redirect to Stripe's page to add funds
    }
}
