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
        
        if Reachability.isConnectedToNetwork() {
            print("Internet detected")
            //process to network
            NetworkingServices.getData(from: url) { (data, response, error) in
                if let err = error {
                    print("Ocurrio un error con el nuevo metodo de descarga ==\(err)")
                    DispatchQueue.main.async {
                        let controller = BlockScreenController()
                        controller.modalPresentationStyle = .overFullScreen
                        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                    }
                } else {
                    
                    do {
                        //getting data
                        guard let data = data else {return}
                        
                        //serialization of data
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                        
                        DispatchQueue.main.async {
                            //getting every object from data
                            json?.forEach({ (data) in

                                //store key
                                let key = data

                                //get id key
                                guard let id = key["id"] as? String else {return}
                                
                                //creating new dictionary
                                let userData = UserModel(uid: id, dict: key as! [String:Any])
                                
                                //assign value
                                completion(userData)

                            })
                        }
                        
                    } catch let errorJSON {
                        print("Ocurrio un error al atrapar los datos ==>\(errorJSON)")
                    }
                }
            }
        } else {
            print("Internet not detected")
            DispatchQueue.main.async {
                let controller = BlockScreenController()
                controller.modalPresentationStyle = .overFullScreen
                UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
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
