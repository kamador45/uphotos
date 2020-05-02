//
//  HomePostModel.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 5/2/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct HomePostModel:Codable {
    
    //define items
    let id:String?
    let id_user:String
    let caption:String
    let img_url: String
    let createAt: Date
    
    //defining dicctionary
    init(uid:String, dictPost:[String:Any]) {
        //Store values
        self.id_user = uid
        self.id = dictPost["id"] as? String ?? ""
        self.img_url = dictPost["img_path"] as? String ?? ""
        self.caption = dictPost["caption"] as? String ?? ""
        let secondsFrom1970 = dictPost["createAt"] as? Double ?? 0
        self.createAt = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
