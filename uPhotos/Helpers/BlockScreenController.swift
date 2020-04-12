//
//  BlockScreenController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 2/25/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class BlockScreenController: UIViewController {
    
    let error: UIImageView = {
        let imgIcon = UIImage(named: "test.png")
        let img = UIImageView(image: imgIcon)
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //first function in load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(error)
        error.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        error.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        error.widthAnchor.constraint(equalToConstant: 150).isActive = true
        error.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
