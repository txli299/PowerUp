//
//  RegisterView.swift
//  PowerUp
//
//  Created by Cliff Li on 10/18/23.
//

import UIKit

class RegisterView: UIView {
    var startView: UIView!
    var midView:UIView!
    var userNameLabel: UILabel!
    var passWordLabel: UILabel!
    var userNameTextField: UITextField!
    var passWordTextField: UITextField!
    var confirmPasswordLabel: UILabel!
    var confirmPasswordTextField: UITextField!
    var signupLabel: UILabel!
    var signupButton: UIButton!
    
    
    var backButton: UIButton!
    
    let customStartBgk = UIColor(red: 0.035 , green: 0.51 , blue: 0.89, alpha: 1.0)
    let customButtonColor = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)
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
            startView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
             startView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
             startView.topAnchor.constraint(equalTo: self.topAnchor),
             startView.heightAnchor.constraint(equalToConstant: 200),
            
            signupLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            signupLabel.leadingAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.leadingAnchor, constant:16),
            signupLabel.trailingAnchor.constraint(equalTo:
            self.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            
            // Constraints for midView
            midView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            midView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            midView.topAnchor.constraint(equalTo: startView.bottomAnchor, constant: -40),
            midView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            

            // Username Label
            userNameLabel.topAnchor.constraint(equalTo: midView.topAnchor, constant: 30),
            userNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),

            // Username TextField
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            userNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: midView.trailingAnchor, constant: -35),

            // Password Label
            passWordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passWordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),

            // Password TextField
            passWordTextField.topAnchor.constraint(equalTo: passWordLabel.bottomAnchor, constant: 10),
            passWordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            passWordTextField.trailingAnchor.constraint(equalTo: midView.trailingAnchor, constant: -35),

            // Confirm Password Label
            confirmPasswordLabel.topAnchor.constraint(equalTo: passWordTextField.bottomAnchor, constant: 20),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),

            // Confirm Password TextField
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 10),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: midView.trailingAnchor, constant: -35),

            // Register Button
            signupButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            signupButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signupButton.widthAnchor.constraint(equalToConstant: 120),
            signupButton.heightAnchor.constraint(equalToConstant: 50),

            // Cancel Button
            backButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 30),
            backButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            backButton.widthAnchor.constraint(equalToConstant: 130),
            backButton.heightAnchor.constraint(equalToConstant: 45)
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
        //Sign Up Label
        signupLabel = UILabel()
        signupLabel.text = "Sign Up"
        signupLabel.font = UIFont.boldSystemFont(ofSize: 26)
        signupLabel.textColor = .white
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        startView.addSubview(signupLabel)
        //UserName TextField
        userNameTextField = UITextField()
        userNameTextField.placeholder = "Type In"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(userNameTextField)
        passWordTextField = UITextField()
        passWordTextField.placeholder = "Type In"
        passWordTextField.borderStyle = .roundedRect
        passWordTextField.translatesAutoresizingMaskIntoConstraints = false
        passWordTextField.isSecureTextEntry = true // This makes the text field secure
        passWordTextField.autocorrectionType = .no  // Disables autocorrection
        passWordTextField.autocapitalizationType = .none  // Disables auto-capitalization
        midView.addSubview(passWordTextField)
        
        // Confirm Password Label
        confirmPasswordLabel = UILabel()
        confirmPasswordLabel.text = "Confirm Password"
        confirmPasswordLabel.font = UIFont.systemFont(ofSize: 18)
        confirmPasswordLabel.textColor = .black
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(confirmPasswordLabel)
        
        // Confirm Password TextField
        confirmPasswordTextField = UITextField()
        confirmPasswordTextField.placeholder = "Re-type Password"
        confirmPasswordTextField.borderStyle = .roundedRect
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.autocorrectionType = .no
        confirmPasswordTextField.autocapitalizationType = .none
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(confirmPasswordTextField)
                
        signupButton = UIButton()
        signupButton.setTitle("Register", for: .normal)
        signupButton.backgroundColor = customButtonColor
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.layer.cornerRadius = 12
        signupButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(signupButton)
        
        backButton = UIButton()
        backButton.setTitle("Cancle", for: .normal)
        backButton.backgroundColor = customButtonColor
        backButton.clipsToBounds = true
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.layer.cornerRadius = 12
        backButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        midView.addSubview(backButton)
    }
    
    // Button tap action
    @objc func buttonTapped(_ sender: UIButton) {
        sender.backgroundColor = UIColor.lightGray // Change color on tap
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.backgroundColor = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)// Change back after delay
        }
    }
}
