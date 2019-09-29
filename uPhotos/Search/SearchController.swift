//
//  SearchController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SearchController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            
            navigationItem.title = "Search Users"
        }
    }
}
