//
//  UploadPicController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UploadPicController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let header_id = "header"
    
    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .gray
        
        //execute all functions
    }
    
    //Header settings
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //Settings header view
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header_id, for: indexPath)
        
        return header
    }
}
