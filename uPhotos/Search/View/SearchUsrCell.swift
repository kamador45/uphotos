//
//  SearchUsrCell.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/6/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SearchUsrCell: UICollectionViewCell {
    
    var usersList:UserModel? {
        didSet {
            DispatchQueue.main.async {
                
                //gets value of model
                guard let username = self.usersList?.username else {return}
                
                //download and set profile pic
                guard let urlProfile = self.usersList?.path_pic else {return}
                let urls = NSURL(string: urlProfile)!
                let datas = try? Data(contentsOf: urls as URL)
                
                //check if exist any data
                if datas != nil {
                    DispatchQueue.main.async {
                        self.Avatar.image = UIImage(data: datas!)
                    }
                } else {
                    let img = UIImage(named: "user_avatar.png")
                    self.Avatar.image = img
                }
                
                //show info send from server
                self.UsernameLbl.text = username
            }
        }
    }
    
    
    //Create objects
    let Avatar: UIImageView = {
        let ava = UIImageView()
        ava.contentMode = .scaleAspectFill
        ava.layer.cornerRadius = 60 / 2
        ava.layer.borderWidth = 1
        ava.layer.borderColor = UIColor.lightGray.cgColor
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    let UsernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .systemGray
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    //init services
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //execute functions
        SettignsObjects()
    }
    
    //settings objects
    fileprivate func SettignsObjects() {
        
        //Add to view
        addSubview(Avatar)
        addSubview(UsernameLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            Avatar.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            Avatar.widthAnchor.constraint(equalToConstant: 60),
            Avatar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            UsernameLbl.centerYAnchor.constraint(equalTo: Avatar.centerYAnchor),
            UsernameLbl.leftAnchor.constraint(equalTo: Avatar.rightAnchor, constant: 8)
        ])
        
        //Line separator
        let separator = UIView()
        separator.backgroundColor = .systemGray //UIColor(white: 0, alpha: 0.5)
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        //Add to view
        addSubview(separator)
        
        //define constraint
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: UsernameLbl.leftAnchor),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
