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
