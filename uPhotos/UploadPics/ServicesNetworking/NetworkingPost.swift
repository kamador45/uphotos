//
//  NetworkingPost.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/31/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class NetworkingPost {
    
    //Init Services
    private init() {}
    
    //Try to create a post
    static func PruebaPost(uid:String,text:String, postImg:UIImage, imageWidth:CGFloat, imageHeight:CGFloat) {
    }
    
    // custom body of HTTP request to upload image file
    static func createBodyWithParams(parameters: [String: Any]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendStrings(string: "--\(boundary)\r\n")
                body.appendStrings(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendStrings(string: "\(value)\r\n")
            }
        }
        
        let name = NSUUID().uuidString
        let filename = "\(name).jpg"
        
        let mimetype = "image/jpg"
        
        body.appendStrings(string: "--\(boundary)\r\n")
        body.appendStrings(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendStrings(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendStrings(string: "\r\n")
        
        body.appendStrings(string: "--\(boundary)--\r\n")
        
        return body
        
    }
}

