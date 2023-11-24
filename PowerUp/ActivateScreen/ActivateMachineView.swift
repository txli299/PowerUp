//
//  ActivateMachineView.swift
//  PowerUp
//
//  Created by Cliff Li on 11/23/23.
//

import UIKit

class ActivateMachineView: UIView {
    var midTextField: UITextField!
        
    //button: add
    var activateButton: UIButton!
    var typeLabel: UILabel!
    var rateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupmidTextField()
        setupActivateButton()
        setupLabels()
        initContraints()
    }
    
    func setupmidTextField(){
        midTextField = UITextField()
        midTextField.placeholder = "machine id"
        midTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(midTextField)
    }
    
    func setupLabels(){
        typeLabel = UILabel()
        rateLabel = UILabel()
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        rateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(typeLabel)
        self.addSubview(rateLabel)
    }
    
    func setupActivateButton(){
        activateButton = UIButton(type: .system)
        activateButton.setTitle("Activate", for: .normal)
        activateButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        activateButton.backgroundColor = UIColor(red: 0.45, green: 0.72, blue: 1, alpha: 1.0)
        activateButton.setTitleColor(UIColor.white, for: .normal)
        activateButton.layer.cornerRadius = 12
        activateButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activateButton)
    }
    
    func initContraints(){
        //MARK: constraints...
        NSLayoutConstraint.activate([
            midTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            midTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            typeLabel.topAnchor.constraint(equalTo: midTextField.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            rateLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            rateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            activateButton.topAnchor.constraint(equalTo: rateLabel.bottomAnchor, constant: 20),
            activateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 160),
            activateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
