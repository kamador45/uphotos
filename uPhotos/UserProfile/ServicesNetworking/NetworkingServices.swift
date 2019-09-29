//
//  NetworkingServices.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 9/16/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class NetworkingServices {
    
    private init() {}
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    static func FetchDataUsr() {
        //send request for new data
        guard let id = userData?.id else {return}
        guard let url = URL(string: "http://192.168.0.11:1337/find/\(id)") else {return}
        
        //call networking services
        NetworkingServices.getData(from: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                guard let idUser = json!["id"] as? String else {return}
                
                let parseJSON = UserModel(uid: idUser, dict: json as! [String : Any])
                
                if !(id).isEmpty {
                    DispatchQueue.main.async {
                        
                        print(parseJSON)
                        
                        //encode objects receive from server
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(parseJSON), forKey: "parseJSON")
                        
                        //convert data to object
                        guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}
                        
                        //decode and insert all data in model
                        guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}
                        
                        //Store all info in global var
                        userData = userInfo
                        
                    }
                }
                
            } catch let errorJSON {
                print("Oops something go wrong ==>\(errorJSON)")
            }
            
        }
    }
}
