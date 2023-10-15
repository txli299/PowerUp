//
//  ProfileScreenController.swift
//  PowerUp
//
//  Created by Dingbang Chen on 10/2/23.
//

import UIKit

class ProfileScreenController: UIViewController {
    
    //MARK: initializing the First Screen View...
    let profileScreen = ProfileScreenView()
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = profileScreen
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
