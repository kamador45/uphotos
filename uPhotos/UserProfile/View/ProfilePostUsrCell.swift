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
    
    //ImageView to load pic selected
    let PhotoView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //define background
        backgroundColor = .systemPink
        
        //execute function
        SetupImageView()
    }
    
    var PostData:PostModel? {
        didSet {
            DispatchQueue.main.async {
                
                //download and set pics posted
                guard let pic_url_post = self.PostData?.img_url else {return}
                let urls = NSURL(string: pic_url_post)!
                let datas = try? Data(contentsOf: urls as URL)
                
                //check if exist any data
                if datas != nil {
                    DispatchQueue.main.async {
                        self.PhotoView.image = UIImage(data: datas!)
                    }
                }
            }
        }
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
