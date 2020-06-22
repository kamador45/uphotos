//
//  HomeCell.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 3/15/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class HomeCell: UICollectionViewCell, UIScrollViewDelegate {
    //user avatar
    let Avatar: UIImageView = {
        let ava = UIImageView()
        ava.contentMode = .scaleAspectFill
        ava.layer.cornerRadius = 7
        ava.layer.borderWidth = 1
        ava.layer.borderColor = UIColor.lightGray.cgColor
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.layer.cornerRadius = 60 / 2
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    //Posted image
    lazy var PostedImage: UIImageView = {
        let im = UIImage(named: "jupiter.jpg")
        let img = UIImageView(image: im)
//        img.backgroundColor = .red
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.isUserInteractionEnabled = true
//        img.backgroundColor = .purple
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    //username
    let UsernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.layer.zPosition = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "@kamador94"
        return lbl
    }()
    
    //date
    let DateLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1 week ago"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .lightGray
        lbl.layer.zPosition = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //options button
    lazy var OptionsBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("•••", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 30)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //footer items
    lazy var likeBtn: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "un_heart.png")
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    lazy var CommentsBtn: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "comments.png")
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    lazy var ShareBtn: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "share.png")
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    //create caption
    let CaptionPost: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.backgroundColor = .white
        tv.font = UIFont.boldSystemFont(ofSize: 17)
        tv.textAlignment = .justified
        tv.textColor = .black
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //container
    let ContainerView:UIView = {
        let vw = UIView()
        vw.layer.cornerRadius = 8
        vw.layer.shadowOpacity = 1
        vw.layer.shadowRadius = 5
        vw.layer.shadowOffset = .zero
        vw.layer.shadowColor = UIColor.lightGray.cgColor
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    //Global var using HomePostModel
    var HomePost:HomePostModel? {
        didSet {
            DispatchQueue.main.async {
                
                //gets url img
                guard let pic_url_post = self.HomePost?.img_url else {return}
                let urls = NSURL(string: pic_url_post)!
                let datas = try? Data(contentsOf: urls as URL)
                
                //check if exist any data
                if datas != nil {
                    DispatchQueue.main.async {
                        self.PostedImage.image = UIImage(data: datas!)
                    }
                }
                
                //profile image
                guard let pp_url = userData?.path_pic else {return} //self.HomePost?.users.path_pic else {return}
                let url_pp = NSURL(string: pp_url)!
                let data = try? Data(contentsOf: url_pp as URL)
                
                //Detect if exist data
                if data != nil {
                    DispatchQueue.main.async {
                        self.Avatar.image = UIImage(data: data!)
                    }
                }
                
                //passing username to view
                self.UsernameLbl.text = self.HomePost?.users.username
                
                //output
                let date_post = self.HomePost?.createAt.TimeAgoDisplay()
                self.DateLbl.text = date_post
                self.DateLbl.sizeToFit()
                
                //caption
                self.CaptionPost.text = self.HomePost?.caption
            }
        }
    }

    
    
    //init cell view
    override init(frame: CGRect) {
        super.init(frame: frame)
        //load and execute all function
        SettingObjects()
        SetupReactButton()
        SetupCommentBlock()
    }
    
    
    //Setup objects
    fileprivate func SettingObjects() {
        
        //add views
        addSubview(ContainerView)
        
        ContainerView.backgroundColor = .white
        
        //defining constraint
        NSLayoutConstraint.activate([
            ContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            ContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            ContainerView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            ContainerView.heightAnchor.constraint(equalToConstant: self.frame.height - 25)
        ])
        
        //Add avatar to container
        ContainerView.addSubview(Avatar)
        
        //defining constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: ContainerView.topAnchor, constant: 10),
            Avatar.leftAnchor.constraint(equalTo: ContainerView.leftAnchor, constant: 10),
            Avatar.widthAnchor.constraint(equalToConstant: 60),
            Avatar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //Add username tag to container
        ContainerView.addSubview(UsernameLbl)
        
        //defining constraint
        NSLayoutConstraint.activate([
            UsernameLbl.topAnchor.constraint(equalTo: Avatar.topAnchor, constant: 10),
            UsernameLbl.leftAnchor.constraint(equalTo: Avatar.rightAnchor, constant: 10)
        ])
        
        //Add date tag to container
        ContainerView.addSubview(DateLbl)
        
        //definig constraint
        NSLayoutConstraint.activate([
            DateLbl.topAnchor.constraint(equalTo: UsernameLbl.bottomAnchor, constant: 3),
            DateLbl.leftAnchor.constraint(equalTo: Avatar.rightAnchor, constant: 10)
        ])
        
        //Add options button tag to container
        ContainerView.addSubview(OptionsBtn)
        
        //defining constraint
        NSLayoutConstraint.activate([
            OptionsBtn.topAnchor.constraint(equalTo: ContainerView.topAnchor, constant: 10),
            OptionsBtn.rightAnchor.constraint(equalTo: ContainerView.rightAnchor, constant: -20),
        ])
        
        //Add Post ImageView
        ContainerView.addSubview(PostedImage)
        
        //defining constraint
        NSLayoutConstraint.activate([
            PostedImage.topAnchor.constraint(equalTo: DateLbl.bottomAnchor, constant: 20),
            PostedImage.leftAnchor.constraint(equalTo: ContainerView.leftAnchor),
            PostedImage.rightAnchor.constraint(equalTo: ContainerView.rightAnchor),
            PostedImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
    
    //Setup reaction buttons
    fileprivate func SetupReactButton() {
        
        //create stackview
        let stackview = UIStackView(arrangedSubviews: [likeBtn,CommentsBtn,ShareBtn])
        
        //config stackview
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        //Add to container view
        ContainerView.addSubview(stackview)
        
        //defining constraint
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: PostedImage.bottomAnchor, constant: 5),
            stackview.leftAnchor.constraint(equalTo: ContainerView.leftAnchor),
            stackview.heightAnchor.constraint(equalToConstant: 30),
            stackview.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    //Setup comment block
    fileprivate func SetupCommentBlock() {
        //Add to container
        ContainerView.addSubview(CaptionPost)
        
        //defining constraint
        NSLayoutConstraint.activate([
            CaptionPost.topAnchor.constraint(equalTo: likeBtn.bottomAnchor, constant: 5),
            CaptionPost.leftAnchor.constraint(equalTo: ContainerView.leftAnchor),
            CaptionPost.rightAnchor.constraint(equalTo: ContainerView.rightAnchor),
            CaptionPost.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    //setup UI when light it's enable
    func AdaptCellToLight() {
        //define new colors
        Avatar.layer.borderColor = UIColor.black.cgColor
        UsernameLbl.textColor = .black
        DateLbl.textColor = .lightGray
        OptionsBtn.titleLabel?.textColor = .black
        CaptionPost.textColor = .black
        likeBtn.tintColor = .black
        CommentsBtn.tintColor = .black
        ShareBtn.tintColor = .black
    }
    
    //setup UI when dark it's enable
    func AdaptCellToDark() {
        //define new colors
        Avatar.layer.borderColor = UIColor.white.cgColor
        UsernameLbl.textColor = .white
        DateLbl.textColor = .lightGray
        CaptionPost.textColor = .white
        CaptionPost.backgroundColor = .black
        ContainerView.backgroundColor = .black
        likeBtn.tintColor = .white
        CommentsBtn.tintColor = .white
        ShareBtn.tintColor = .white
    }
    
    //manage error event
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
