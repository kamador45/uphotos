//
//  NetworkingSignUp.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/5/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class NetworkingSignUp {
    
    //start services
    init() {}
    
    //Network request to server
    static func SignUp(firstname:String, lastname:String, email:String, username:String, password:String) {
        
        //Define url
        guard let url = URL(string: "\(serverURL)sign_up/") else {return}
        
        //Check if exist any data
        if firstname.isEmpty || lastname.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty {
            print("Los campos estan vacios")
        } else {
            //create request
            let request = NSMutableURLRequest(url: url)
            
            //define method
            request.httpMethod = "POST"
            
            //define body
            let body = "first_name=\(firstname)&last_name=\(lastname)&email=\(email)&username=\(username)&password=\(password)"
            request.httpBody = body.data(using: .utf8)
            
            //start services with server
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                //get data
                guard let data = data else {return}
                
                //detect any error
                if let err = error {
                    print("Oops something has been bad ==>\(err)")
                } else {
                    do {
                        
                        //cast to json
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                        
                        //access to object and create session
                        guard let parseJSON = json else {
                            print("Error parsing JSON")
                            return
                        }
                        
                        //Access to object
                        let id = parseJSON["id"] as? String
                        
                        //detect if exist any data
                        if id != nil {
                            //store value
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            currentUser = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                            
                            //pass info to global var model
                            userData = UserModel(uid: id!, dict: currentUser as! [String:Any])
                            
                            //load home screen
                            DispatchQueue.main.async {
                                appDelegates.Login()
                            }
                        } else {
                            DispatchQueue.main.async {
                                let message = parseJSON["err"] as! String
                                print("message")
                                InfoViewEvent.ShowingMessage(message: message, color: .systemRed)
                            }
                        }
                        
                        
                    } catch let errorJSON {
                        print("Oops something has been result bad ==>\(errorJSON)")
                    }
                }
            }
            
            //start services
            task.resume()
        }
    }
}
