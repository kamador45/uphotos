//
//  DownloadImage.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 9/16/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

//capture image for to create cache
var cachedImage = [String:UIImage]()

class DownloadImage: UIImageView {
    
    //last url
    var lastUrlUsed: String?
    
    //load picture on background
    func LoadImage(urlString: String) {
        
        //save last url for to pass function
        lastUrlUsed = urlString
        
        self.image = nil
        
        //detect if exist data
        if let CachedImage = cachedImage[urlString] {
            self.image = CachedImage
            return
        }
        
        //capture url format string
        guard let url = URL(string: urlString) else {return}
        
        //Start download from server :)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Oops do not can download image from server ==>\(err)")
            }
            
            if url.absoluteString != self.lastUrlUsed {
                return
            }
            
            //save data
            guard let dataImage = data else {return}
            
            //save data on image
            let image = UIImage(data: dataImage)
            
            //save on cache
            cachedImage[url.absoluteString] = image
            
            //pass the process on background
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
