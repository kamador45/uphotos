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
    let id:String?
    let id_user:String
    let caption: String
    let img_url: String
    let createAt: Date
    
    //define diccionary
    init(uid: String ,dictPost:[String:Any]) {
        //gets value from dictionary
        self.id_user = uid
        self.id = dictPost["id"] as? String ?? ""
        self.img_url = dictPost["img_path"] as? String ?? ""
        self.caption = dictPost["caption"] as? String ?? ""
        let secondsFrom1970 = dictPost["createdAt"] as? Double ?? 0
        self.createAt = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
