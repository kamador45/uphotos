//
//  UpdateInfoUsr.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/2/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UpdateInfoUsrController: UIViewController {
    
    //NavBar
    let navBar: UINavigationBar = {
        let nb = UINavigationBar()
        //nb.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
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
    
    let MainInfoLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Main Info"
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let FirstnameTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Firstname"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.textColor = UIColor.black
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let LastnameTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Lastname"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.textColor = UIColor.white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let UsernameTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Username"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.autocapitalizationType = .none
        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)
        txt.textColor = UIColor.white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let BioLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Bio"
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let BioTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 7
        tv.isEditable = true
        tv.isScrollEnabled = true
        tv.autocapitalizationType = .none
        tv.isUserInteractionEnabled = true
        tv.textAlignment = .center
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //First function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //execute functions
        DetectEnviroment()
        SettingNavBar()
        SettingsObjects()
    }
    
    //detect enviroment
    fileprivate func DetectEnviroment() {
        DispatchQueue.main.async {
              if #available(iOS 12, *) {
                if self.traitCollection.userInterfaceStyle == .light {
                    print("light has been detected")
                    self.view.backgroundColor = .white
                } else {
                    print("Dark has been detected")
                    self.view.backgroundColor = .black
                    self.AdaptObjectDarkMode()
                 }
             }
          }
    }
    
    //settings navbar
    func SettingNavBar() -> Void {
        
        let navItem = UINavigationItem(title: "Info")
        navItem.rightBarButtonItem = SaveBtn
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelEdit))
        navItem.leftBarButtonItem = cancelBtn
        navBar.setItems([navItem], animated: true)
        navigationController?.navigationBar.tintColor = UIColor.blue
        self.view.addSubview(navBar)
        
        //Check ios version
        if #available(iOS 11, *) {
            let limit = view.safeAreaLayoutGuide
            //navBar.topAnchor.constraint(equalTo: limit.topAnchor).isActive = true
            navBar.topAnchor.constraint(equalToSystemSpacingBelow: limit.topAnchor, multiplier: 1.0).isActive = true
        } else {
            navBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
        
        //complements
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //Settings objects
    fileprivate func SettingsObjects() {
        
        //views
        let views = UIView()
        views.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        view.addSubview(views)
        
        //define constraint
        NSLayoutConstraint.activate([
            views.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
            views.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            views.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            views.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        
        //add to main view
        views.addSubview(MainInfoLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            MainInfoLbl.topAnchor.constraint(equalTo: views.topAnchor, constant: 20),
            MainInfoLbl.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 20)
        ])
        
        //create stackview
        let stackView = UIStackView(arrangedSubviews: [UsernameTxt,FirstnameTxt,LastnameTxt])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        //add to main view
        views.addSubview(stackView)
        
        //define constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: MainInfoLbl.topAnchor, constant: 50),
            stackView.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: views.rightAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        //add to main view
        views.addSubview(BioLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            BioLbl.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            BioLbl.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0)
        ])
        
        //add to main view
        views.addSubview(BioTextView)
        
        //define constraint
        NSLayoutConstraint.activate([
            BioTextView.topAnchor.constraint(equalTo: BioLbl.bottomAnchor, constant: 20),
            BioTextView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 0),
            BioTextView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 0),
            BioTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    //try to adapto objects to enviroment
    fileprivate func AdaptObjectDarkMode() {
        FirstnameTxt.textColor = .systemPink
        FirstnameTxt.backgroundColor = .systemGray
        LastnameTxt.textColor = .systemPink
        LastnameTxt.backgroundColor = .systemGray
        UsernameTxt.textColor = .systemPink
        UsernameTxt.backgroundColor = .systemGray
        BioTextView.textColor = .systemPink
        BioTextView.backgroundColor = .systemGray
    }
    
    //cancel update
    @objc func CancelEdit() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Update info profile
    @objc func SaveInfo() {
        //disable btn
        SaveBtn.isEnabled = false
        
        guard let username = UsernameTxt.text else {return}
        guard let first_name = FirstnameTxt.text else {return}
        guard let last_name = LastnameTxt.text else {return}
        guard let bio = BioTextView.text else {return}
        
       
        //prueba
        NetworkingServices.UpdateInfoUsr(username: username, first_name: first_name, last_name: last_name, bio: bio)
        
        //dismiss controller
        self.dismiss(animated: true, completion: nil)
    }
}
