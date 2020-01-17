//
//  SearchModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/7/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct SearchModel:Codable {
    
    //define objects
    let id:String
    let username:String
    let path_pic:String
    
    //init diccionary
    init(diccUsrs:[String:Any]) {
        self.id = diccUsrs["id"] as? String ?? ""
        self.username = diccUsrs["username"] as? String ?? ""
        self.path_pic = diccUsrs["path_pic"] as? String ?? ""
    }
}
