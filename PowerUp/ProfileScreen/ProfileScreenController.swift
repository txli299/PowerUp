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

        // Do any additional setup after loading the view.
    }
    
}
