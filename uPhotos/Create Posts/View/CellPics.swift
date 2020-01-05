//
//  CellPics.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/4/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class CellPics: UICollectionViewCell {
    
    //ImageView to load pics send from iphone
    let PhotoView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //Start objects
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Add to view
        addSubview(PhotoView)
        
        //define constraint
        NSLayoutConstraint.activate([
            PhotoView.topAnchor.constraint(equalTo: topAnchor),
            PhotoView.leftAnchor.constraint(equalTo: leftAnchor),
            PhotoView.rightAnchor.constraint(equalTo: rightAnchor),
            PhotoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
