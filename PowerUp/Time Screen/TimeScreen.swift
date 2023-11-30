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
    var tableViewTime: UITableView!
    
    let customButtonColor = UIColor(red: 0.45, green: 0.72, blue: 1, alpha: 1.0)
    let customStartBgk = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpTopContainer()
        setMyTime()
        setUpInfoContainer()
        setupTableViewTime()
        setUpLabels()
        
        initConstraints()
    }
    

    func setupTableViewTime(){
        tableViewTime = UITableView()
        tableViewTime.register(TimeTableViewCell.self, forCellReuseIdentifier: "times")
        tableViewTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewTime)
    }
//    func setUpAdditionalInfoContainer() {
//        additionalInfoContainer = UIView()
//        additionalInfoContainer.backgroundColor = UIColor.white
//        additionalInfoContainer.layer.cornerRadius = 10
//        additionalInfoContainer.layer.shadowColor = UIColor.black.cgColor
//        additionalInfoContainer.layer.shadowOpacity = 0.5
//        additionalInfoContainer.layer.shadowOffset = CGSize(width: 2, height: 2)
//        additionalInfoContainer.layer.shadowRadius = 4
//        additionalInfoContainer.translatesAutoresizingMaskIntoConstraints = false
//        
//        containerTop.addSubview(additionalInfoContainer)
//    }
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
            
            tableViewTime.topAnchor.constraint(equalTo: containerTop.bottomAnchor, constant: 20),

            tableViewTime.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewTime.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewTime.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),

        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
