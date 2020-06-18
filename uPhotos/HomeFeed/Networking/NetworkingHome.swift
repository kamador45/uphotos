//
//  NetworkingHome.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 6/18/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class NetworkingHome {
    
    //init servicies
    private init() {}
    
    static func getData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //download all post
    static func DownloadPostUsrs(uid:String, completion:@escaping(HomePostModel) -> ()) {
        
        //define url
        guard let url = URL(string: "\(serverURL)feed_posts/\(uid)") else {return}
        
        //Detect if exist internet
        if Reachability.isConnectedToNetwork() {
            print("Internet detected")
            //process to network
            NetworkingHome.getData(from: url) { (data, response, error) in
                if let err = error {
                    print("Oops something has been resulted bad to download post ===>\(err)")
                    DispatchQueue.global(qos: .background).async {
                        let controller = BlockScreenController()
                        controller.modalPresentationStyle = .overFullScreen
                        UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                    }
                } else {
                    do {
                        //getting data
                        guard let data = data else {return}
                        
                        //serialization
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                       
                        print(json)
                        
                    } catch let errorJSON {
                        print("Oops something has been resulted bad ==>\(errorJSON)")
                    }
                }
            }
        }
    }
}
