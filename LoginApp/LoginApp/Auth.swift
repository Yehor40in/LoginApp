//
//  Auth.swift
//  LoginApp
//
//  Created by Yehor Sorokin on 21.01.2021.
//

import Foundation


struct User {
    var firstName: String
    var secondName: String
    var email: String
}


final class Auth {

    static var shared: Auth = Auth()
    static var user: User?
    static var isAuthenticated: Bool {
        guard let _ = Auth.user else {
            return false
        }
        return true
    }
    
    weak var delegate: AuthDelegate?
    
    func tryAuthenticate(using credentials: [String:String]) -> Void {
        
        let json_to_send = try? JSONSerialization.data(withJSONObject: credentials, options: .prettyPrinted)

        var request = URLRequest(url: Config.loginURL)
        request.httpMethod = "POST"
        request.httpBody = json_to_send
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            if let data = data {
                do {
                    if let json_recieved = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let user = json_recieved["user"] as? [String: Any] {
                            guard
                                let fName = user["first_name"] as? String,
                                let lName = user["last_name"] as? String,
                                let email = user["email"] as? String
                            else {
                                return
                            }
                            Auth.user = User(firstName: fName, secondName: lName, email: email)
                            UserDefaults.standard.setValue(json_recieved["access_token"]!, forKey: Config.tokenKey)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            DispatchQueue.main.async {
                self?.delegate?.didTryAuthenticate()
            }
        })
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
    
}


protocol AuthDelegate: class {
    func didTryAuthenticate() -> Void
}
