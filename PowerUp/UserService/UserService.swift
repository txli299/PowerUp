//
//  UserService.swift
//  PowerUp
//
//  Created by Hank Gu on 11/13/23.
//

import Foundation

class UserService {
    
    static let baseURL = "http://localhost:8080" // Replace with the actual base URL of your backend

    static func createUserJSON(uid: String, email: String, credit: Int = 0) -> [String: Any] {
        return [
            "uid": uid,
            "email": email,
            "credit": credit
        ]
    }
    
    static func getUserDetails(uid: String, completion: @escaping (User?, Error?) -> Void){
        guard let url = URL(string: "\(baseURL)/user/\(uid)") else {
            completion(nil, NSError(domain: "HTTPResponseError", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                //closure completion error is at the outermost if/else
                if let error = error {
                    print("HTTP Request Failed \(error)")
                    completion(nil, error)
                } else if let data = data {
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        print(user)
                        completion(user, nil)
                    } catch {
                        print("JSON Decoding Failed \(error)")
                        completion(nil, error)
                    }
                } else {
                    print("Invalid response")
                    completion(nil, NSError(domain: "InvalidResponseError", code: 0, userInfo: nil))
                }
            }

        task.resume()
        
    }
    
    static func updateUserDetails(uid: String, userDetails: [String: Any], completion: @escaping (Bool, Error?) -> Void){
        
        //set up url
        guard let url = URL(string: "\(baseURL)/user/\(uid)") else {
            completion(false, NSError(domain: "URLCreationError", code: 0, userInfo: nil))
            return
        }
        //set up request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //set up json body
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userDetails, options: [])
            request.httpBody = jsonData

        } catch {
            completion(false, error)
            return
        }
        
        //send request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true, nil)
            } else {
                completion(false, NSError(domain: "HTTPResponseError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil))
            }
        }
        
        task.resume()
    }
    
    static func postUserDetails(userDetails: [String: Any], completion: @escaping (Bool, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/user/addUser") else { // Updated endpoint
            completion(false, NSError(domain: "URLCreationError", code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userDetails, options: [])
            request.httpBody = jsonData
        } catch {
            completion(false, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error)
            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(true, nil)
            } else {
                completion(false, NSError(domain: "HTTPResponseError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil))
            }
        }
        
        task.resume()
    }
    
}
