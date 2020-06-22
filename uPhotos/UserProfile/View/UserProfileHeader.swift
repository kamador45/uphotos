//
//  UserProfileHeader.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UserProfileHeader: UICollectionViewCell, UIImagePickerControllerDelegate {
    
    //define guest user id
    var guestId:String?
    
    //Show data in view
    var userInfoProfile: UserModel? {
        didSet {
            DispatchQueue.main.async {
                
                //download and set profile pic
                guard let urlProfile = self.userInfoProfile?.path_pic else {return}
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
                
                //download and set portrait pic
                guard let urlPortrait = self.userInfoProfile?.path_portrait else {return}
                let urls_portraits = NSURL(string: urlPortrait)!
                let data_portrait = try? Data(contentsOf: urls_portraits as URL)
                
                //check if exist some data
                if data_portrait != nil {
                    DispatchQueue.main.async {
                        self.Portrait.image = UIImage(data: data_portrait!)
                    }
                } else {
                    let img = UIImage(named: "portrait.png")
                    self.Portrait.image = img
                }
                
                //safe statement
                let fullname = self.userInfoProfile!.first_name + " " + self.userInfoProfile!.last_name
                guard let username = self.userInfoProfile?.username else {return}
                guard let bio = self.userInfoProfile?.bio else {return}

                //Show info send from server
                self.FullnameLbl.text = fullname
                self.UsernameLbl.text = username
                self.BioLbl.text = bio
                
                //get value of id
                self.guestId = self.userInfoProfile?.id
            }
            
            //call function
            CheckFollowBtn()
        }
    }
    
    //portrait photo
    let Portrait: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()

    //User avatar
    let Avatar: UIImageView = {
        let ava = UIImageView()
        ava.contentMode = .scaleAspectFill
        ava.layer.cornerRadius = 7
        ava.layer.borderWidth = 3
        ava.layer.borderColor = UIColor.white.cgColor
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    let FullnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let UsernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let BioLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor =  UIColor.lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let views: UIView = {
        let views = UIView()
        views.clipsToBounds = true
        views.backgroundColor = .white
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    let coverPortrait: UIView = {
        let cover = UIView()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.clipsToBounds = true
        return cover
    }()
    
    //btn follow user
    lazy var FollowUsr: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Follow", for: .normal)
        btn.tintColor = UIColor.lightGray
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.clipsToBounds = true
        btn.layer.zPosition = 1
        btn.layer.borderWidth = 1
        btn.isHidden = true
        btn.addTarget(self, action: #selector(Following), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let LikesLbl: UILabel = {
        let lbl = UILabel()
        let atributoText = NSMutableAttributedString(string: "0", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black])
        atributoText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        atributoText.append(NSAttributedString(string: " Likes", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        lbl.attributedText = atributoText
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let FollowingLbl: UILabel = {
        let lbl = UILabel()
        let atributoText = NSMutableAttributedString(string: "0", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black])
        atributoText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        atributoText.append(NSAttributedString(string: " Followings", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        lbl.attributedText = atributoText
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let FollowersLbl: UILabel = {
        let lbl = UILabel()
        let atributoText = NSMutableAttributedString(string: "0", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black])
        atributoText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        atributoText.append(NSAttributedString(string: " Followers", attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir Next", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.gray]))
        lbl.attributedText = atributoText
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //boton de grid
    lazy var GridBtn: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "grid.png")
        btn.setImage(img, for: .normal)
        btn.addTarget(self, action: #selector(ChooseGrid), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //boton de list
    lazy var ListBtn: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "list.png")
        btn.setImage(img, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ChooseList), for: .touchUpInside)
        return btn
    }()
    
    //Collection Pics
    let CollectionPicLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "My collections"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.layer.zPosition = 1
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //first function on load
    override init(frame: CGRect) {
        super.init(frame: frame)
        //execute functions
        SetObjects()
        SettingsStadisticUsr()
        SettingsToolBar()
    }

    //Settings portrait
    fileprivate func SetObjects() {
        
        //add to main view
        addSubview(views)
        
        //define constraint
        NSLayoutConstraint.activate([
            views.topAnchor.constraint(equalTo: topAnchor),
            views.leftAnchor.constraint(equalTo: leftAnchor),
            views.rightAnchor.constraint(equalTo: rightAnchor),
            views.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //Add to main view
        views.addSubview(Portrait)

        //Constraint
        NSLayoutConstraint.activate([
            Portrait.topAnchor.constraint(equalTo: views.topAnchor, constant: 0),
            Portrait.leftAnchor.constraint(equalTo: views.leftAnchor),
            Portrait.rightAnchor.constraint(equalTo: views.rightAnchor),
            Portrait.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        //add to main view
        addSubview(coverPortrait)
        
        //define constraint
        NSLayoutConstraint.activate([
            coverPortrait.topAnchor.constraint(equalTo: views.topAnchor, constant: 0),
            coverPortrait.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 0),
            coverPortrait.rightAnchor.constraint(equalTo: views.rightAnchor, constant: 0),
            coverPortrait.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        //Add to main view
        views.addSubview(Avatar)
        
        //Add to main view
        addSubview(Avatar)

        //define constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: Portrait.bottomAnchor, constant: -120),
            Avatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            Avatar.widthAnchor.constraint(equalToConstant: 110),
            Avatar.heightAnchor.constraint(equalToConstant: 130),
        ])
        
        //stackview
        let stackview = UIStackView(arrangedSubviews: [FullnameLbl])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 0
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        addSubview(stackview)
        
        //define constraint
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: Avatar.bottomAnchor, constant: 10),
            stackview.centerXAnchor.constraint(equalTo: stackview.centerXAnchor, constant: 0)
        ])
        
        //add to main view
        addSubview(UsernameLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            UsernameLbl.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 5),
            UsernameLbl.centerXAnchor.constraint(equalTo: stackview.centerXAnchor)
        ])
        
        //add to main view
        addSubview(BioLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            BioLbl.topAnchor.constraint(equalTo: UsernameLbl.bottomAnchor, constant: 5),
            BioLbl.centerXAnchor.constraint(equalTo: UsernameLbl.centerXAnchor),
            BioLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            BioLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
    
    //settings stadisctics users
    fileprivate func SettingsStadisticUsr() {
        
        let stackview = UIStackView(arrangedSubviews: [FollowingLbl, FollowersLbl, LikesLbl, FollowUsr])
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 0
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        addSubview(stackview)
    
        //define constraint
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: BioLbl.bottomAnchor, constant: 20),
            stackview.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            stackview.rightAnchor.constraint(equalTo: rightAnchor, constant: -5)
        ])
    }
    
    //settings toolbar
    fileprivate func SettingsToolBar() {
        
        //separator line
        let topSeparator = UIView()
        topSeparator.backgroundColor = .systemGray
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomSeparator = UIView()
        bottomSeparator.backgroundColor = .systemGray
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
      
        
        //container
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        addSubview(containerView)
        
        //define constraint
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //add to main view
        addSubview(topSeparator)
        
        //define constraint
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            topSeparator.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            topSeparator.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            topSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        //add to main view
        addSubview(bottomSeparator)
        
        //define constraint
        NSLayoutConstraint.activate([
            bottomSeparator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0),
            bottomSeparator.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            bottomSeparator.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        
        //add to second view
        containerView.addSubview(CollectionPicLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            CollectionPicLbl.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10),
            CollectionPicLbl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0)
        ])
        
        //stackview for grid and list views
        let stackviews = UIStackView(arrangedSubviews: [GridBtn,ListBtn])
        stackviews.axis = .horizontal
        stackviews.distribution = .fillEqually
        stackviews.spacing = 20
        stackviews.translatesAutoresizingMaskIntoConstraints = false
        
        //add to secondary views
        containerView.addSubview(stackviews)
        
        //define constraint
        NSLayoutConstraint.activate([
            stackviews.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10),
            stackviews.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0)
        ])
    }

    
    //follow usrs
    @objc fileprivate func Following() {
        print("Now it is following to user")
    }
    
    @objc fileprivate func ChooseGrid() {
        print("grid view")
    }
    
    @objc fileprivate func ChooseList() {
        print("list view")
    }
    
    //try to adapt the view to enviroment actived
    func AdaptHeadertoLight() {
        //define new colors when dark mode it's active
        Avatar.layer.borderColor = UIColor.white.cgColor
        FullnameLbl.textColor = .black
        UsernameLbl.textColor = .black
        BioLbl.textColor = .systemGray
        CollectionPicLbl.textColor = UIColor.black
        GridBtn.tintColor = UIColor.black
        ListBtn.tintColor = UIColor.black
        FollowUsr.tintColor = UIColor.black
        FollowUsr.layer.borderColor = UIColor.black.cgColor
    }
    
    //this function try to adapt interface
    func AdaptHeadertoDark() {
        //define new colors when dark mode it's active
        Avatar.layer.borderColor = UIColor.white.cgColor
        FullnameLbl.textColor = .white
        UsernameLbl.textColor = .white
        BioLbl.textColor = .white
        LikesLbl.textColor = .lightGray
        FollowersLbl.textColor = .lightGray
        FollowingLbl.textColor = .lightGray
        CollectionPicLbl.textColor = .white
        GridBtn.tintColor = .white
        ListBtn.tintColor = .white
        FollowUsr.tintColor = .white
        FollowUsr.layer.borderColor = UIColor.white.cgColor
    }
    
    //check follow button
    func CheckFollowBtn() {
        
        DispatchQueue.main.async {
            
            //get guest id user
            let controller = UserProfileController()
            controller.userId = self.guestId
            
            //get current id user in session
            let currentIdUsr = currentUser!["id"] as? String
            
            //compare if both id are same or not
            if self.guestId == currentIdUsr {
                //hide follow option
                self.FollowUsr.isHidden = true
            } else {
                self.FollowUsr.isHidden = false
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
