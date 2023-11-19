//
//  ProfileView.swift
//  PowerUp
//
//  Created by Hank Gu on 11/10/23.
//

import UIKit

class ProfileView: UIView {
    
    var startView: UIView!
    let profileImageView = UIImageView()
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let versionLabel = UILabel()
    let signOutButton = UIButton()
    let deleteAccountButton = UIButton()
    var headLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Create and style the startView similar to LoginView
        startView = UIView()
        startView.backgroundColor = UIColor(red: 0.035, green: 0.51, blue: 0.89, alpha: 1.0) // Use the same color as in LoginView
        startView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(startView)

        backgroundColor = .white
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.masksToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profileImageView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
        
        emailLabel.font = UIFont.systemFont(ofSize: 18)
        emailLabel.textColor = .gray
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emailLabel)
        
        versionLabel.font = UIFont.systemFont(ofSize: 18)
        versionLabel.textColor = .gray
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(versionLabel)
        
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.setTitleColor(.red, for: .normal)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(signOutButton)
        
        deleteAccountButton.setTitle("Delete Account", for: .normal)
        deleteAccountButton.setTitleColor(.red, for: .normal)
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteAccountButton)
    }
    
    func setupVariables(){
        //Sign Up Label
        headLabel = UILabel()
        headLabel.text = "Welcom"
        headLabel.font = UIFont.boldSystemFont(ofSize: 26)
        headLabel.textColor = .white
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        startView.addSubview(headLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            // Constraints for startView
            startView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            startView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            startView.topAnchor.constraint(equalTo: self.topAnchor),
            startView.heightAnchor.constraint(equalToConstant: 200), // Set the height as in LoginView
                        
            // Profile Image Constraints
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 60), // Adjust size as needed
            profileImageView.heightAnchor.constraint(equalToConstant: 60), // Adjust size as needed
            
            // Name Label Constraints
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Email Label Constraints
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Version Label Constraints (Assuming it's at the top of the general section)
            versionLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20), // Adjust distance from email label as needed
            versionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            versionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            // Sign Out Button Constraints
            signOutButton.topAnchor.constraint(equalTo: versionLabel.bottomAnchor, constant: 24), // Adjust for space between sections
            signOutButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            signOutButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            signOutButton.heightAnchor.constraint(equalToConstant: 44), // Standard touchable height
            
            // Delete Account Button Constraints
            deleteAccountButton.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 12),
            deleteAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            deleteAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            deleteAccountButton.heightAnchor.constraint(equalToConstant: 44) // Standard touchable height
        ])
    }
}
