//
//  UserProfileHeader.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

//name of notification
let UpdateProfile = "updateProfile"

class UserProfileHeader: UICollectionViewCell, UIImagePickerControllerDelegate {
    
    //portrait photo
    let Portrait: DownloadImage = {
        let img = UIImage(named: "portrait.png")
        let imv = DownloadImage(image: img)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()

    //User avatar
    let Avatar: DownloadImage = {
        let img = UIImage(named: "user_avatar.png")
        let ava = DownloadImage(image: img)
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
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let LastnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Lastname"
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let UsernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Username"
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
    
    //declare notify
    let updateProfilePic = Notification.Name(rawValue: UpdateProfile)
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //first function on load
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Download info user in brackground
        DispatchQueue.main.async {
            self.DownloadInfoUser()
        }
        
        //execute functions
        createObservers()
        SetObjects()
        SettingsStadisticUsr()
        SettingsToolBar()
        LoadOptions()
    }
    
    //create observer method
    func createObservers() {
        //update profile pic
        NotificationCenter.default.addObserver(self, selector: #selector(UserProfileHeader.updateImgProfile(notification:)), name: updateProfilePic, object: nil)
    }
    
    @objc func updateImgProfile(notification: NSNotification) {
        
        let isProfile = notification.name
        
        if isProfile == updateProfilePic {
            DispatchQueue.main.async {
                appDelegates.Login()
            }
        }
    }
    
    
    var userInfoProfile = userData {
        didSet {
            DispatchQueue.main.async {
                
                //download and set profile pic
                guard let urlImage = self.userInfoProfile?.path_pic else {return}
                self.Avatar.LoadImage(urlString: urlImage)

                //download portrait pic
                guard let urlPortrait = self.userInfoProfile?.path_portrait else {return}
                self.Portrait.LoadImage(urlString: urlPortrait)


                //safe statement
                guard let firstname = self.userInfoProfile?.first_name else {return}
                guard let lastname = self.userInfoProfile?.last_name else {return}
                guard let username = self.userInfoProfile?.username else {return}
                guard let bio = self.userInfoProfile?.bio else {return}


                //Show info send from server
                self.FirstnameLbl.text = firstname
                self.LastnameLbl.text = lastname
                self.UsernameLbl.text = username
                self.BioLbl.text = bio
            }
        }
    }
    
    //download info user
    fileprivate func DownloadInfoUser() {
        
        //capture id user on session
        guard let userId = userData?.id else {return}
        
        //define the url
        guard let url = URL(string: "http://192.168.0.11:1337/find/\(userId)") else {return}
        
        NetworkingServices.getData(from: url) { (data, response, error) in
            guard let data = data else {return}
            
            if let err = error {
                print("Oops something go wrong==>\(err)")
            } else {
                do {
                    //receive data send from server
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                    
                    //access to id
                    guard let id = json!["id"] as? String else {return}
                    
                    //adapt all object to model
                    let parseJSON = UserModel(uid: id, dict: json as! [String : Any])
                    
                    //compare id
                    if !(id).isEmpty {
                        DispatchQueue.main.async {
                            self.Portrait.LoadImage(urlString: parseJSON.path_portrait)
                            self.Avatar.LoadImage(urlString: parseJSON.path_pic)
                            self.FirstnameLbl.text = parseJSON.first_name
                            self.LastnameLbl.text = parseJSON.last_name
                            self.BioLbl.text = parseJSON.bio
                        }
                    }
                    
                } catch let errorJSON {
                    print("Oops something go wrong==>\(errorJSON)")
                }
            }
            
        }
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
        
        //define blur effect
        let darkMode = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: darkMode)
        blurView.frame = coverPortrait.bounds
        blurView.alpha = 0.6
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 200)
        
        //Add to main view
        addSubview(blurView)
        
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
        let stackview = UIStackView(arrangedSubviews: [FirstnameLbl,LastnameLbl])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = -4
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
        
        
        //detect darkmode
//        if #available(iOS 12, *) {
//            if traitCollection.userInterfaceStyle == .light {
//                print("light detected")
//                topSeparator.backgroundColor = .systemGray
//                bottomSeparator.backgroundColor = .systemGray
//            } else {
//                print("dark detected")
//                topSeparator.backgroundColor = .white
//                bottomSeparator.backgroundColor = .white
//                containerView.backgroundColor = .black
//                CollectionPicLbl.textColor = .systemPink
//                GridBtn.tintColor = .systemPink
//                ListBtn.tintColor = .systemPink
//            }
//        }
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
    
    func LoadOptions() {
        EditProfile.addTarget(self, action: #selector(LoadAlertController), for: .touchUpInside)
    }
    
    @objc func LoadAlertController() {
        //create alert controller
        let actionSheet = UIAlertController(title: "Hey \(userData?.username ?? "")", message: "what do you want update?", preferredStyle: .actionSheet)
        
        //Load update profile pic
        let updateProfilePic = UIAlertAction(title: "Update Profile Pic", style: .default) { (_) in
            do {
                let controller = UpdateProfilePicController()
                UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
            }
        }
        
        //update portraint pic
        let updatePortrait = UIAlertAction(title: "Update Portrait", style: .default) { (_) in
            do {
                let controller = UpdatePortraitPic()
                UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
                
            }
        }
        
        //update info user
        let updateInfoUsr = UIAlertAction(title: "Update Info", style: .default) { (_) in
            do {
                print("Loading update info user")
            }
        }
        
        let destructive = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        //add actions to alert controller
        actionSheet.addAction(updateProfilePic)
        actionSheet.addAction(updatePortrait)
        actionSheet.addAction(updateInfoUsr)
        actionSheet.addAction(destructive)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }
    
    //Change color
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DispatchQueue.main.async {
            if #available(iOS 12, *) {
                if self.traitCollection.userInterfaceStyle == .light {
                    self.AdaptHeadertoLight()
                } else {
                    self.AdaptHeadertoDark()
                }
            }
        }
    }
    
    fileprivate func AdaptHeadertoLight() {
        //define new colors when dark mode it's active
        Avatar.layer.borderColor = UIColor.white.cgColor
        FirstnameLbl.textColor = .black
        LastnameLbl.textColor = .black
        UsernameLbl.textColor = .black
        BioLbl.textColor = .systemGray
    }
    
    //this function try to adapt interface
    fileprivate func AdaptHeadertoDark() {

        //define new colors when dark mode it's active
        Avatar.layer.borderColor = UIColor.black.cgColor
        FirstnameLbl.textColor = .systemPink
        LastnameLbl.textColor = .systemPink
        UsernameLbl.textColor = .systemPink
        BioLbl.textColor = .systemPink
        LikesLbl.textColor = .systemPink
        FollowersLbl.textColor = .systemPink
        FollowingLbl.textColor = .systemPink
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}