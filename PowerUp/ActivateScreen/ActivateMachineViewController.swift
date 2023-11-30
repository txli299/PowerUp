//
//  ActivateMachineViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 11/23/23.
//

import UIKit

import UIKit
import Alamofire

class ActiavteMachineViewController: UIViewController {
    let activateMachineView = ActivateMachineView()
    let uid = KeychainService.loadToken()
    override func loadView() {
        view = activateMachineView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activateMachineView.activateButton.addTarget(self, action: #selector(activate), for: .touchUpInside)
        
    }
    
    func reload(){
        activateMachineView.midTextField.text = ""
        activateMachineView.typeLabel.text = ""
        activateMachineView.rateLabel.text = ""
    }
    
    @objc func activate(){
        let mid = activateMachineView.midTextField.text ?? ""
        let url = APIConfigs.baseAPI + "user/\(self.uid!)/credit"
        AF.request(url)
            .validate()
            .responseDecodable(of: Double.self) { response in
                switch response.result {
                    case .success(let credit):
                        if credit<5{
                            let alertController = UIAlertController(
                                title: "Insufficient balance",
                                message: "Your balance is insufficient",
                                preferredStyle: .alert
                            )

                            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(okAction)

                            self.present(alertController, animated: true, completion: nil)
                        }else{
                            print("check machine")
                            self.checkMachine(mid: mid)
                        }

                    case .failure(let error):
                        print("Failed to load credit: \(error.localizedDescription)")
                }
            }
        
        

    }
    
    func activeteMachine(mid: String){
        let url = APIConfigs.baseAPI + "machine/activate"
        AF.request(url, method:.post, parameters:
                                    [
                                        "userId": uid!,
                                        "mid": mid
                                    ])
                        .responseString(completionHandler: { response in
            switch response.result {
                case .success(_):
                    if let statusCode = response.response?.statusCode, statusCode == 200 {
                        // Show a success alert
                        let alertController = UIAlertController(
                            title: "Success",
                            message: "Machine is successfully activated",
                            preferredStyle: .alert
                        )

                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(okAction)

                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        // Show an alert for non-200 status codes
                        self.showFailureAlert()
                    }
                        
                case .failure(let error):
                    print("Error: \(error)")

                    // Show an error alert if the request fails
                    self.showFailureAlert()
            }
        })
    }
                                        
    
    func showFailureAlert() {
            print("Userid is \(KeychainService.loadToken())")
            let alertController = UIAlertController(
                title: "Failure",
                message: "Failed to retrieve data from the API or non-200 status code.",
                preferredStyle: .alert
            )

            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)

            present(alertController, animated: true, completion: nil)
        }
    
    func checkMachine(mid: String) {
        let url = APIConfigs.baseAPI + "machine/\(mid)"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                // Assuming the response is a dictionary
                if let json = value as? [String: Any] {
                    if let activation = json["activated"] as? Bool{

                        if activation == true{
                            let alertController = UIAlertController(
                                    title: "Machine in Use",
                                    message: "The machine is in use",
                                    preferredStyle: .alert
                                )
                            let okAction = UIAlertAction(title: "OK", style: .default)
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                        }else{
                            if let type = json["type"] as? String {
                                
                                // Update the text of your typeLabel
                                self.activateMachineView.typeLabel.text = "Type: " + type
                                let rate = 3
                                let alertController = UIAlertController(
                                    title: "Rate Information",
                                    message: "The rate is \(rate) per hour.",
                                    preferredStyle: .alert
                                )

                                let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                                    self.activeteMachine(mid: mid)
                                }

                                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

                                alertController.addAction(okAction)
                                alertController.addAction(cancelAction)

                                self.present(alertController, animated: true, completion: nil)
                        }
                    }
            }
                }
            case .failure(_):
                let alertController = UIAlertController(
                    title: "No machine found",
                    message: "Chech the id again.",
                    preferredStyle: .alert
                )

                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
