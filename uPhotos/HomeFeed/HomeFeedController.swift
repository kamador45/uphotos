//
//  HomeFeedController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class HomeFeedController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor =  .darkGray
    }
    
    //Show large title
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Home Feed"
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
