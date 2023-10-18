//
//  RegisterView.swift
//  PowerUp
//
//  Created by Cliff Li on 10/11/23.
//

import UIKit

class RegisterView: UIView {
    var startView: UIView!
    var midView:UIView!
    var userNameLabel: UILabel!
    var passWordLabel: UILabel!
    var userNameTextField: UITextField!
    var passWordTextField: UITextField!
    var cancelButton: UIButton!
    var signupLabel: UILabel!
    var signupButton: UIButton!
    
    let customStartBgk = UIColor(red: 0.035 , green: 0.51 , blue: 0.89, alpha: 1.0)
    let midBgkColor = UIColor(red: 0.9882, green: 0.9882, blue: 0.9882, alpha: 1.0)
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            
        self.backgroundColor = .white
        
            
        //MARK: initializing the UI elements and constraints...
        setupStartComponent()
        setupMidComponent()
        setupVariables()
        initConstraints()
            
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStartComponent(){
        
        // create box
        startView = UIView()
        startView.backgroundColor = customStartBgk
        startView.translatesAutoresizingMaskIntoConstraints = false
        startView.layer.zPosition = -100
        self.addSubview(startView)
    }
    
    func setupMidComponent(){
        midView = UIView()
        midView.backgroundColor = midBgkColor
        midView.layer.shadowColor = UIColor.black.cgColor
        midView.layer.shadowOpacity = 0.5
        midView.layer.shadowOffset = CGSize(width: 0, height: 2)
        midView.translatesAutoresizingMaskIntoConstraints = false
        midView.layer.cornerRadius = 10
        midView.layer.zPosition = -50
        self.addSubview(midView)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            startView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor), // Leading constraint to the left edge
            startView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor), // Trailing constraint to the right edge
            startView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0), // Adjust top spacing as needed
            startView.heightAnchor.constraint(equalToConstant: 200),
            
            midView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            midView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            midView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 110),
            midView.heightAnchor.constraint(equalToConstant: 350),
            signupLabel.topAnchor.constraint(equalTo: startView.topAnchor, constant: 110),
            signupLabel.leadingAnchor.constraint(equalTo:
                                                    startView.leadingAnchor, constant:40),
            
            userNameLabel.topAnchor.constraint(equalTo: midView.topAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo:midView.leadingAnchor, constant:20),
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo:midView.leadingAnchor, constant:20),
            
            passWordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passWordLabel.leadingAnchor.constraint(equalTo:midView.leadingAnchor, constant:20),
            passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor, constant: 20),
            
            passWordTextField.leadingAnchor.constraint(equalTo:midView.leadingAnchor, constant:20),
            signupButton.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 50),
            signupButton.leadingAnchor.constraint(equalTo:midView.leadingAnchor, constant:20),
            signupButton.widthAnchor.constraint(equalToConstant: 120),
            signupButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 50),
            cancelButton.leadingAnchor.constraint(equalTo:
                                                    signupButton.trailingAnchor, constant:20),
            cancelButton.widthAnchor.constraint(equalToConstant: 120),
            cancelButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    func setupVariables(){
        //UserName Label
        userNameLabel = UILabel()
        userNameLabel.text = "User Name"
        userNameLabel.font = UIFont.systemFont(ofSize: 18)
        userNameLabel.textColor = .black
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(userNameLabel)
        //Password Label
        passWordLabel = UILabel()
        passWordLabel.text = "Password"
        passWordLabel.font = UIFont.systemFont(ofSize: 18)
        passWordLabel.textColor = .black
        passWordLabel.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(passWordLabel)
        //Login Label
        signupLabel = UILabel()
        signupLabel.text = "Sign up"
        signupLabel.font = UIFont.boldSystemFont(ofSize: 30)
        signupLabel.textColor = .white
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        startView.addSubview(signupLabel)
        //UserName TextField
        userNameTextField = UITextField()
        userNameTextField.placeholder = "Enter Username"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(userNameTextField)
        passWordTextField = UITextField()
        passWordTextField.placeholder = "Enter Password"
        passWordTextField.borderStyle = .roundedRect
        passWordTextField.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(passWordTextField)
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        cancelButton.backgroundColor = customStartBgk
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 10
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitleColor(.white, for: .normal)
        midView.addSubview(cancelButton)
        signupButton = UIButton(type: .system)
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        signupButton.backgroundColor = customStartBgk
        signupButton.clipsToBounds = true
        signupButton.layer.cornerRadius = 10
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.setTitleColor(.white, for: .normal)
        midView.addSubview(signupButton)
    }
}
