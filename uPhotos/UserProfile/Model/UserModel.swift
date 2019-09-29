//
//  UserModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/26/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct UserModel:Codable {
    
    let id:String
    let username:String
    let first_name:String
    let last_name:String
    let path_pic:String
    let path_portrait:String
    let filename_pic:String
    let filename_portrait:String
    let bio:String
    let status:String
    
    //define the diccionary
    init(uid: String, dict:[String:Any]) {
        
        self.id = uid
        self.username = dict["username"] as? String ?? ""
        self.first_name = dict["first_name"] as? String ?? ""
        self.last_name = dict["last_name"] as? String ?? ""
        self.path_pic = dict["path_pic"] as? String ?? ""
        self.path_portrait = dict["path_portrait"] as? String ?? ""
        self.filename_pic = dict["filename"] as? String ?? ""
        self.filename_portrait = dict["filename_portrait"] as? String ?? ""
        self.bio = dict["bio"] as? String ?? ""
        self.status = dict["status"] as? String ?? ""
    }
}
