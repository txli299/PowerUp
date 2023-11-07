//
//  StartScreen.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 9/25/23.
//

import UIKit

class StartScreen: UIView {
    
    //UI Views
    var startView: UIView!
    var scanView: UIView!
    var typeNumView: UIView!
    
    //UI Labels
    var startLabel: UILabel!
    var creditLabel: UILabel!
    var creditFigureLabel: UILabel!
    
    var scanTitleLabel: UILabel!
    var scanTextLabel: UILabel!
    
    var typeTitleLabel: UILabel!
    var typeTextLabel: UILabel!
    

    //UI Buttons
    var scanButton: UIButton!
    var typeNumberButton: UIButton!
    
    //UI Button custom color
    let customButtonColor = UIColor(red: 0.45 , green: 0.72 , blue: 1, alpha: 1.0)
    
    //UI Start background custom color
    let customStartBgk = UIColor(red: 0.035 , green: 0.51 , blue: 0.89, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        setupStartComponent()
        setupScanComponent()
        setupTypeComponent()
        
        initConstraints()
        
       }
    
    func setupStartComponent(){
        
        // create box
        startView = UIView()
        startView.backgroundColor = customStartBgk
        startView.translatesAutoresizingMaskIntoConstraints = false
        
        startLabel = UILabel()
        startLabel.text = "Start from here"
        startLabel.font = UIFont.boldSystemFont(ofSize: 26)
        startLabel.textColor = UIColor.white
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // credit label
        creditLabel = UILabel()
        creditLabel.text = "Credit Available:"
        creditLabel.font = UIFont.boldSystemFont(ofSize: 22)
        creditLabel.textColor = UIColor.white
        creditLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // credit figure label
        creditFigureLabel = UILabel()
        creditFigureLabel.text = "$100.00"
        creditFigureLabel.font = UIFont.boldSystemFont(ofSize: 22)
        creditFigureLabel.textColor = UIColor.white
        creditFigureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        startView.addSubview(startLabel)
        startView.addSubview(creditLabel)
        startView.addSubview(creditFigureLabel)
        self.addSubview(startView)

    }
    
    func setupScanComponent(){
        //box 2
        scanView = UIView()
        scanView.backgroundColor = UIColor.white
        scanView.layer.cornerRadius = 10
        scanView.layer.shadowColor = UIColor.black.cgColor
        scanView.layer.shadowOpacity = 0.5
        scanView.layer.shadowOffset = CGSize(width: 2, height: 2)
        scanView.layer.shadowRadius = 4
        scanView.translatesAutoresizingMaskIntoConstraints = false
        
        // scan label
        scanTitleLabel = UILabel()
        scanTitleLabel.text = "Scan"
        scanTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        scanTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // scan text label
        scanTextLabel = UILabel()
        scanTextLabel.text = "Scan the SQCode near the device"
        scanTextLabel.translatesAutoresizingMaskIntoConstraints = false
    
        // scan button
        scanButton = UIButton(type: .system)
        scanButton.setTitle("Scan SQCode", for: .normal)
        scanButton.backgroundColor = customButtonColor
        scanButton.setTitleColor(UIColor.white, for: .normal)
        scanButton.layer.cornerRadius = 20
        scanButton.translatesAutoresizingMaskIntoConstraints = false

        scanView.addSubview(scanTitleLabel)
        scanView.addSubview(scanTextLabel)
        scanView.addSubview(scanButton)
        self.addSubview(scanView)
    }
    
    func setupTypeComponent(){
        //box 3
        typeNumView = UIView()
        typeNumView.backgroundColor = UIColor.white
        typeNumView.layer.cornerRadius = 10
        typeNumView.layer.shadowColor = UIColor.black.cgColor
        typeNumView.layer.shadowOpacity = 0.5
        typeNumView.layer.shadowOffset = CGSize(width: 2, height: 2)
        typeNumView.layer.shadowRadius = 4
        typeNumView.layer.cornerRadius = 10
        typeNumView.translatesAutoresizingMaskIntoConstraints = false
        
        // type label
        typeTitleLabel = UILabel()
        typeTitleLabel.text = "Type"
        typeTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        typeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // type text label
        typeTextLabel = UILabel()
        typeTextLabel.text = "Type the number near the machine"
        typeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //button
        typeNumberButton = UIButton(type: .system)
        typeNumberButton.setTitle("Type Number", for: .normal)
        typeNumberButton.backgroundColor = customButtonColor
        typeNumberButton.setTitleColor(UIColor.white, for: .normal)
        typeNumberButton.layer.cornerRadius = 20
        typeNumberButton.translatesAutoresizingMaskIntoConstraints = false
        
        typeNumView.addSubview(typeTitleLabel)
        typeNumView.addSubview(typeTextLabel)
        typeNumView.addSubview(typeNumberButton)
        self.addSubview(typeNumView)
    }
    
    //MARK: initializing the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            startView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor), // Leading constraint to the left edge
            startView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor), // Trailing constraint to the right edge
            startView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0), // Adjust top spacing as needed
            startView.heightAnchor.constraint(equalToConstant: 200),
            
            startLabel.topAnchor.constraint(equalTo: startView.topAnchor, constant: 70),
            startLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            creditLabel.topAnchor.constraint(equalTo: startLabel.bottomAnchor, constant: 16),
            creditLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            creditFigureLabel.topAnchor.constraint(equalTo: creditLabel.bottomAnchor, constant: 16),
            creditFigureLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            scanView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scanView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            scanView.topAnchor.constraint(equalTo: startView.bottomAnchor, constant: 16),
            scanView.heightAnchor.constraint(equalToConstant: 200),
            
            scanTitleLabel.topAnchor.constraint(equalTo: scanView.topAnchor, constant: 32),
            scanTitleLabel.leadingAnchor.constraint(equalTo: scanView.leadingAnchor, constant: 16),
            
            scanTextLabel.topAnchor.constraint(equalTo: scanTitleLabel.bottomAnchor, constant: 16),
            scanTextLabel.leadingAnchor.constraint(equalTo: scanView.leadingAnchor, constant: 16),
            
            scanButton.topAnchor.constraint(equalTo: scanTextLabel.bottomAnchor, constant: 16),
            scanButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: 160),
            scanButton.heightAnchor.constraint(equalToConstant: 40),
            
            typeNumView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16), // Leading constraint to the left edge
            typeNumView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16), // Trailing constraint to the right edge
            typeNumView.topAnchor.constraint(equalTo: scanView.bottomAnchor, constant: 16), // Adjust top spacing as needed
            typeNumView.heightAnchor.constraint(equalToConstant: 200),
            
            typeTitleLabel.topAnchor.constraint(equalTo: typeNumView.topAnchor, constant: 32),
            typeTitleLabel.leadingAnchor.constraint(equalTo: typeNumView.leadingAnchor, constant: 16),
            
            typeTextLabel.topAnchor.constraint(equalTo: typeTitleLabel.bottomAnchor, constant: 16),
            typeTextLabel.leadingAnchor.constraint(equalTo: typeNumView.leadingAnchor, constant: 16),
            
            typeNumberButton.topAnchor.constraint(equalTo: typeTextLabel.bottomAnchor, constant: 32),
            typeNumberButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            typeNumberButton.widthAnchor.constraint(equalToConstant: 160),
            typeNumberButton.heightAnchor.constraint(equalToConstant: 40),
            
          ])
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
