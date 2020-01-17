//
//  PostModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 12/26/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct PostModel:Codable {
    
    //define items diccionary
    let uid:String
    let caption: String
    let img_url: String
    let createAt: Date
    
    //define diccionary
    init(uid: String, diccPost:[String:Any]) {
        self.uid = uid
        self.caption = diccPost["caption"] as? String ?? ""
        self.img_url = diccPost["img_path"] as? String ?? ""
        let secondsFrom1970 = diccPost["createAt"] as? Double ?? 0
        self.createAt = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
