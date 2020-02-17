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
            print("Los campos estan vacios")
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
                        let id = parseJSON["id"]
                        
                        //detect if exist some data
                        if id != nil {
                            print("I found this info ==>\(id)")
                            
                            let newDic = UserModel(uid: id as! String, dict: parseJSON as! [String : Any])
                            
                            //Update info store in device
                            UserDefaults.standard.set(try? PropertyListEncoder().encode(newDic), forKey: "parseJSON")
                            
                            //convert all data in object
                            guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}
                            
                            //insert and decode all object in model
                            guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}
                            
                            //Store new info
                            userData = userInfo
                            
                            //create session
                            DispatchQueue.main.async {
                                appDelegates.Login()
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
