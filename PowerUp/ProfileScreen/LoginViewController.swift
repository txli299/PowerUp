//
//  ProfileScreenController.swift
//  PowerUp
//
//  Created by Dingbang Chen on 10/2/23.
//

import UIKit
import FirebaseAuth
class ProfileScreenController: UIViewController {
    let loginView = LoginView()
    
    override func loadView() {
        view = loginView
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
                        message: "Sign in successfully",
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
    
    override func viewDidLoad() {
            super.viewDidLoad()
            loginView.loginButton.addTarget(self, action: #selector(onButtonSigninTapped), for: .touchUpInside)
            loginView.registerButton.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onButtonRegisterTapped(){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func onButtonSigninTapped(){
        guard let email = loginView.userNameTextField.text, !email.isEmpty,
              let password = loginView.passWordTextField.text, !password.isEmpty else{
            alert(message: "Please fill all fields")
            return
        }
        
        //Get auth instance
        //attemp sign in
        // fails then alert
        //
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else{
                return
            }
            guard error == nil else{
                strongSelf.alert(message: "Something wrong when signing in, please try again")
                return
            }
            strongSelf.successMsg()
            
        })
    }
}
