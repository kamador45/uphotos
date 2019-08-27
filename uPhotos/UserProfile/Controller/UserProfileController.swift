//
//  UserProfileController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit


class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //header id
    let header_id = "header"
    let celdaId = "CeldaId"
    
    //First function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define background
        collectionView.backgroundColor = .white
        
        //settings navbar title
        navigationItem.title = "μPhotos"
        
        //register view on controller
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header_id)
        
        //register cell
        collectionView.register(PostPicsCell.self, forCellWithReuseIdentifier: celdaId)
    }
    
    //Header settings
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //Settings header view
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header_id, for: indexPath) as! UserProfileHeader
        
        return header
    }
    
    //define number of cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //define to size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with = (view.frame.width - 2) / 2
        return CGSize(width: with, height: with)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //re use the post pic cell
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: celdaId, for: indexPath) as! PostPicsCell
        
        return celda
    }
    
    //define size header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.height, height: 500)
    }
}
