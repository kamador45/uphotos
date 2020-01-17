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
                        guard let id = json!["id"] as? String else {return}
                        
                        //convert diccionary to model
                        let parseJSON = UserModel(uid: id, dict: json as! [String:Any])
                        
                        //detect if exist any data
                        if !(id).isEmpty {
                            print("I found this data ===>\(id)")
                            
                            //Encode objects receive data from server
                            UserDefaults.standard.set(try? PropertyListEncoder().encode(parseJSON), forKey: "parseJSON")
                            
                            //convert data to object
                            guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}
                            
                            //decode data to model
                            guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}
                            
                            //store info in global vat
                            userData = userInfo
                            
                            //Create session
                            DispatchQueue.main.async {
                                appDelegates.Login()
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
