//
//  RegisterViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/11/23.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    let registerView = RegisterView()
    override func loadView() {
        view = registerView
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        registerView.signupButton.addTarget(self, action: #selector(buttonSignupTapped), for: .touchUpInside)
        registerView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    @objc func cancelTapped(){
        let profileVC = ProfileScreenController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @objc func buttonSignupTapped() {
        guard let email = registerView.userNameTextField.text else {return}
        guard let password = registerView.passWordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) {firebaseResult, error in
            if let e = error{
                print("error")
            }else{
                print("successs")
            }
            
        }
        
    }
}
