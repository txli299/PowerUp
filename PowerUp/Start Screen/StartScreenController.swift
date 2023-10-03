//
//  StartScreenControllerViewController.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 9/25/23.
//

import UIKit

class StartScreenController: UIViewController {
    
    //MARK: initializing the First Screen View...
    let startScreen = StartScreen()
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = startScreen
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        startScreen.scanButton.addTarget(self, action: #selector(onButtonScanSubmitTapped), for: .touchUpInside)
        startScreen.typeNumberButton.addTarget(self, action: #selector(onButtonTypeSubmitTapped), for: .touchUpInside)
    }
    
    //MARK: submit scan button tapped action...
    @objc func onButtonScanSubmitTapped(){
        print("Scan Button: I was clicked!")
    }
    
    //MARK: submit type button tapped action...
    @objc func onButtonTypeSubmitTapped(){
        print("Type Button: I was clicked!")
    }
    
}
