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
        
    }
    
    @objc func onButtonBackTapped(){
        let ProfileVC = ProfileScreenController()
        navigationController?.pushViewController(ProfileVC, animated: true)
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
    
    
    @objc func onButtonSignupTapped(){
        guard let email = registerView.userNameTextField.text, !email.isEmpty,
              let password = registerView.passWordTextField.text, !password.isEmpty else{
            alert(message: "Please fill all fields")
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
            let profileVC = ProfileScreenController()
            strongSelf.navigationController?.pushViewController(profileVC, animated: true)
        })
    }
}
