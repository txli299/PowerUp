//
//  ProfileViewController.swift
//  PowerUp
//
//  Created by Hank Gu on 11/10/23.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper


class ProfileViewController: UIViewController {
    
    var profileView: ProfileView!
    var userEmail: String?
    
    override func loadView() {
        profileView = ProfileView()
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        profileView.deleteAccountButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        
        // Load user data
        loadUserData()
    }
    
    private func loadUserData() {
            if let user = FirebaseAuth.Auth.auth().currentUser {
                DispatchQueue.main.async {
                    // Directly set the text of the labels
                    self.profileView.usernameValueLabel.text = user.email ?? "Unavailable"
                    self.profileView.uidValueLabel.text = user.uid
                }
            }
        }

    
    @objc func signOut() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            KeychainService.deleteToken()
//            KeychainWrapper.standard.removeObject(forKey: "userID")
            // Assuming self.tabBarController is your instance of ViewController
            (self.tabBarController as? ViewController)?.userDidLogout()
        } catch let signOutError {
            print("Error signing out: \(signOutError)")
        }
    }

    
    private func navigateToLogin() {
            // If using a navigation controller
            if let loginViewController = self.navigationController?.viewControllers.first(where: { $0 is LoginViewController }) {
                self.navigationController?.popToViewController(loginViewController, animated: true)
            } else {
                // Create a new instance and set it as the root or pop to it
                let loginViewController = LoginViewController()
                self.navigationController?.setViewControllers([loginViewController], animated: true)
            }
        }

    @objc func deleteAccount() {
        // Confirmation alert
        let confirmAlert = UIAlertController(title: "Delete Account", message: "Are you sure you want to delete your account? This action cannot be undone.", preferredStyle: .alert)
        
        // Delete action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            guard let user = FirebaseAuth.Auth.auth().currentUser else {
                self.alert(message: "No user found.")
                return
            }
            
            user.delete { error in
                if let error = error {
                    // Handle errors here
                    self.alert(message: "Error deleting account: \(error.localizedDescription)")
                } else {
                    // Account deleted successfully
//                    KeychainWrapper.standard.removeObject(forKey: "userID")
                    KeychainService.deleteToken()
                    // Inform the UITabBarController to handle the UI update
                    DispatchQueue.main.async {
                        (self.tabBarController as? ViewController)?.userDidLogout()
                    }
                }
            }
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // Add actions to alert
        confirmAlert.addAction(deleteAction)
        confirmAlert.addAction(cancelAction)
        
        // Present alert
        present(confirmAlert, animated: true)
    }

    
    // Helper function to display alerts
    func alert(message: String) {
        let alertController = UIAlertController(
            title: "Warning",
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        )
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
