//
//  RegisterViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/18/23.
//

import UIKit
import FirebaseAuth
class RegisterViewController: UIViewController {
    let registerView = RegisterView()
    
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.signupButton.addTarget(self, action: #selector(onButtonSignupTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target:self , action: #selector(onButtonBackTapped))
        registerView.backButton.addTarget(self, action: #selector(onButtonBackTapped), for: .touchUpInside)

    }
    
    @objc func onButtonBackTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    func alert(message:String){
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
    
    func successMsg(){
        let alertController = UIAlertController(
                        title: "Success",
                        message: "Congradulation, you have created your account",
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
    
    
    @objc func onButtonSignupTapped() {
        guard let email = registerView.userNameTextField.text, !email.isEmpty,
              let password = registerView.passWordTextField.text, !password.isEmpty,
              let confirmPassword = registerView.confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            alert(message: "Please fill all fields")
            return
        }

        if password != confirmPassword {
            alert(message: "Passwords do not match")
            return
        }
        
        //Get auth instance
        //attemp sign in
        // fails then alert
        //
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                strongSelf.alert(message: "Something wrong when signing up, please try again")
                return
            }
            strongSelf.successMsg()
            
            let profileVC = LoginViewController()
            strongSelf.navigationController?.pushViewController(profileVC, animated: true)
            
            // to json - UserService - After successful registration or login
            if let userID = result?.user.uid, let email = result?.user.email {
                let userDetailsJSON = UserService.createUserJSON(uid: userID, email: email)
                UserService.postUserDetails(userDetails: userDetailsJSON) { success, error in
                    DispatchQueue.main.async {
                        if success {
                            print("User details successfully posted to the server.")
                            // Handle success - perhaps by transitioning to the profile view or showing a success message
                        } else {
                            print("Failed to post user details with error: \(error?.localizedDescription ?? "Unknown error")")
                            // Handle failure - show an alert to the user or log the error
                        }
                    }
                }
            }

        })
        self.dismiss(animated: true, completion: nil)
    }
}
