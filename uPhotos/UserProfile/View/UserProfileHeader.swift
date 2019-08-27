//
//  UserProfileHeader.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UserProfileHeader: UICollectionViewCell {
    
    //portrait photo
    let Portrait: UIImageView = {
        let img = UIImage(named: "default-portrait.jpg")
        let imv = UIImageView(image: img)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    //User avatar
    let Avatar: UIImageView = {
        let img = UIImage(named: "user_avatar.png")
        let ava = UIImageView(image: img)
        ava.contentMode = .scaleAspectFill
        ava.layer.cornerRadius = 7
        ava.layer.borderWidth = 3
        ava.layer.borderColor = UIColor.white.cgColor
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    let FirstnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Firstname"
        lbl.textAlignment = .center
        lbl.textColor =  .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let LastnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lastname"
        lbl.textAlignment = .center
        lbl.textColor =  .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let UsernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Username"
        lbl.textAlignment = .center
        lbl.textColor =  UIColor.lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let CurrentLocation: UIImageView = {
        let img =  UIImage(named: "location-pin.png")
        let imv = UIImageView(image: img)
        imv.contentMode = .scaleAspectFit
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    let CurrentCountryLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Jinotega, Nicaragua"
        lbl.textAlignment = .left
        lbl.textColor =  UIColor.lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let BioLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "I am a software engineering who love programmer."
        lbl.textAlignment = .center
        lbl.textColor =  UIColor.lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let views: UIView = {
        let views = UIView()
        views.backgroundColor = .red
        views.clipsToBounds = true
        views.translatesAutoresizingMaskIntoConstraints = false
        return views
    }()
    
    let coverPortrait: UIView = {
        let cover = UIView()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.clipsToBounds = true
        return cover
    }()
    
    let ContainerBtn: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30 / 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 2
        view.layer.zPosition = 5
        return view
    }()
    
    let EditProfile: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("•••", for: .normal)
        btn.tintColor = UIColor.white
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        btn.tintColor = UIColor.black
        btn.addTarget(self, action: #selector(ChooseGrid), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //boton de list
    lazy var ListBtn: UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "list.png")
        btn.setImage(img, for: .normal)
        btn.tintColor = UIColor(white: 0, alpha: 0.1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(ChooseList), for: .touchUpInside)
        return btn
    }()
    
    //Collection Pics
    let CollectionPicLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.black
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
        
        //Define background color
        backgroundColor = .white
        
        //execute functions
        SetPortrait()
        SettingsStadisticUsr()
        SettingsToolBar()
    }

    //Settings portrait
    fileprivate func SetPortrait() {
        
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
        
        //define blur effect
        let darkMode = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkMode)
        blurView.frame = coverPortrait.bounds
        blurView.alpha = 0.5
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 200)
        
        //Add to main view
        addSubview(blurView)
        
        //Add to main view
        addSubview(Avatar)

        //define constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: Portrait.bottomAnchor, constant: -120),
            Avatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            Avatar.widthAnchor.constraint(equalToConstant: 150),
            Avatar.heightAnchor.constraint(equalToConstant: 150),
        ])
        
        //stackview
        let stackview = UIStackView(arrangedSubviews: [FirstnameLbl,LastnameLbl])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 5
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
        addSubview(CurrentLocation)
        
        //define constraint
        NSLayoutConstraint.activate([
            CurrentLocation.topAnchor.constraint(equalTo: UsernameLbl.bottomAnchor, constant: 5),
            CurrentLocation.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70)
        ])
        
        //add to main view
        addSubview(CurrentCountryLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            CurrentCountryLbl.topAnchor.constraint(equalTo: UsernameLbl.bottomAnchor, constant: 5),
            CurrentCountryLbl.leftAnchor.constraint(equalTo: CurrentLocation.leftAnchor, constant: 10)
        ])
        
        //add to main view
        addSubview(BioLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            BioLbl.topAnchor.constraint(equalTo: CurrentLocation.bottomAnchor, constant: 5),
            BioLbl.centerXAnchor.constraint(equalTo: UsernameLbl.centerXAnchor),
            BioLbl.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            BioLbl.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        //add to main view
        addSubview(ContainerBtn)
        
        //define constraint
        NSLayoutConstraint.activate([
            ContainerBtn.topAnchor.constraint(equalTo: views.topAnchor, constant: 20),
            ContainerBtn.widthAnchor.constraint(equalToConstant: 30),
            ContainerBtn.heightAnchor.constraint(equalToConstant: 30),
            ContainerBtn.rightAnchor.constraint(equalTo: views.rightAnchor, constant: -10)
        ])
        
        //add to main view
        ContainerBtn.addSubview(EditProfile)
        
        //define constraint
        NSLayoutConstraint.activate([
            EditProfile.centerXAnchor.constraint(equalTo: ContainerBtn.centerXAnchor),
            EditProfile.centerYAnchor.constraint(equalTo: ContainerBtn.centerYAnchor)
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
        topSeparator.backgroundColor = UIColor.lightGray
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomSeparator = UIView()
        bottomSeparator.backgroundColor = UIColor.lightGray
        bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        //container
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
