//
//  StoreScreen.swift
//  PowerUp
//
//  Created by Cliff Li on 10/1/23.
//

import UIKit

class StoreScreen: UIView {
    var viewStar: UIView!
    var viewPCInfo: UIView!
    var viewPSInfo: UIView!
    
    var labelStart: UILabel!
    var labelPCName: UILabel!
    var labelPCAvailability: UILabel!
    var labelPSName: UILabel!
    var labelPSAvailability: UILabel!
    
    var imageViewPC: UIImageView!
    var imageViewPS: UIImageView!
    
    
    var buttonLocation: UIButton!
    
    let customButtonColor = UIColor(red: 0.45, green: 0.72, blue: 1, alpha: 1.0)
    let customStartBgk = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupStartComponent()
        setupPCComponent()
        setupPSComponent()
        
        initConstraints()
    }
    

    
    func setupStartComponent(){
        viewStar = UIView()
        viewStar.backgroundColor = customStartBgk
        viewStar.translatesAutoresizingMaskIntoConstraints = false
        
        labelStart = UILabel()
        labelStart.text = "Location Summary"
        labelStart.font = UIFont.boldSystemFont(ofSize: 26)
        labelStart.textColor = UIColor.white
        labelStart.translatesAutoresizingMaskIntoConstraints = false
        
        buttonLocation = UIButton()
        buttonLocation.setTitle("123 Street", for: .normal)
        buttonLocation.setTitleColor(UIColor.white, for: .normal)
        buttonLocation.titleLabel?.font = .systemFont(ofSize: 22)
        buttonLocation.backgroundColor = customButtonColor
        buttonLocation.contentHorizontalAlignment = .left
        buttonLocation.layer.cornerRadius = 10
        buttonLocation.translatesAutoresizingMaskIntoConstraints = false
        
        viewStar.addSubview(labelStart)
        viewStar.addSubview(buttonLocation)
        self.addSubview(viewStar)
    }
    
    func setupPCComponent(){
        viewPCInfo = UIView()
        viewPCInfo.backgroundColor = UIColor.white
        viewPCInfo.layer.cornerRadius = 10
        viewPCInfo.layer.shadowColor = UIColor.black.cgColor
        viewPCInfo.layer.shadowOpacity = 0.5
        viewPCInfo.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewPCInfo.layer.shadowRadius = 4
        viewPCInfo.layer.cornerRadius = 10
        viewPCInfo.translatesAutoresizingMaskIntoConstraints = false
        
        labelPCName = UILabel()
        labelPCName.text = "PCs availability"
        labelPCName.font = UIFont.boldSystemFont(ofSize: 18)
        labelPCName.translatesAutoresizingMaskIntoConstraints = false
        
        labelPCAvailability = UILabel()
        labelPCAvailability.text = "8/10"
        labelPCAvailability.font = UIFont.systemFont(ofSize: 16)
        labelPCAvailability.translatesAutoresizingMaskIntoConstraints = false
        
        
        imageViewPC = UIImageView(image: UIImage(named: "pc_image")!)
        imageViewPC.frame = CGRect(x: 180, y: 20, width: 150, height: 150)
        
        viewPCInfo.addSubview(labelPCName)
        viewPCInfo.addSubview(labelPCAvailability)
        viewPCInfo.addSubview(imageViewPC)
        self.addSubview(viewPCInfo)
        
        
    }
    
    func setupPSComponent(){
        viewPSInfo = UIView()
        viewPSInfo.backgroundColor = UIColor.white
        viewPSInfo.layer.cornerRadius = 10
        viewPSInfo.layer.shadowColor = UIColor.black.cgColor
        viewPSInfo.layer.shadowOpacity = 0.5
        viewPSInfo.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewPSInfo.layer.shadowRadius = 4
        viewPSInfo.layer.cornerRadius = 10
        viewPSInfo.translatesAutoresizingMaskIntoConstraints = false
        
        labelPSName = UILabel()
        labelPSName.text = "PSs availability"
        labelPSName.font = UIFont.boldSystemFont(ofSize: 18)
        labelPSName.translatesAutoresizingMaskIntoConstraints = false
        
        labelPSAvailability = UILabel()
        labelPSAvailability.text = "8/10"
        labelPSAvailability.font = UIFont.systemFont(ofSize: 16)
        labelPSAvailability.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewPS = UIImageView(image: UIImage(named: "ps_image")!)
        imageViewPS.frame = CGRect(x: 180, y: 20, width: 150, height: 150)
        
        viewPSInfo.addSubview(labelPSName)
        viewPSInfo.addSubview(labelPSAvailability)
        viewPSInfo.addSubview(imageViewPS)
        self.addSubview(viewPSInfo)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            viewStar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            viewStar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            viewStar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            viewStar.heightAnchor.constraint(equalToConstant: 200),
            
            labelStart.topAnchor.constraint(equalTo: viewStar.topAnchor, constant: 70),
            labelStart.leadingAnchor.constraint(equalTo: viewStar.leadingAnchor, constant: 16),
            
            buttonLocation.topAnchor.constraint(equalTo: labelStart.topAnchor, constant: 60),
            buttonLocation.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonLocation.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            viewPCInfo.topAnchor.constraint(equalTo: viewStar.bottomAnchor, constant: -10),
            viewPCInfo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            viewPCInfo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewPCInfo.heightAnchor.constraint(equalToConstant: 200),
            
            labelPCName.topAnchor.constraint(equalTo: viewPCInfo.topAnchor, constant: 20),
            labelPCName.leadingAnchor.constraint(equalTo: viewPCInfo.leadingAnchor, constant: 20),
            
            labelPCAvailability.topAnchor.constraint(equalTo: labelPCName.bottomAnchor, constant: 30),
            labelPCAvailability.leadingAnchor.constraint(equalTo: viewPCInfo.leadingAnchor, constant: 20),
            
            viewPSInfo.topAnchor.constraint(equalTo: viewPCInfo.bottomAnchor, constant: 20),
            viewPSInfo.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            viewPSInfo.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            viewPSInfo.heightAnchor.constraint(equalToConstant: 200),
            
            labelPSName.topAnchor.constraint(equalTo: viewPSInfo.topAnchor, constant: 20),
            labelPSName.leadingAnchor.constraint(equalTo: viewPSInfo.leadingAnchor, constant: 20),
            
            labelPSAvailability.topAnchor.constraint(equalTo: labelPSName.bottomAnchor, constant: 30),
            labelPSAvailability.leadingAnchor.constraint(equalTo: viewPSInfo.leadingAnchor, constant: 20)
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
