//
//  NetworkingSearch.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/7/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation

class NetworkingSearch {
    
    //init services
    private init() {}
    
    //Network services
    static func getPosts(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //Networking services
    static func ListAllUsers(completion:@escaping(SearchModel) -> ()) {
        //define url
        guard let url = URL(string: "\(serverURL)list_users/") else {return}
        
        print("Estoy solicitando esta url ===>\(url)")
        
        //network request
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
        
            guard let data = data else {return}
            
            if let err = error {
                print("Ooops ==>\(err)")
            } else {
                
                do {
                    //serialization data
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {return}
                    
                    //define keys of objects
                    let results = json.value(forKey: "results") as! [AnyObject]
                    
                    //detect if exist any data
                    if !(results).isEmpty {
                        //Loop to objects send from server
                        for x in results {
                            
                            //Access to info and insert to model
                            let newDicc = SearchModel(diccUsrs: x as! [String:Any])
                            
                            //assign value to global var
                            listUsers = newDicc
                        }
                    }
                    
                } catch let errorJSON {
                    print("Oops error JSON ===>\(errorJSON)")
                }
            }
        }
        
        task.resume()
    }
}
