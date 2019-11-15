//
//  CellPics.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/29/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class CellPics: UICollectionViewCell {
    
    //ImageView to load pic selected
    let PhotoView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        
        //execute function
        SetupImageView()
    }
    
    //Add ImageView and setup
    fileprivate func SetupImageView() {
        addSubview(PhotoView)
        
        //define constraint
        NSLayoutConstraint.activate([
            PhotoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            PhotoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            PhotoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            PhotoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
