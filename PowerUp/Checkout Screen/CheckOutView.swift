//
//  CheckOutView.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 11/13/23.
//

import UIKit

class CheckOutView: UIView {

    //amount label
    var amountLabel: UILabel!
    
    //dropdown
    var pickerType: UIPickerView!
    
    //button: add
    var addButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupAmountLabel()
        setuppickerType()
        
        setupAddButton()
        
        initContraints()
    }
    
    func setupAmountLabel(){
        amountLabel = UILabel()
        amountLabel.text = "Amount in USD:"
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(amountLabel)
    }
    
    func setuppickerType(){
          pickerType = UIPickerView()
          pickerType.translatesAutoresizingMaskIntoConstraints = false
          self.addSubview(pickerType)
      }
    
    func setupAddButton(){
        addButton = UIButton(type: .system)
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        addButton.backgroundColor = UIColor(red: 0.45, green: 0.72, blue: 1, alpha: 1.0)
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.layer.cornerRadius = 12
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addButton)
    }
    
    func initContraints(){
        //MARK: constraints...
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            amountLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            pickerType.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            pickerType.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            addButton.topAnchor.constraint(equalTo: pickerType.bottomAnchor, constant: 40),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 160),
            addButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
