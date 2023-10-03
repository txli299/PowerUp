//
//  StoreViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/1/23.
//

import UIKit

class StoreViewController: UIViewController {
    let storeScreen = StoreScreen()
    override func loadView() {
        view = storeScreen
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
