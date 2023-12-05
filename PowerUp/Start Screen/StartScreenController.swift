//
//  StartScreenControllerViewController.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 9/25/23.
//

import UIKit
import Alamofire

class StartScreenController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: initializing the First Screen View...
    let startScreen = StartScreen()
    let uid = KeychainService.loadToken()
    let ActivateMachineController = ActiavteMachineViewController()
    var ActivateMachineNavController: UINavigationController!
    
    //MARK: add the view to this controller while the view is loading...
    override func loadView() {
        view = startScreen
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        getUserCredit()
    }
    
    // Integrated activeteMachine method
    func activeteMachine(mid: String) {
        let url = APIConfigs.baseAPI + "machine/activate"
        AF.request(url, method:.post, parameters: ["userId": uid!, "mid": mid])
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
    
    // Add a showFailureAlert method to handle failures
    func showFailureAlert() {
        let alertController = UIAlertController(
            title: "Notification",
            message: "Features to be developed.",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserCredit()
        startScreen.scanButton.addTarget(self, action: #selector(onButtonScanSubmitTapped), for: .touchUpInside)
        startScreen.typeNumberButton.addTarget(self, action: #selector(onButtonTypeSubmitTapped), for: .touchUpInside)
    }
    
    func getUserCredit() {
    let url = APIConfigs.baseAPI + "user/\(self.uid!)/credit"
        AF.request(url)
            .validate()
            .responseDecodable(of: Double.self) { response in
                switch response.result {
                    case .success(let credit):
                        self.startScreen.creditLabel.text = "Credit: $ "+String(credit)

                    case .failure(let error):
                        print("Failed to load credit: \(error.localizedDescription)")
                }
            }
    }

    // MARK: - Image Picker Methods
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            print("Camera not available")
            return
        }

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Handle the selected image. For the sake of the demo, we'll just use a fixed machine ID.
        let pc2 = "655cfa95a27fe84c6fc0c054"
        activeteMachine(mid: pc2)

        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Activate machine function
    func showActivateView(){
        ActivateMachineController.reload()
        ActivateMachineNavController = UINavigationController(rootViewController: ActivateMachineController)
        ActivateMachineNavController.modalPresentationStyle = .pageSheet
                
        if let bottomCheckoutSheet = ActivateMachineNavController.sheetPresentationController{
            bottomCheckoutSheet.detents = [.medium(), .large()]
            bottomCheckoutSheet.prefersGrabberVisible = true
        }
    }
 
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: submit scan button tapped action...
    // Updated onButtonScanSubmitTapped method
        @objc func onButtonScanSubmitTapped() {
            let actionSheet = UIAlertController(title: "Scan SQCode", message: "Choose a method", preferredStyle: .actionSheet)
            
            // Camera option
            let cameraAction = UIAlertAction(title: "Use Camera", style: .default) { [unowned self] _ in
                self.presentImagePicker(sourceType: .camera)
            }
            actionSheet.addAction(cameraAction)

            // Photo Library option
            let photoLibraryAction = UIAlertAction(title: "Choose from Photo Library", style: .default) { [unowned self] _ in
                self.presentImagePicker(sourceType: .photoLibrary)
            }
            actionSheet.addAction(photoLibraryAction)

            // Cancel option
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)

            self.present(actionSheet, animated: true, completion: nil)
        }

    
    //MARK: submit type button tapped action...
    @objc func onButtonTypeSubmitTapped(){
        let url = APIConfigs.baseAPI + "user/currentOrders/\(self.uid!)"
        AF.request(url, method: .get, encoding: JSONEncoding.default)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let data = response.data {
                            do {
                                let orders = try JSONDecoder().decode([Order].self, from: data)
                                
                                // Check if the array has any orders
                                if orders.isEmpty {
                                    self.showActivateView()
                                    self.present(self.ActivateMachineNavController, animated: true)
                                } else {
                                    self.showAlert(message: "You already have an order!")
                                }
                            } catch {
                                print("Error decoding JSON: \(error)")
                                // Handle decoding error, show an alert, etc.
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                        // Handle error, show an alert, etc.
                    }
                }
        
        print("Type Button: I was clicked!")
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Order Alert", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Replace "yourViewController" with the actual view controller where you want to show the alert
        self.present(alertController, animated: true, completion: nil)
    }
}

struct Order: Codable {
    let orderId: String
    let machineName: String
    let moneyForNow: Double
    let timeForNow: Double
}
