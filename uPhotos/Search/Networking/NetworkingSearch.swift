//
//  NetworkingSearch.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/7/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation

class NetworkingSearch {
    
    //Init services
    private init() {}
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
