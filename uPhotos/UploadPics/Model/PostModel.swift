//
//  PostModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 12/26/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    
    //define items diccionary
    let id: String
    let caption: String
    let img_path: String
    let imageWidth: Int
    let imageHeight: Int
    
    //define diccionary
    init(uid: String, dict:[String:Any]) {
        self.id = uid
        self.caption = dict["caption"] as? String ?? ""
        self.img_path = dict["img_path"] as? String ?? ""
        self.imageWidth = dict["imageWidth"] as! Int
        self.imageHeight = dict["imageHeight"] as! Int
    }
}
