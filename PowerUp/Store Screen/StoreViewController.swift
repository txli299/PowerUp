//
//  StoreViewController.swift
//  PowerUp
//
//  Created by Cliff Li on 10/1/23.
//

import UIKit
import CoreLocation

class StoreViewController: UIViewController, CLLocationManagerDelegate {
    let storeScreen = StoreScreen()
    let locationManager = CLLocationManager()
    var currentAddress: String?
    var currentLocation: CLLocation? // To store the current user location
    var cafes: [CafeWithDistance] = [] // Use CafeWithDistance instead of Cafe

    
    override func loadView() {
        view = storeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        storeScreen.buttonLocation.addTarget(self, action: #selector(buttonLocationPressed), for: .touchUpInside)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // Start location updates here
    }


    @objc func buttonLocationPressed() {
        // Fetch and display cafes when the button is pressed
        fetchCafes { [weak self] fetchedCafes in
            guard let self = self, let fetchedCafes = fetchedCafes else {
                // Handle error: could not fetch cafes
                return
            }
            
            // Update the cafes array with the fetched cafes
            self.cafes = fetchedCafes
            
            DispatchQueue.main.async {
                self.displayCafes() // Display an alert with the cafes
            }
        }
    }
    
    func displayCafes() {
        let alertController = UIAlertController(title: "Choose a Cafe", message: "Cafe's are shown in order of closest distance to the user.", preferredStyle: .alert)

        // Get the two closest cafes, but check if there are any cafes at all
        let closestCafes = cafes.prefix(2)
        guard let closestCafe = closestCafes.first else { return } // Ensure there's at least one cafe

        for cafeWithDistance in cafes.prefix(2) {
            
            let cafeAction = UIAlertAction(title: cafeWithDistance.cafe.name, style: .default) { [weak self] _ in
                DispatchQueue.main.async {
                    // Update the location button with the cafe name
                    self?.storeScreen.buttonLocation.setTitle(cafeWithDistance.cafe.name, for: .normal)
                    
                    // Update the availability labels with the count of machines
                    let pcCount = cafeWithDistance.cafe.machines.filter { $0.type == "PC" && !$0.activated }.count
                    let psCount = cafeWithDistance.cafe.machines.filter { $0.type == "PS" && !$0.activated }.count
                    let totalPCs = cafeWithDistance.cafe.machines.filter { $0.type == "PC" }.count
                    let totalPSs = cafeWithDistance.cafe.machines.filter { $0.type == "PS" }.count
                    
                    // Assuming all machines start activated, the available count is the total minus the activated count
                    self?.storeScreen.labelPCAvailability.text = "\(totalPCs - pcCount)/\(totalPCs)"
                    self?.storeScreen.labelPSAvailability.text = "\(totalPSs - psCount)/\(totalPSs)"
                }
            }
            alertController.addAction(cafeAction)
        }


        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // Present the alert
        present(alertController, animated: true, completion: nil)
    }

    // Location Manager Delegate Methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location // Store the current location
            locationManager.stopUpdatingLocation()

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                if let placemark = placemarks?.first, let address = placemark.compactAddress {
                    DispatchQueue.main.async {
                        self?.storeScreen.buttonLocation.setTitle(address, for: .normal)
                    }
                }
            }

            // Fetch cafes and sort them by distance right after getting the user location
            fetchCafes { [weak self] fetchedCafes in
                guard let self = self, let fetchedCafes = fetchedCafes, let currentLocation = self.currentLocation else {
                    return // Handle the error appropriately
                }
                
                self.cafes = fetchedCafes.sorted(by: {
                    let location1 = CLLocation(latitude: $0.cafe.coordinate.latitude, longitude: $0.cafe.coordinate.longitude)
                    let location2 = CLLocation(latitude: $1.cafe.coordinate.latitude, longitude: $1.cafe.coordinate.longitude)
                    return location1.distance(from: currentLocation) < location2.distance(from: currentLocation)
                }).prefix(2).map { $0 } // This will give you an array of CafeWithDistance
            }
        }
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
extension CLPlacemark {
    var compactAddress: String? {
        // Initialize an empty array to hold the address parts
        var parts: [String] = []

        // If the 'name' component exists and it is not already included in the 'parts' array,
        // add it to the 'parts' array.
        if let name = name, !parts.contains(where: { name.contains($0) }) {
            parts.append(name)
        }

        // If the 'thoroughfare' (street name) component exists and it is not a substring of any element
        // already in the 'parts' array, add it to the 'parts' array.
        if let street = thoroughfare, !parts.contains(where: { street.contains($0) }) {
            parts.append(street)
        }

        // If the 'locality' (city name) component exists and it is not a substring of any element
        // already in the 'parts' array, add it to the 'parts' array.
        if let city = locality, !parts.contains(where: { city.contains($0) }) {
            parts.append(city)
        }

        // If the 'country' component exists and it is not a substring of any element
        // already in the 'parts' array, add it to the 'parts' array.
        if let country = country, !parts.contains(where: { country.contains($0) }) {
            parts.append(country)
        }

        // Join the address parts array into a single string, separated by commas,
        // and return it as the compact address representation.
        return parts.joined(separator: ", ")
    }
}

