//
//  Networking.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/29/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation

class NetworkingSignIn {
    
    //start services
    init() {}
    
    //Network request to sign in and create session
    static func SignIn(username:String, password:String) {
        
        //define url to use
        guard let url = URL(string: "\(serverURL)sign_in/") else {return}
        
        print(url)
        
        //Check if exist any data
        if username.isEmpty || password.isEmpty {
            let message = "Oops all fields are require"
            InfoViewEvent.ShowingMessage(message: message, color: .systemRed)
        } else {
            
            //create request
            let request = NSMutableURLRequest(url: url)
            
            //define method
            request.httpMethod = "POST"
            
            //define body
            let body = "username=\(username)&password=\(password)"
            request.httpBody = body.data(using: .utf8)
            
            //start request to server
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                //store data
                guard let data = data else {return}
                
                //detect any error
                if let err = error {
                    print("Oops something go bad ==>\(err)")
                } else {
                    do {
                        //cast to json
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                        
                        //access to object and create session
                        guard let parseJSON = json else {
                            print("Error parsing JSON")
                            return
                        }
                        
                        //Access to object to data
                        let id = parseJSON["id"] as? String
                        
                        //detect if exist some data
                        if id != nil {
                            
                            print("I found this info ==>\(id ?? "")")
                            
                            //store value
                            UserDefaults.standard.set(parseJSON, forKey: "parseJSON")
                            currentUser = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary
                            
                            //test
                            userData = UserModel(uid: id!, dict: currentUser as! [String : Any])
                            
                            //load home screen
                            DispatchQueue.main.async {
                                appDelegates.Login()
                            }
                        } else {
                            DispatchQueue.main.async {
                                let message = parseJSON["err"] as! String
                                print(message)
                                InfoViewEvent.ShowingMessage(message: message, color: .systemRed)
                            }
                        }
                    } catch let errorJSON {
                        print("Oops something go bad in parseJSON ==>\(errorJSON)")
                    }
                }
            }
            
            //create resume
            task.resume()
        }
    }
}
