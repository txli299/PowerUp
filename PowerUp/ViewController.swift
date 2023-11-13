//
//  ViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 9/20/23.
//

import UIKit
import FirebaseAuth


class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: false, completion: nil)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: Setting up Store Screen
        let tabStore = UINavigationController(rootViewController: StoreViewController())
        let tabStoreBarItem = UITabBarItem(
            title: "Store",
            image: UIImage(systemName: "cup.and.saucer")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "cup.and.saucer.fill")
        )
        tabStore.tabBarItem = tabStoreBarItem
        tabStore.title = "Store"
        
        //MARK: Setting up Start Screen
        let tabStart = UINavigationController(rootViewController: StartScreenController())
        let tabStartBarItem = UITabBarItem(
            title: "Start",
            image: UIImage(systemName: "hourglass.start")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "hourglass")
        )
        tabStartBarItem.badgeColor = UIColor.lightGray
        tabStart.tabBarItem = tabStartBarItem
        tabStart.title = "Start"
        
        //MARK: Setting up Wallet Screen
        let tabWallet = UINavigationController(rootViewController: WalletViewController())
        let tabWalletBarItem = UITabBarItem(
            title: "Wallet",
            image: UIImage(systemName: "creditcard")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(systemName: "creditcard.fill")
        )
        tabWallet.tabBarItem = tabWalletBarItem
        tabWallet.title = "Wallet"
        
        //MARK: Setting up Time Screen
        let tabTime = UINavigationController(rootViewController: TimeViewController())
        let tabTimeBarItem = UITabBarItem(
            title: "Time",
            image: UIImage(systemName: "clock")?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "clock.fill")
        )
        
        tabTimeBarItem.badgeColor = UIColor.lightGray
        tabTime.tabBarItem = tabTimeBarItem
        tabTime.title = "Time"
        
        let profileRootVC = FirebaseAuth.Auth.auth().currentUser != nil ? ProfileViewController() : LoginViewController()
            let tabProfile = UINavigationController(rootViewController: profileRootVC)
            let tabProfileBarItem = UITabBarItem(
                title: "Profile",
                image: UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(systemName: "person.fill")
            )
            tabProfile.tabBarItem = tabProfileBarItem
            tabProfile.title = "Profile"
            
            self.viewControllers = [tabStore, tabStart, tabWallet, tabTime, tabProfile]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Dingbang First Commit check, second check
    }
    func userDidLogout() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
}
