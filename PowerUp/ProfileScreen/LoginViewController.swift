//
//  LoginViewController.swift
//  PowerUp
//
//  Created by Dingbang Chen on 10/2/23.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }

    // Helper function to display alerts to the user
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
    
    // Helper function to display success message and navigate to profile
    func navigateToProfile() {
        // Dismiss the login view controller to reveal the UITabBarController.
        self.dismiss(animated: true) {
            // The UITabBarController needs to handle what happens after this dismissal.
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(onButtonSigninTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onButtonRegisterTapped() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen  // To ensure full screen presentation
        self.present(registerVC, animated: true, completion: nil)
    }
    
    @objc func onButtonSigninTapped() {
        guard let email = loginView.userNameTextField.text, !email.isEmpty,
              let password = loginView.passWordTextField.text, !password.isEmpty else {
            alert(message: "Please fill all fields")
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.alert(message: "Login Error: \(error.localizedDescription)")
                return
            }
            
            // Assuming success, store the user ID in Keychain for persistent login
//            if let userID = result?.user.uid {
//                let saveSuccessful: Bool = KeychainWrapper.standard.set(userID, forKey: "userID")
//                print("Was the save successful: \(saveSuccessful)")
//                // Navigate to profile view controller
//                strongSelf.navigateToProfile()
//            }
            if let userID = result?.user.uid {
                KeychainService.saveToken(userID)
                // Navigate to profile view controller
                strongSelf.navigateToProfile()
            }
            
            // to json - UserService
            if let userID = result?.user.uid, let email = result?.user.email {
                    let userDetailsJSON = UserService.createUserJSON(uid: userID, email: email)
                    UserService.postUserDetails(userDetails: userDetailsJSON) { success, error in
                        DispatchQueue.main.async {
                            if success {
                                print("User details successfully posted to the server.")
                                // Navigate to the profile view controller or handle success
                            } else {
                                print("Failed to post user details with error: \(error?.localizedDescription ?? "Unknown error")")
                                // Handle failure
                            }
                        }
                    }
                }
            
        })
        
    }
}
