//
//  TimeViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/2/23.
//

import UIKit
import CoreLocation

class TimeViewController: UIViewController, CLLocationManagerDelegate {
    let timeView = TimeScreen()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var cafes: [CafeWithDistance] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(timeView)
        setupLocationManager()
        setupConstraints()
        
        // Add a tap gesture recognizer to the bestCafeLabel
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(bestCafeLabelTapped))
        timeView.bestCafeLabel.isUserInteractionEnabled = true
        timeView.bestCafeLabel.addGestureRecognizer(tapGesture)
    }
    @objc func bestCafeLabelTapped() {
        displayCafes() // This function will present all cafes to the user
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


