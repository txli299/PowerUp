//
//  CheckOutViewController.swift
//  PowerUp
//
//  Created by Jefferson Cuartas on 11/13/23.
//

import UIKit

class CheckOutViewController: UIViewController {
    
    let checkoutScreen = CheckOutView()
    
    let amounts = ["10", "15", "20", "25"]
    
//    var delegate: WalletViewController!
    
    var selectedAmount = "10"
    
    override func loadView() {
            view = checkoutScreen
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: patching delegate and datasource of the type PickerView...
        checkoutScreen.pickerType.dataSource = self
        checkoutScreen.pickerType.delegate = self
        
//        walletView.stripePayButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
        checkoutScreen.addButton.addTarget(self, action: #selector(checkOut), for: .touchUpInside)

    }
    
    @objc func checkOut(){
        let paymentController = PaymentViewController()
        paymentController.delegate = self
        paymentController.updateAddAmount()
        navigationController?.pushViewController(paymentController, animated: true)
        
    }
}

//MARK: adopting the required protocols...
extension CheckOutViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //MARK: we are using only one section...
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //MARK: we are displaying the options from Utilities.types...
        return amounts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //MARK: updating the selected type when the user picks this row...
        selectedAmount = amounts[row]
        return amounts[row]
    }
}
