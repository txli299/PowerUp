//
//  ProfileScreenController.swift
//  PowerUp
//
//  Created by Dingbang Chen on 10/2/23.
//

import UIKit

class ProfileScreenController: UIViewController {
    let profileScreen = ProfileScreenView()
    override func loadView() {
        view = profileScreen
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        profileScreen.registerButton.addTarget(self, action: #selector(onButtonRegisterTapped), for: .touchUpInside)
    }
    
    @objc func onButtonRegisterTapped(){
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }

}
