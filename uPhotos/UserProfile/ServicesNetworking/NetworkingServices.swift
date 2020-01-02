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
    
    //Init services
    private init() {}
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //download all new info of user
    static func DownloadMainInfoUsr(uid:String, completion:@escaping(UserModel) -> ()) {
        
        //Define the url
        guard let url = URL(string: "\(serverURL)find/\(uid)") else {return}
        
        //process to network
        NetworkingServices.getData(from: url) { (data, response, error) in
            if let err = error {
                print("Ocurrio un error con el nuevo metodo de descarga ==\(err)")
            } else {
                do {
                    
                    guard let data = data else {return}
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    
                    guard let idUsr = json!["id"] as? String else {return}

                    if !(idUsr).isEmpty {
                        let newDictionary = UserModel(uid: idUsr, dict: json as! [String : Any])


                        //encode objects receive from server
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(newDictionary), forKey: "parseJSON")

                        //convert data to object
                        guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}

                        //decode and insert all data in model
                        guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}

                        //Store all info in global var
                        userData = userInfo
                    }
                    
                } catch let errorJSON {
                    print("Ocurrio un error al atrapar los datos ==>\(errorJSON)")
                }
            }
        }
    }
    
    //capture and prepare info to update
    static func UpdateInfoUsr(username:String, first_name:String, last_name:String, bio:String) {
        
        //capture uid user on session
        guard let id = userData?.id else {return}
        
        //prepare url
        guard let url = URL(string: "\(serverURL)update_info/\(id)") else {return}
        
        //prepare request url
        let request = NSMutableURLRequest(url: url)
        
        //define method
        request.httpMethod = "PATCH"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        //define body
        let body = "first_name=\(first_name)&last_name=\(last_name)&username=\(username)&bio=\(bio)"
        request.httpBody = body.data(using: .utf8)
        
        //Network process
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            print(request)
            if let err = error {
                print("Oops something had result bad ==>\(err)")
            } else {
                do {
                    guard let data = data else {return}
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    print(json)
                } catch let errorJSON {
                    print("Error JSON ==>\(errorJSON)")
                }
            }
        }.resume()
    }
}
