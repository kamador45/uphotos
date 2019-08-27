//
//  UserModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/26/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct UserModel {
    let id:String
    let username:String
    let first_name:String
    let last_name:String
    let complete_name:String
    let profile_url:String
    
    //define diccionary
    init?(uid:String,dict:[String:Any]) {
        guard let id =  dict["id"] as? String else {return nil}
        guard let username = dict["username"] as? String else {return nil}
        guard let first_name = dict["first_name"] as? String else {return nil}
        guard let last_name = dict["last_name"] as? String else {return nil}
        let completeName = "\(dict["first_name"] as? String ?? "")" + " " + "\(dict["last_name"] as? String ?? "")"
        
        guard let profile_url = dict["profile_url"] as? String else {return nil}
        
        //Assign values to main var
        self.id = id
        self.username = username
        self.first_name = first_name
        self.last_name = last_name
        self.complete_name = completeName
        self.profile_url = profile_url
    }
}
