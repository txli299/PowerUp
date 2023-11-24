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
        if let pickedImage = info[.originalImage] as? UIImage {
        }

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
    @objc func onButtonScanSubmitTapped(){
        presentImagePicker(sourceType: .camera)
        print("Scan Button: I was clicked!")
    }
    
    //MARK: submit type button tapped action...
    @objc func onButtonTypeSubmitTapped(){
        showActivateView()
        present(ActivateMachineNavController, animated: true)
        print("Type Button: I was clicked!")
    }
    
}
