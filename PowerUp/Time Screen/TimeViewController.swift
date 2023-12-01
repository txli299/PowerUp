//
//  TimeViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/2/23.
//

import UIKit
import CoreLocation
import FirebaseAuth
import Alamofire

class TimeViewController: UIViewController, CLLocationManagerDelegate {
    let timeView = TimeScreen()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var activeOrders = [OrderDto]()
    var cafes: [CafeWithDistance] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        retrieveUserActiveOrder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timeView)
        setupLocationManager()
        setupConstraints()
        retrieveUserActiveOrder()
        timeView.tableViewTime.separatorStyle = .none
        //MARK: patching the table view delegate and datasource to controller...
        timeView.tableViewTime.delegate = self
        timeView.tableViewTime.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bestCafeLabelTapped))
        timeView.bestCafeLabel.isUserInteractionEnabled = true
        timeView.bestCafeLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func bestCafeLabelTapped() {
        retrieveUserActiveOrder() // This function will present all cafes to the user
    }
    @objc func refreshTapped() {
        retrieveUserActiveOrder()
    }
    
    func retrieveUserActiveOrder(){
        if let user = FirebaseAuth.Auth.auth().currentUser {
            if let url = URL(string: "http://localhost:8080/user/currentOrders/"+user.uid){
                    AF.request(url, method: .get)
                        .responseData(completionHandler: { response in
                        //MARK: retrieving the status code...
                        let status = response.response?.statusCode
                        
                        switch response.result{
                        case .success(let data):
                            print(data)
                            //MARK: there was no network error...
                            
                            //MARK: status code is Optional, so unwrapping it...
                            if let uwStatusCode = status{
                                switch uwStatusCode{
                                    case 200...299:
                                    //MARK: the request was valid 200-level...
                                        let decoder = JSONDecoder()
                                        do{
                                            let orders = try decoder.decode([OrderDto].self, from: data)
                                            self.activeOrders = orders
                                            
                                            DispatchQueue.main.async {
                                                self.timeView.tableViewTime.reloadData()
                                                if (self.activeOrders.count>0){
                                                    self.timeView.bestCafeLabel.text = "Tap the order to deactivate."
                                                }else{
                                                    self.timeView.bestCafeLabel.text = "You do not have activate orders now."
                                                }
                                            }

                                            
                                        }catch{

                                        }
                                        break
                            
                                    case 400...499:
                                    //MARK: the request was not valid 400-level...
                                        print(data)
                                        break
                            
                                    default:
                                    //MARK: probably a 500-level error...
                                        print(data)
                                        break
                            
                                }
                            }
                            break
                            
                        case .failure(let error):
                            //MARK: there was a network error...
                            print(error)
                            break
                        }
                    })
                }
        }
    }
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func setupConstraints() {
        timeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timeView.topAnchor.constraint(equalTo: view.topAnchor),
            timeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        timeView.initConstraints()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location // Store the current location
            locationManager.stopUpdatingLocation()

            // Fetch cafes and sort them by distance
            fetchCafes { [weak self] fetchedCafes in
                guard let self = self, let fetchedCafes = fetchedCafes else {
                    return // Handle the error appropriately
                }
                
                DispatchQueue.main.async {
                    // Store all fetched cafes, sorted by distance
                    self.cafes = fetchedCafes.sorted(by: {
                        let location1 = CLLocation(latitude: $0.cafe.coordinate.latitude, longitude: $0.cafe.coordinate.longitude)
                        let location2 = CLLocation(latitude: $1.cafe.coordinate.latitude, longitude: $1.cafe.coordinate.longitude)
                        return location1.distance(from: location) < location2.distance(from: location)
                    })
                    
                    // Update the bestCafeLabel with the name of the closest cafe
                    let closestCafeName = self.cafes.first?.cafe.name ?? "Cafe"
                    self.timeView.bestCafeLabel.text = closestCafeName
                }
            }
        }
    }

    @objc func addTimeButtonPressed() {
        // ... logic to add time ...
        displayCafes()
    }
    
    func updateTimeScreenWithClosestCafe() {
        DispatchQueue.main.async {
            if let closestCafe = self.cafes.first {
                self.timeView.bestCafeLabel.text = closestCafe.cafe.name
                // Update additional labels if needed
            }
        }
    }
    func popUpWindowToDeactivate(indexPath: IndexPath){
        let alertController = UIAlertController(title: "Are you sure you want to deactivate this machine and pay?", message: "Please make your choice", preferredStyle: .alert)

                // Define the action to be taken when the user taps the 'OK' button
                let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
                    // Retrieve the input from the text field
                    
                    self.buttonTappedAt(indexPath: indexPath)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    // Handle cancel action
                    print("Cancel action selected")
                }

                // Add the confirm action to the alert controller
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
                // Present the alert controller
                present(alertController, animated: true)
    }
    
    func buttonTappedAt(indexPath: IndexPath) {
        if let user = FirebaseAuth.Auth.auth().currentUser {
            if let url = URL(string: "http://localhost:8080/machine/deactivate"){
                
                AF.request(url, method:.post, parameters:
                            [
                                "userId": user.uid,
                                "orderId": activeOrders[indexPath.row].orderId
                            ])
                .responseString(completionHandler: { response in
                    //MARK: retrieving the status code...
                    let status = response.response?.statusCode
                    
                    switch response.result{
                    case .success(let data):
                        //MARK: there was no network error...
                        
                        //MARK: status code is Optional, so unwrapping it...
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                            case 200...299:
                                //MARK: the request was valid 200-level...
                                self.retrieveUserActiveOrder()
                                break
                                
                            case 400...499:
                                //MARK: the request was not valid 400-level...
                                print(data)
                                break
                                
                            default:
                                //MARK: probably a 500-level error...
                                print(data)
                                break
                                
                            }
                        }
                        break
                        
                    case .failure(let error):
                        //MARK: there was a network error...
                        print(error)
                        break
                    }
                })
            }else{
                //alert that the URL is invalid...
            }
        }
    }
    func displayCafes() {
        let alertController = UIAlertController(title: "Choose a Cafe", message: "Select a cafe from the list.", preferredStyle: .alert)

        // Display all fetched cafes as options
        for cafeWithDistance in cafes {
            let cafeAction = UIAlertAction(title: cafeWithDistance.cafe.name, style: .default) { [weak self] _ in
                DispatchQueue.main.async {
                    // Here you can update the bestCafeLabel or any other UI elements with the selected cafe
                    self?.timeView.bestCafeLabel.text = cafeWithDistance.cafe.name
                }
            }
            alertController.addAction(cafeAction)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    // CLLocationManagerDelegate method to handle errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle the error, for example, show an alert to the user
    }
    func fetchCafes(completion: @escaping ([CafeWithDistance]?) -> Void) {
        guard let currentLocation = self.currentLocation else {
            completion(nil) // Current location is not available
            return
        }
        
        let url = URL(string: "http://localhost:8080/cafe/allCafes")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let cafes = try JSONDecoder().decode([Cafe].self, from: data)
                // Calculate the distance for each cafe and create CafeWithDistance structs
                let cafesWithDistance = cafes.map { cafe -> CafeWithDistance in
                    let cafeLocation = CLLocation(latitude: cafe.coordinate.latitude, longitude: cafe.coordinate.longitude)
                    let distance = currentLocation.distance(from: cafeLocation)
                    return CafeWithDistance(cafe: cafe, distance: distance)
                }
                // Sort cafesWithDistance by the distance
                let sortedCafes = cafesWithDistance.sorted { $0.distance < $1.distance }
                // Complete with sorted cafes
                completion(sortedCafes)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}


extension TimeViewController: UITableViewDelegate, UITableViewDataSource{
    //MARK: returns the number of rows in the current section...
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeOrders.count
    }
    
    //MARK: populate a cell for the currecnt row...
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "times", for: indexPath) as! TimeTableViewCell
        cell.labelMachine.text = "Machine: \(activeOrders[indexPath.row].machineName)"
         let uwTime = activeOrders[indexPath.row].timeForNow
            cell.labelTime.text = "Duration: \(uwTime) hours"
        let uwMoney = activeOrders[indexPath.row].moneyForNow
            cell.labelAmount.text = "Cost: $\(uwMoney)"
        //MARK: setting the image of the receipt...
        return cell
    }
    
    //MARK: deal with user interaction with a cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.popUpWindowToDeactivate(indexPath: indexPath)
    }


}

