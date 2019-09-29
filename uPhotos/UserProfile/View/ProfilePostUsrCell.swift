//
//  PostPicsCell.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/26/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class ProfilePostUsrCell: UICollectionViewCell {
    
    //init cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        
//        if #available(iOS 12, *) {
//            if traitCollection.userInterfaceStyle == .light {
//                print("Light detected")
//                backgroundColor = .systemGray
//            } else {
//                print("Dark detected")
//                backgroundColor = .systemPink
//            }
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
