//
//  TimeScreen.swift
//  PowerUp
//
//  Created by Cliff Li on 10/2/23.
//

import UIKit

class TimeScreen: UIView {

    var containerTop: UIView!
    var myTimeLabel: UILabel!
    var infoContainer: UIView!
    var bestCafeLabel: UILabel!
    var mainStreetLabel: UILabel!
    var addButton = UIButton()
    var pcLabel: UILabel!
    var additionalInfoContainer: UIView!
    var timeLeftLabel: UILabel!
    
    let customButtonColor = UIColor(red: 0.45, green: 0.72, blue: 1, alpha: 1.0)
    let customStartBgk = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpTopContainer()
        setMyTime()
        setUpInfoContainer()
        setUpLabels()
        setPCLabel()
        setUpAdditionalInfoContainer()
        setTimeLeftLabel()
        setButton()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setButton(){
        addButton = UIButton()
        addButton.setTitle("+ Add Time", for: .normal)
        addButton.backgroundColor = customButtonColor
        addButton.layer.cornerRadius = 20
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitleColor(UIColor.white, for: .normal)
        additionalInfoContainer.addSubview(addButton)
        
    }
    
    func setTimeLeftLabel(){
        
        timeLeftLabel = UILabel()
        timeLeftLabel.text = "Time Left:"
        timeLeftLabel.font = UIFont.systemFont(ofSize: 18)
        timeLeftLabel.textColor = .black
        timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(timeLeftLabel)
    }
    func setUpAdditionalInfoContainer() {
        additionalInfoContainer = UIView()
        additionalInfoContainer.backgroundColor = UIColor.white
        additionalInfoContainer.layer.cornerRadius = 10
        additionalInfoContainer.layer.shadowColor = UIColor.black.cgColor
        additionalInfoContainer.layer.shadowOpacity = 0.5
        additionalInfoContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
        additionalInfoContainer.layer.shadowRadius = 4
        additionalInfoContainer.translatesAutoresizingMaskIntoConstraints = false
        
        containerTop.addSubview(additionalInfoContainer)
    }
    func setUpInfoContainer(){
        infoContainer = UIView()
        infoContainer.backgroundColor = customButtonColor  // Change color if needed
        infoContainer.layer.cornerRadius = 10 // Adjust the corner radius as needed
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        containerTop.addSubview(infoContainer)
    }
    
    func setUpLabels(){
        bestCafeLabel = UILabel()
        bestCafeLabel.text = "Best Cafe"
        bestCafeLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        bestCafeLabel.textColor = .black
        bestCafeLabel.translatesAutoresizingMaskIntoConstraints = false
        infoContainer.addSubview(bestCafeLabel)
        
        mainStreetLabel = UILabel()
        mainStreetLabel.text = "Main Street"
        mainStreetLabel.font = UIFont.systemFont(ofSize: 16)
        mainStreetLabel.textColor = .black
        mainStreetLabel.translatesAutoresizingMaskIntoConstraints = false
        infoContainer.addSubview(mainStreetLabel)
        
//        pcLabel = UILabel()
//        pcLabel.text = "PC 1"
//        pcLabel.font = UIFont.systemFont(ofSize: 12)
//        pcLabel.textColor = .black
//        pcLabel.translatesAutoresizingMaskIntoConstraints = false
//        additionalInfoContainer.addSubview(pcLabel)
    }
    
    func setUpTopContainer(){
        
        containerTop = UIView()
        containerTop.backgroundColor = customStartBgk
        containerTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerTop)
    }
    
    func setMyTime(){
        myTimeLabel = UILabel()
        myTimeLabel.text = "My Time"
        myTimeLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold) // Customize font and size if needed
        myTimeLabel.textColor = .white
        myTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(myTimeLabel)
        
    }
    
    func setPCLabel(){
        
        pcLabel = UILabel()
        pcLabel.text = "PC 1"
        pcLabel.font = UIFont.systemFont(ofSize: 18)
        pcLabel.textColor = .black
        pcLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pcLabel)
        
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            containerTop.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerTop.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerTop.topAnchor.constraint(equalTo: self.topAnchor),
            containerTop.heightAnchor.constraint(equalToConstant: 200),
            
            myTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16), // Adjust the constant as needed
            myTimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant:70), // Adjust the constant as needed
            
            //all together
            infoContainer.heightAnchor.constraint(equalToConstant: 65), // Set the desired height
            infoContainer.topAnchor.constraint(equalTo: myTimeLabel.bottomAnchor, constant: 16),
            infoContainer.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            bestCafeLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 8),
            bestCafeLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 8),
            
            mainStreetLabel.leadingAnchor.constraint(equalTo: infoContainer.leadingAnchor, constant: 8),
            mainStreetLabel.topAnchor.constraint(equalTo: bestCafeLabel.bottomAnchor, constant: 4),
            //all together
            additionalInfoContainer.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            additionalInfoContainer.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            additionalInfoContainer.heightAnchor.constraint(equalToConstant: 175), // Set the desired height
            additionalInfoContainer.topAnchor.constraint(equalTo: containerTop.bottomAnchor, constant: -10),
            
            pcLabel.leadingAnchor.constraint(equalTo: additionalInfoContainer.leadingAnchor, constant: 8),
            pcLabel.topAnchor.constraint(equalTo: additionalInfoContainer.topAnchor, constant: 8),
            
            timeLeftLabel.leadingAnchor.constraint(equalTo: pcLabel.leadingAnchor),
            timeLeftLabel.topAnchor.constraint(equalTo: pcLabel.bottomAnchor, constant: 12),
            
            addButton.centerXAnchor.constraint(equalTo: additionalInfoContainer.centerXAnchor),
//            addButton.centerYAnchor.constraint(equalTo: additionalInfoContainer.centerYAnchor),
            addButton.bottomAnchor.constraint(equalTo: additionalInfoContainer.bottomAnchor, constant: -20), // Adjust the constant to position the button higher or lower
            addButton.widthAnchor.constraint(equalToConstant: 160),
            addButton.heightAnchor.constraint(equalToConstant: 40),


        ])
        
    }
}
