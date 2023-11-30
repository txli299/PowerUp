//
//  PaymentView.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 11/13/23.
//

import UIKit
import StripePaymentsUI

class PaymentView: UIView {

    var stripeCardTextField: STPPaymentCardTextField!
    
    var stripePayButton: UIButton!
    
    var stripeStackView : UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupStripeCardTextField()
        setupStripePayButton()
        setupStripeStack()
        
        initContraints()
        
    }
    
    func setupStripeCardTextField(){
        stripeCardTextField = STPPaymentCardTextField()
        self.addSubview(stripeCardTextField)
    }
    
    func setupStripePayButton(){
        stripePayButton = UIButton(type: .custom)
        stripePayButton.layer.cornerRadius = 5
        stripePayButton.backgroundColor = .systemGray
        stripePayButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        stripePayButton.setTitle("Add", for: .normal)
        
        self.addSubview(stripePayButton)
    }
    
    func setupStripeStack(){
        stripeStackView = UIStackView(arrangedSubviews: [stripeCardTextField, stripePayButton])
        stripeStackView.axis = .vertical
        stripeStackView.spacing = 20
        stripeStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stripeStackView)
    }
    
    func initContraints(){
        //MARK: constraints...
        NSLayoutConstraint.activate([
            stripeStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            stripeStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
