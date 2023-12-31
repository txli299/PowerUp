//
//  WalletView.swift
//  PowerUp
//
//  Created by Hank Gu on 10/1/23.
//

import UIKit
import StripePaymentsUI


class WalletView: UIView {
    
    // Gradient Background
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 1).cgColor, UIColor(red: 0.1, green: 0.5, blue: 0.9, alpha: 1).cgColor]

        return layer
    }()
        
    //top container
    let topContainerHeader: UIView = {
        let containerTop = UIView()
        containerTop.backgroundColor = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)
        containerTop.translatesAutoresizingMaskIntoConstraints = false
        return containerTop
    }()
    
    // Balance Card
    let balanceCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Header
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Wallet"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Balance Display
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        label.textColor = UIColor.systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Add Funds Button
    let addFundsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Funds", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.45, green: 0.72, blue: 1, alpha: 1.0)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // card text field
    lazy var stripeCardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
                return cardTextField
    }()
    
    // credit card pay button
    lazy var stripePayButton: UIButton = {
            let button = UIButton(type: .custom)
            button.layer.cornerRadius = 5
            button.backgroundColor = .systemGray
            button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
            button.setTitle("Add", for: .normal)
            return button
        }()
    
    //stack view
    lazy var stripeStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stripeCardTextField, stripePayButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    //main init function
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }

    //sets up views & contraints
    private func setupViews() {
//        gradientLayer.frame = self.bounds
//        layer.addSublayer(gradientLayer)
        
        addSubview(topContainerHeader)
        addSubview(headerLabel)
        addSubview(balanceCard)
        balanceCard.addSubview(balanceLabel)
        addSubview(addFundsButton)

        //stripe component
        addSubview(stripeStackView)
        
        NSLayoutConstraint.activate([
            
            topContainerHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topContainerHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topContainerHeader.topAnchor.constraint(equalTo: self.topAnchor),
            topContainerHeader.heightAnchor.constraint(equalToConstant: 200),
            
            headerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            balanceCard.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 40),
            balanceCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            balanceCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            balanceCard.heightAnchor.constraint(equalToConstant: 150),
            
            balanceLabel.centerXAnchor.constraint(equalTo: balanceCard.centerXAnchor),
            balanceLabel.centerYAnchor.constraint(equalTo: balanceCard.centerYAnchor),
            
            addFundsButton.topAnchor.constraint(equalTo: balanceCard.bottomAnchor, constant: 40),
            addFundsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addFundsButton.widthAnchor.constraint(equalToConstant: 160),
            addFundsButton.heightAnchor.constraint(equalToConstant: 50),
            
            stripeStackView.topAnchor.constraint(equalTo: addFundsButton.bottomAnchor, constant: 40),
            stripeStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
