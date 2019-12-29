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
    
    //Network services
    static func getPosts(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //Network request to create post
    static func CreatePostNetwork(uid:String,Caption:String,PostImg:UIImage,ImageWidth:Int, ImageHeight:Int, created: TimeInterval) {
        
        //Prepare url to server
        guard let url = URL(string: "\(serverURL)post/\(uid)") else {return}
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        

        let boundary = "Boundary-\(NSUUID().uuidString)"
        let imageData = PostImg.jpegData(compressionQuality: 0.5)

        //detect if is nil
        if imageData == nil {
            return
        }
        
        //settings value in multipart form data
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        //Define params
        let params = [
            "id":uid,
            "caption":Caption,
            "imageWidth":ImageWidth,
            "imageHeight":ImageHeight,
            "createdAt":created
        ] as [String:Any]
        
        print("Encontre esto ===> \(params)")
        
        //Prepare body
        request.httpBody = createBodyWithParams(parameters: params, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        //Network process
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            //detect any error
            if let err = error {
                print("Oops something has beed result bad ==>\(err)")
            } else {
                
                //gets data
                guard let data = data else {return}
                
                //do proccess
                do {
                    //create serialization
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                    
                    //cast object to string
                    guard let details = json["PostDetails"] as? String else {return}
                    
                    //detect if exist any data
                    if !(details).isEmpty {
                        print("data download ==>\(details)")
                    }
                } catch let errorJSON {
                    print("Oops something has been result bad in json ==>\(errorJSON)")
                }
            }
        }.resume()
    }
    
    //Download all post made by user.
    static func DownloadPostByUsr(uid:String, completion:@escaping(PostModel) -> ()) {
        
        //define url
        guard let url = URL(string: "\(serverURL)find_posts/\(uid)") else {return}
        
        print("estoy enviando esta url ==>\(url)")
        
        //Network request
        NetworkingPost.getPosts(from: url as URL) { (data, response, error) in
            
            //Detect any error
            if let err = error {
                print("Oops something has been bad ==>\(err)")
            } else {
                
                do {
                    
                    //get data
                    guard let data = data else {return}
                    
                    //show all data downloaded
                    print("Encontre estos datos ==>\(data)")
                    
                    //define json serializer
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                    
                    print("json objects ==>\(json)")
                    
                } catch let errorJSON {
                    print("Oops something in JSON convert has been bad ==>\(errorJSON)")
                }
            }
        }
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

