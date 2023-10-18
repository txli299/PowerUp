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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
