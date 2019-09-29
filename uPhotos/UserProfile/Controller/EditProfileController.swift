//
//  EditProfileController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 9/2/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class EditProfileController: UIViewController, UINavigationControllerDelegate {
    
    //NavBar
    let navBar: UINavigationBar = {
        let nb = UINavigationBar()
        nb.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        nb.translatesAutoresizingMaskIntoConstraints = false
        return nb
    }()
    
    //Save
    let SaveBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem()
        btn.style = .plain
        btn.title = "Save"
        btn.action = #selector(SaveInfo)
        return btn
    }()
    
    //Avatar
    lazy var Avatar: DownloadImage = {
        let img = UIImage(named: "user_avatar.png")
        let ava = DownloadImage(image: img)
        ava.contentMode = .scaleAspectFill
        ava.layer.cornerRadius = 7
        ava.layer.borderColor = UIColor.lightGray.cgColor
        ava.layer.borderWidth = 2
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    lazy var Portrait: DownloadImage = {
        let img = UIImage(named: "portrait.png")
        let imv = DownloadImage(image: img)
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    //settings btns
    let editProfilePic: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.addTarget(self, action: #selector( UpdatePicProfile), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let editPortrait: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Edit", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let editMainInfo: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Main Info", for: .normal)
        btn.addTarget(self, action: #selector(LoadMainInfo), for: .touchUpInside)
        return btn
    }()
    
    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        //execute all function
        SettingNavBar()
        SetEditAvatar()
        DownloadImgUserProfile()
    }
    
    //settings navbar
    func SettingNavBar() -> Void {
        let navItem = UINavigationItem(title: "Edit Profile")
        navItem.rightBarButtonItem = SaveBtn
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelEdit))
        navItem.leftBarButtonItem = cancelBtn
        navBar.setItems([navItem], animated: true)
        navigationController?.navigationBar.tintColor = UIColor.blue
        self.view.addSubview(navBar)
        
        //Check ios version
        if #available(iOS 11, *) {
            let limit = view.safeAreaLayoutGuide
            navBar.topAnchor.constraint(equalTo: limit.topAnchor).isActive = true
        } else {
            navBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
        
        //complements
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if #available(iOS 11.0, *) {
            let guide = view.safeAreaLayoutGuide
            navBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        } else {
            navBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    //settings objects update view
    fileprivate func SetEditAvatar() {
        
        //views
        let views = UIView()
        views.backgroundColor = UIColor.white
        views.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        view.addSubview(views)
        
        //constraint
        NSLayoutConstraint.activate([
            views.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
            views.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            views.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            views.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        //line separator
        let lineSeparator = UIView()
        lineSeparator.backgroundColor = UIColor.lightGray
        lineSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        view.addSubview(lineSeparator)
        
        //constraint
        NSLayoutConstraint.activate([
            lineSeparator.topAnchor.constraint(equalTo: views.bottomAnchor, constant: 0),
            lineSeparator.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lineSeparator.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            lineSeparator.heightAnchor.constraint(equalToConstant: 0.3)
        ])
        
        //settings title
        let MainInfoLbl = UILabel()
        MainInfoLbl.text = "Profile Picture"
        MainInfoLbl.translatesAutoresizingMaskIntoConstraints = false
        MainInfoLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        //add to second view
        views.addSubview(MainInfoLbl)
        
        //settings constraint
        NSLayoutConstraint.activate([
            MainInfoLbl.topAnchor.constraint(equalTo: views.topAnchor, constant: 20),
            MainInfoLbl.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 15)
        ])
        
        //add to main view
        views.addSubview(editProfilePic)
        
        //settings constraint
        NSLayoutConstraint.activate([
            editProfilePic.topAnchor.constraint(equalTo: views.topAnchor, constant: 20),
            editProfilePic.rightAnchor.constraint(equalTo: views.rightAnchor, constant: -15)
        ])
        
        //add to main view
        views.addSubview(Avatar)
        
        //settings constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: MainInfoLbl.bottomAnchor, constant: 35),
            Avatar.centerXAnchor.constraint(equalTo: views.centerXAnchor, constant: 0),
            Avatar.widthAnchor.constraint(equalToConstant: 110),
            Avatar.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        
        //views
        let viewsContainer = UIView()
        viewsContainer.backgroundColor = UIColor.white
        viewsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        view.addSubview(viewsContainer)
        
        //constraint
        NSLayoutConstraint.activate([
            viewsContainer.topAnchor.constraint(equalTo: views.bottomAnchor, constant: 5),
            viewsContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            viewsContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            viewsContainer.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        //settings title
        let portraitLbl = UILabel()
        portraitLbl.text = "Portrait Picture"
        portraitLbl.translatesAutoresizingMaskIntoConstraints = false
        portraitLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        //add to second view
        viewsContainer.addSubview(portraitLbl)
        
        //settings constraint
        NSLayoutConstraint.activate([
            portraitLbl.topAnchor.constraint(equalTo: viewsContainer.topAnchor, constant: 20),
            portraitLbl.leftAnchor.constraint(equalTo: viewsContainer.leftAnchor, constant: 15)
        ])
        
        //line separator
        let lineSeparatorPortrait = UIView()
        lineSeparatorPortrait.backgroundColor = UIColor.lightGray
        lineSeparatorPortrait.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        view.addSubview(lineSeparatorPortrait)
        
        //constraint
        NSLayoutConstraint.activate([
            lineSeparatorPortrait.topAnchor.constraint(equalTo: viewsContainer.bottomAnchor, constant: 0),
            lineSeparatorPortrait.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lineSeparatorPortrait.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            lineSeparatorPortrait.heightAnchor.constraint(equalToConstant: 0.3)
        ])
        
        //add to main view
        viewsContainer.addSubview(editPortrait)
        
        //settings constraint
        NSLayoutConstraint.activate([
            editPortrait.topAnchor.constraint(equalTo: viewsContainer.topAnchor, constant: 20),
            editPortrait.rightAnchor.constraint(equalTo: viewsContainer.rightAnchor, constant: -15)
        ])
        
        //add portrait
        viewsContainer.addSubview(Portrait)
        
        //constraint
        NSLayoutConstraint.activate([
            Portrait.topAnchor.constraint(equalTo: portraitLbl.bottomAnchor, constant: 35),
            Portrait.centerXAnchor.constraint(equalTo: viewsContainer.centerXAnchor, constant: 0),
            Portrait.widthAnchor.constraint(equalToConstant: 250),
            Portrait.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    //Download image from server
    fileprivate func DownloadImgUserProfile() {
        
        //send request for new data
        guard let id = userData?.id else {return}
        guard let url = URL(string: "http://192.168.0.11:1337/find/\(id)") else {return}
        
        //call networking services
        NetworkingServices.getData(from: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                guard let idUser = json!["id"] as? String else {return}
                
                let parseJSON = UserModel(uid: idUser, dict: json as! [String : Any])
                
                if !(id).isEmpty {
                    DispatchQueue.main.async {
                        
                        print(parseJSON)
                        
                        //encode objects receive from server
                        UserDefaults.standard.set(try? PropertyListEncoder().encode(parseJSON), forKey: "parseJSON")
                        
                        //convert data to object
                        guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}
                        
                        //decode and insert all data in model
                        guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}
                        
                        //Store all info in global var
                        userData = userInfo
                        
                        guard let urlImage = userData?.path_pic else {return}
                        self.Avatar.LoadImage(urlString: urlImage)
                        
                    }
                }
                
            } catch let errorJSON {
                print("Oops something go wrong ==>\(errorJSON)")
            }
            
        }
    }
    
    //Update info profile
    @objc func SaveInfo() {
        dismiss(animated: true, completion: nil)
    }
    
    //cancel update
    @objc func CancelEdit() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //settings and load pickerController
    @objc func UpdatePicProfile() {
        let controller = UpdateProfilePicController()
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func LoadMainInfo() {
        print("Hola...")
    }
    
    //hidden status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

