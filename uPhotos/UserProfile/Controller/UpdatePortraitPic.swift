//
//  UpdatePortraitPic.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 9/20/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UpdatePortraitPic: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //access to model
    var userInfo = userData
    
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
    lazy var Avatar: UIImageView = {
        let ava = UIImageView()
        ava.contentMode = .scaleAspectFill
        ava.layer.cornerRadius = 7
        ava.layer.borderColor = UIColor.white.cgColor
        ava.layer.borderWidth = 2
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    //portrait photo
    let Portrait: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.translatesAutoresizingMaskIntoConstraints = false
        return imv
    }()
    
    lazy var SelectPicture:UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "camera.png")
        btn.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.layer.zPosition = 1
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor.lightGray
        btn.layer.cornerRadius = 35/2
        btn.addTarget(self, action: #selector(UploadPortrait), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let CompleteNamesLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Complete Names"
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
    
    let BioLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor =  UIColor.lightGray
        lbl.text = "Bio"
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define background color
        view.backgroundColor = .white
        
        //execute all function
        DownloadInfoUser()
        SettingNavBar()
        SettingsObjects()
    }
    
    //settings navbar
    func SettingNavBar() -> Void {
        
        let navItem = UINavigationItem(title: "Profile Picture")
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
    
    //settings objects
    fileprivate func SettingsObjects() {
        
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
            views.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        
        //add to second view
        views.addSubview(Portrait)
        
        //settings constraint
        NSLayoutConstraint.activate([
            Portrait.topAnchor.constraint(equalTo: views.topAnchor, constant: 0),
            Portrait.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 0),
            Portrait.rightAnchor.constraint(equalTo: views.rightAnchor, constant: 0),
            Portrait.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        
        //add to main view
        views.addSubview(Avatar)
        
        //settings constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: Portrait.bottomAnchor, constant: -100),
            Avatar.centerXAnchor.constraint(equalTo: views.centerXAnchor),
            Avatar.widthAnchor.constraint(equalToConstant: 110),
            Avatar.heightAnchor.constraint(equalToConstant: 130),
        ])
        
        //add to button
        views.addSubview(SelectPicture)
        
        //define constraint
        NSLayoutConstraint.activate([
            SelectPicture.rightAnchor.constraint(equalTo: Portrait.rightAnchor, constant: -5),
            SelectPicture.bottomAnchor.constraint(equalTo: Portrait.bottomAnchor, constant: -10),
            SelectPicture.widthAnchor.constraint(equalToConstant: 35),
            SelectPicture.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        //stackview
        let stackview = UIStackView(arrangedSubviews: [CompleteNamesLbl])
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 0
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        views.addSubview(stackview)
        
        //define constraint
        NSLayoutConstraint.activate([
            stackview.topAnchor.constraint(equalTo: Avatar.bottomAnchor, constant: 10),
            stackview.centerXAnchor.constraint(equalTo: stackview.centerXAnchor, constant: 0)
        ])
        
        //add to main view
        views.addSubview(UsernameLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            UsernameLbl.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 5),
            UsernameLbl.centerXAnchor.constraint(equalTo: stackview.centerXAnchor)
        ])
        
        //add to main view
        views.addSubview(BioLbl)
        
        //define constraint
        NSLayoutConstraint.activate([
            BioLbl.topAnchor.constraint(equalTo: UsernameLbl.bottomAnchor, constant: 5),
            BioLbl.centerXAnchor.constraint(equalTo: UsernameLbl.centerXAnchor),
            BioLbl.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 20),
            BioLbl.rightAnchor.constraint(equalTo: views.rightAnchor, constant: -20)
        ])
    }
    
    //download info user
    func DownloadInfoUser() {
        
        //capture id user on session
        guard let userId = currentUser!["id"] as? String else {return}
        
        print(userId)
        
        //define the url
        guard let url = URL(string: "\(serverURL)find/\(userId)") else {return}
        
        print(url)
        
        NetworkingServices.getData(from: url) { (data, response, error) in
            if let err = error {
                print("Oops something has been result bad ==>\(err)")
            } else {
                do {
                    //gets data
                    guard let data = data else {return}
                    
                    //serialization json data
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                    
                    //loop every object
                    json?.forEach({ (data) in
                        
                        //store data
                        let data_user = data
                        
                        //gets id user
                        guard let id = data_user["id"] as? String else {return}
                        
                        //compare current id with id receive from server
                        if userId == id {
                            
                            //gets id user send from server and insert to model
                            let parseJSON = UserModel(uid: id, dict: data_user as! [String : Any])
                            
                            //create url profile pic
                            let url_pp = parseJSON.path_pic
                            let urls = NSURL(string: url_pp)!
                            
                            //conver url to data
                            let data_pp = try? Data(contentsOf: urls as URL)
                            
                            //check if exist any data and load profile pic
                            if data_pp != nil {
                                DispatchQueue.main.async {
                                    self.Avatar.image = UIImage(data: data_pp!)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    let img = UIImage(named: "user_avatar.png")
                                    self.Avatar.image = img
                                }
                            }
                            
                            //Load info user like firstname, etc.
                            let complete_name = ("\(parseJSON.first_name)") + " " + ("\(parseJSON.last_name)")
                            
                            //load data in background
                            DispatchQueue.main.async {
                                self.CompleteNamesLbl.text = complete_name
                                self.UsernameLbl.text = parseJSON.username
                                self.BioLbl.text = parseJSON.bio
                            }
                            
                            //let create url portrait pic
                            let url_portrait = parseJSON.path_portrait
                            let urls_pp = NSURL(string: url_portrait)!
                            
                            //convert url to data
                            let data_portrait = try? Data(contentsOf: urls_pp as URL)
                            
                            //check if exist any data
                            if data_portrait != nil {
                                DispatchQueue.main.async {
                                    self.Portrait.image = UIImage(data: data_portrait!)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    let img = UIImage(named: "portrait.png")
                                    self.Portrait.image = img
                                }
                            }
                            
                        } else {
                            print("oops error ==>")
                            return
                        }
                        
                    })
                    
                    
                } catch let errorJSON {
                    print("Oops something has been result bad in errorJSON ==>\(errorJSON)")
                }
            }
        }
    }
    
    //buttons for navBar
    @objc func CancelEdit() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //save info
    @objc func SaveInfo() {
        UpdatePortraitPicture()
        self.dismiss(animated: true, completion: nil)
    }
    
    //upload pic
    @objc fileprivate func UploadPortrait() {
        print("Loading gallery")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    //detect if portrait has been edited
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editProfilePic = info[.editedImage] as? UIImage {
            Portrait.image = editProfilePic
        }
        
        //dismiss controller
        dismiss(animated: true, completion: nil)
    }
    
    // custom body of HTTP request to upload image file
    func createBodyWithParams(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendStrings(string: "--\(boundary)\r\n")
                body.appendStrings(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendStrings(string: "\(value)\r\n")
            }
        }
        
        //define filename
        let filename = "profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendStrings(string: "--\(boundary)\r\n")
        body.appendStrings(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendStrings(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendStrings(string: "\r\n")
        
        body.appendStrings(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    //upload portrait picture
    fileprivate func UpdatePortraitPicture() {
        
        //get id info user
        guard let id = userInfo?.id else {return}
        
        //network process
        guard let url = URL(string: "\(serverURL)update_portrait/\(id)") else {return}
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        //params to be sent in body
        let params = ["id":id]
        
        //body
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        //send to background process
        DispatchQueue.main.async {
            
            //compress image
            let imageData = self.Portrait.image?.jpegData(compressionQuality: 0.5)
            //detect if image was compressed
            if imageData == nil {
                return
            }
            
            //define body request
            request.httpBody = self.createBodyWithParams(parameters: params, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
            
            //Start services of networking
            URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                //Execute in background
                DispatchQueue.main.async(execute: {
                    if let err = error {
                        print("Oops something do not working well", err)
                    } else {
                        print("Profile pic has been updated")
                    }
                })
            }.resume()
        }
        
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
}

extension NSMutableData {
    func appendStrings(string: String) -> Void {
        guard let data = string.data(using: .utf8, allowLossyConversion: true) else {return}
        self.append(data)
    }
}
