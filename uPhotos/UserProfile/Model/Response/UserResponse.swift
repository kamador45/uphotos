//
//  UserResponse.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/26/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation

struct UserResponse {
    
    let userData:[UserModel]
    
    init?(json:Any) {
        guard let array = json as? [[String:Any]] else { return nil }
        
        var infoUser = [UserModel]()
        
        for item in array {
            guard let info = UserModel(dict: item) else { continue }
            infoUser.append(info)
        }
        
        self.userData = infoUser
    }
}
