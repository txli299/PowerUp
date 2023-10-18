//
//  ProfileScreenView.swift
//  PowerUp
//
//  Created by Dingbang Chen on 10/2/23.
//

import UIKit

class ProfileScreenView: UIView {
    var startView: UIView!
    var midView:UIView!
    var userNameLabel: UILabel!
    var passWordLabel: UILabel!
    var userNameTextField: UITextField!
    var passWordTextField: UITextField!
    var loginLabel: UILabel!
    var loginButton: UIButton!
    var forgetButton: UIButton!
    var registerButton: UIButton!
    let customStartBgk = UIColor(red: 0.035 , green: 0.51 , blue: 0.89, alpha: 1.0)
    let customButtonColor = UIColor(red: 0.45 , green: 0.72 , blue: 1, alpha: 1.0)
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
        midView.backgroundColor = UIColor.white
        midView.layer.cornerRadius = 10
        midView.layer.shadowColor = UIColor.black.cgColor
        midView.layer.shadowOpacity = 0.5
        midView.layer.shadowOffset = CGSize(width: 2, height: 2)
        midView.layer.shadowRadius = 4
        midView.translatesAutoresizingMaskIntoConstraints = false
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
            midView.topAnchor.constraint(equalTo: startView.bottomAnchor, constant: -40),
            midView.heightAnchor.constraint(equalToConstant: 350),
            loginLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            loginLabel.leadingAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.leadingAnchor, constant:16),
            loginLabel.trailingAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            userNameLabel.topAnchor.constraint(equalTo: midView.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:50 ),
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 20),
            userNameTextField.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:50 ),
            
            passWordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passWordLabel.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:50 ),
            passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor, constant: 20),
            passWordTextField.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:50 ),
            loginButton.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:50 ),
            loginButton.widthAnchor.constraint(equalToConstant: 120),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            forgetButton.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 50),
            forgetButton.trailingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.trailingAnchor, constant:-50 ),
            forgetButton.widthAnchor.constraint(equalToConstant: 120),
            forgetButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 70),
            registerButton.leadingAnchor.constraint(equalTo:self.safeAreaLayoutGuide.leadingAnchor, constant:50 ),
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
        loginLabel = UILabel()
        loginLabel.text = "Log in"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 26)
        loginLabel.textColor = .white
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        startView.addSubview(loginLabel)
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
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = customButtonColor
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        midView.addSubview(loginButton)
        forgetButton = UIButton()
        forgetButton.setTitle("Forget", for: .normal)
        forgetButton.backgroundColor = customButtonColor
        forgetButton.clipsToBounds = true
        forgetButton.setTitleColor(UIColor.white, for: .normal)
        forgetButton.layer.cornerRadius = 20
        forgetButton.translatesAutoresizingMaskIntoConstraints = false

        forgetButton.setTitleColor(.white, for: .normal)
        midView.addSubview(forgetButton)
        // Register Button
        registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 25) 
        registerButton.setTitleColor(.blue, for: .normal)
        self.addSubview(registerButton)

    }

}
