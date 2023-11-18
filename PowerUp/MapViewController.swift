//
//  MapViewController.swift
//  PowerUp
//
//  Created by Nicholas Letarte on 10/20/23.
//
// https://www.youtube.com/watch?v=f6xN2MuHv1s

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    let manager = CLLocationManager()
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set initial location for Portland, ME
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first{
//            manager.stopUpdatingLocation()
//
//            render(location)
//        }
//    }
    //    func render(_ location: CLLocation) {
    //
    //        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
    //                                                longitude: location.coordinate.longitude)
    //        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    //
    //        let region = MKCoordinateRegion(center: coordinate,
    //                                        span: span)
    //
    //        mapView.setRegion(region,
    //                          animated: true)
    //      let pin = MKPointAnnotation()
    //        pin.coordinate = coordinate
    //        mapView.addAnnotation(pin)
    //    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()

            // Fetch the nearest cafes using the location
            fetchNearestCafes(from: location) { [weak self] cafes in
                // Ensure we have cafes to render
                guard let cafes = cafes else { return }

                // Call the render function with the user's location and the nearest cafes
                DispatchQueue.main.async {
                    self?.render(location, withNearestCafes: cafes)
                }
            }
        }
    }
    func fetchAllCafes(completion: @escaping ([Cafe]?) -> Void) {
        let url = URL(string: "http://localhost:8080/cafe/allCafes")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let cafes = try decoder.decode([Cafe].self, from: data)
                completion(cafes)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
    // This function will handle the communication with your backend to get the nearest cafes
    func fetchNearestCafes(from location: CLLocation, completion: @escaping ([Cafe]?) -> Void) {
        // Here you would create the URLRequest, configure it for a POST request,
        // send the user's current location coordinates, and parse the response
        // to create an array of Cafe objects which you would pass to the completion handler.

        // This is a placeholder for the actual network request and JSON parsing.
        // You would replace this with your actual networking code.
        completion(nil) // Call the completion handler with nil for now
    }
    func render(_ location: CLLocation, withNearestCafes cafes: [Cafe]) {
        let userCoordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                    longitude: location.coordinate.longitude)
        
        var region = MKCoordinateRegion(center: userCoordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        // Add a pin for the user's location
        let userPin = MKPointAnnotation()
        userPin.coordinate = userCoordinate
        userPin.title = "Your Location"
        mapView.addAnnotation(userPin)
        
        // Add pins for each cafe
        for cafe in cafes {
            let cafePin = MKPointAnnotation()
            cafePin.coordinate = CLLocationCoordinate2D(latitude: cafe.coordinate.latitude,
                                                        longitude: cafe.coordinate.longitude)
            cafePin.title = cafe.name
            mapView.addAnnotation(cafePin)
        }
        
        // Adjust the region to include all pins
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    
}


