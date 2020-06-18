//
//  PostModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 6/17/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct PostModel {
    
    //define items
    var uid:String?
    let user: UserModel
    let img_url: String
    let caption: String
    let postDate: Date
    
    //init dictionary
    init(user: UserModel, uid:String, dict:[String:Any]) {
        //assign values
        self.user = user
        self.uid = uid
        self.img_url = dict["img_path"] as? String ?? ""
        self.caption = dict["caption"] as? String ?? ""
        
        //create date
        let date = dict["createdAt"] as? Double ?? 0
        self.postDate = Date(timeIntervalSince1970: date)
    }
}
