//
//  ProfileView.swift
//  PowerUp
//
//  Created by Hank Gu on 11/10/23.
//
// ProfileView.swift

// ProfileView.swift

import UIKit

class ProfileView: UIView {
    var startView: UIView!
    var midView: UIView!
    var profileImageView = UIImageView()
    var nameLabel = UILabel()
    var uidLabel = UILabel()
    var versionLabel = UILabel()
    var signOutButton = UIButton()
    var deleteAccountButton = UIButton()
    var welcomeLabel = UILabel()
    var usernameValueLabel: UILabel!
    var uidValueLabel: UILabel!

    let customStartBgk = UIColor(red: 0.035 , green: 0.51 , blue: 0.89, alpha: 1.0)
    let customButtonColor = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0)
    let midBgkColor = UIColor(red: 0.9882, green: 0.9882, blue: 0.9882, alpha: 1.0)

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white

        setupStartComponent()
        setupMidComponent()
        setupVariables()
        initConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupStartComponent() {
        startView = UIView()
        startView.backgroundColor = customStartBgk
        startView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(startView)
    }

    func setupMidComponent() {
        midView = UIView()
        midView.backgroundColor = midBgkColor
        midView.layer.cornerRadius = 10
        midView.layer.shadowColor = UIColor.black.cgColor
        midView.layer.shadowOpacity = 0.5
        midView.layer.shadowOffset = CGSize(width: 2, height: 2)
        midView.layer.shadowRadius = 4
        midView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(midView)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            startView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            startView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            startView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            startView.heightAnchor.constraint(equalToConstant: 200),

            midView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            midView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            midView.topAnchor.constraint(equalTo: startView.bottomAnchor, constant: -40),
            midView.heightAnchor.constraint(equalToConstant: 350),

welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            welcomeLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            nameLabel.topAnchor.constraint(equalTo: midView.topAnchor, constant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: midView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: midView.trailingAnchor, constant: -16),
            
            // Constraints for usernameValueLabel
            usernameValueLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            usernameValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            usernameValueLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            // Constraints for uidLabel
            uidLabel.topAnchor.constraint(equalTo: usernameValueLabel.bottomAnchor, constant: 20),
            uidLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            uidLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            // Constraints for uidValueLabel
            uidValueLabel.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 5),
            uidValueLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            uidValueLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),

            signOutButton.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 50),
            signOutButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signOutButton.widthAnchor.constraint(equalToConstant: 130),
            signOutButton.heightAnchor.constraint(equalToConstant: 45),

            deleteAccountButton.topAnchor.constraint(equalTo: uidLabel.bottomAnchor, constant: 50),
            deleteAccountButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -65),
            deleteAccountButton.widthAnchor.constraint(equalToConstant: 130),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }

    func setupVariables() {
            // Welcome Label
            welcomeLabel = UILabel()
            welcomeLabel.text = "WELCOME"
            welcomeLabel.font = UIFont.boldSystemFont(ofSize: 26)
            welcomeLabel.textColor = .white
            welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
            startView.addSubview(welcomeLabel)
            
        // Configure Username Label
            nameLabel.text = "Username"
            nameLabel.textColor = customStartBgk
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            midView.addSubview(nameLabel)
            
        // Configure Username Value Label
            usernameValueLabel = UILabel()
            usernameValueLabel.font = UIFont.systemFont(ofSize: 18)
            usernameValueLabel.textColor = .black
            usernameValueLabel.translatesAutoresizingMaskIntoConstraints = false
            midView.addSubview(usernameValueLabel)
            
            /// Configure UID Label
            uidLabel.text = "UID"
            uidLabel.textColor = customStartBgk
            uidLabel.translatesAutoresizingMaskIntoConstraints = false
            midView.addSubview(uidLabel)
            
            // Configure UID Value Label
            uidValueLabel = UILabel()
            uidValueLabel.font = UIFont.systemFont(ofSize: 18)
            uidValueLabel.textColor = .black
            uidValueLabel.translatesAutoresizingMaskIntoConstraints = false
            midView.addSubview(uidValueLabel)
            
            
            // Sign Out Button
            signOutButton = UIButton()
            signOutButton.setTitle("Sign Out", for: .normal)
            signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            signOutButton.backgroundColor = customButtonColor
            signOutButton.setTitleColor(UIColor.white, for: .normal)
            signOutButton.layer.cornerRadius = 12
            signOutButton.translatesAutoresizingMaskIntoConstraints = false
            midView.addSubview(signOutButton)
            
            // Delete Account Button
            deleteAccountButton = UIButton()
            deleteAccountButton.setTitle("Delete Account", for: .normal)
            deleteAccountButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            deleteAccountButton.backgroundColor = customButtonColor
            deleteAccountButton.setTitleColor(UIColor.white, for: .normal)
            deleteAccountButton.layer.cornerRadius = 12
            deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
            midView.addSubview(deleteAccountButton)
        }
}
