//
//  TimeViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/2/23.
//

import UIKit

class TimeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let timeView = TimeScreen()
        timeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeView)
        NSLayoutConstraint.activate([
            timeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timeView.topAnchor.constraint(equalTo: view.topAnchor),
            timeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        timeView.initConstraints()
    }
    


}
