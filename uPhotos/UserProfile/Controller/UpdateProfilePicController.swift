//
//  UpdateProfilePicController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 9/6/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UpdateProfilePicController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Access to model
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
        ava.layer.borderColor = UIColor.lightGray.cgColor
        ava.layer.borderWidth = 2
        ava.layer.zPosition = 1
        ava.clipsToBounds = true
        ava.translatesAutoresizingMaskIntoConstraints = false
        return ava
    }()
    
    lazy var SelectPicture:UIButton = {
        let btn = UIButton(type: .system)
        let img = UIImage(named: "camera.png")
        btn.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.layer.zPosition = 1
        btn.clipsToBounds = true
        btn.backgroundColor = .systemGray
        btn.layer.cornerRadius = 35/2
        btn.addTarget(self, action: #selector(UploadProfilePic), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    //textfields
    let UsernameLbl:UILabel = {
        let txt = UILabel()
        txt.text = "Username"
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    
    let FirstnameLbl:UILabel = {
        let txt = UILabel()
        txt.text = "Firstname"
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let LastnameLbl:UILabel = {
        let txt = UILabel()
        txt.text = "Lastname"
        txt.font = UIFont.boldSystemFont(ofSize: 18)
        txt.textColor = .systemGray
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let BioTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.textColor = .systemGray
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 7
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.isUserInteractionEnabled = false
        tv.textAlignment = .center
        tv.font = UIFont.boldSystemFont(ofSize: 18)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //execute all function
        DownloadInfoUser()
        SettingNavBar()
        SetEditAvatar()
    }
    
    //settings navbar
    func SettingNavBar() -> Void {
        
        let navItem = UINavigationItem(title: "Update Profile Pic")
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
            views.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        
        //add to main view
        views.addSubview(Avatar)
        
        //settings constraint
        NSLayoutConstraint.activate([
            Avatar.topAnchor.constraint(equalTo: views.topAnchor, constant: 20),
            Avatar.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 10),
            Avatar.widthAnchor.constraint(equalToConstant: 110),
            Avatar.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        //add to button
        views.addSubview(SelectPicture)
        
        //define constraint
        NSLayoutConstraint.activate([
            SelectPicture.rightAnchor.constraint(equalTo: Avatar.rightAnchor, constant: -5),
            SelectPicture.bottomAnchor.constraint(equalTo: Avatar.bottomAnchor, constant: 0),
            SelectPicture.widthAnchor.constraint(equalToConstant: 35),
            SelectPicture.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        //add to main view
        views.addSubview(UsernameLbl)

        //define constraint
        NSLayoutConstraint.activate([
            UsernameLbl.topAnchor.constraint(equalTo: views.topAnchor, constant: 20),
            UsernameLbl.leftAnchor.constraint(equalTo: Avatar.rightAnchor, constant: 15),
            UsernameLbl.widthAnchor.constraint(equalToConstant: 220)
        ])

        //add to main view
        views.addSubview(FirstnameLbl)

        //define constraint
        NSLayoutConstraint.activate([
            FirstnameLbl.topAnchor.constraint(equalTo: UsernameLbl.bottomAnchor, constant: 15.5),
            FirstnameLbl.leftAnchor.constraint(equalTo: Avatar.rightAnchor, constant: 15),
            FirstnameLbl.widthAnchor.constraint(equalToConstant: 220)
        ])

        //add to main view
        views.addSubview(LastnameLbl)

        //define constraint
        NSLayoutConstraint.activate([
            LastnameLbl.topAnchor.constraint(equalTo: FirstnameLbl.bottomAnchor, constant: 20.5),
            LastnameLbl.leftAnchor.constraint(equalTo: Avatar.rightAnchor, constant: 15),
            LastnameLbl.widthAnchor.constraint(equalToConstant: 220)
        ])


        //add to main view
        views.addSubview(BioTextView)

        //define constraint
        NSLayoutConstraint.activate([
            BioTextView.topAnchor.constraint(equalTo: Avatar.bottomAnchor, constant: 15),
            BioTextView.leftAnchor.constraint(equalTo: views.leftAnchor, constant: 10),
            BioTextView.rightAnchor.constraint(equalTo: views.rightAnchor, constant: -10),
            BioTextView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    //Load info user
    func DownloadInfoUser() {
        
        //get current id in session
        guard let userId = currentUser!["id"] as? String else {return}
        
        print(userId)
        
        //define the url
        guard let url = URL(string: "\(serverURL)find/\(userId)") else {return}
        
        //networking process
        NetworkingServices.getData(from: url) { (data, response, error) in
            //detect any error
            if let err = error {
                print("Oops something has been result bad ==>\(err)")
                return
            } else {
                do {
                    //gets data
                    guard let data = data else {return}
                    
                    //serialization process
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                    
                    //loop every object
                    json?.forEach({ (data) in
                        //store data
                        let data_received = data
                        
                        //gets id user
                        guard let id = data_received["id"] as? String else {return}
                        
                        //compare current id with id send it from server
                        if userId == id {
                            //insert objects in model
                            let parseJSON = UserModel(uid: id, dict: data_received as! [String:Any])
                            
                            print(parseJSON)
                            
                            //create url profile pic
                            let url_pp = parseJSON.path_pic
                            let urls = NSURL(string: url_pp)!
                            
                            //convert url to data
                            let data_pp = try? Data(contentsOf: urls as URL)
                            
                            //check if exist any data and load profile pic
                            if data_pp != nil {
                                DispatchQueue.main.async {
                                    self.Avatar.image = UIImage(data: data_pp!)
                                    self.UsernameLbl.text = parseJSON.username
                                    self.FirstnameLbl.text = parseJSON.first_name
                                    self.LastnameLbl.text = parseJSON.last_name
                                    self.BioTextView.text = parseJSON.bio
                                }
                            } else {
                                DispatchQueue.main.async {
                                    let img = UIImage(named: "user_avatar.png")
                                    self.Avatar.image = img
                                    self.UsernameLbl.text = parseJSON.username
                                    self.FirstnameLbl.text = parseJSON.first_name
                                    self.LastnameLbl.text = parseJSON.last_name
                                    self.BioTextView.text = parseJSON.bio
                                }
                            }
                        }
                    })
                    
                } catch let errorJSON {
                    print("Oops something has been result bad in errorJSON ==>\(errorJSON)")
                    return
                }
            }
        }
    }
    
    //cancel update
    @objc func CancelEdit() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Update info profile
    @objc func SaveInfo() {
        //disable btn
        SaveBtn.isEnabled = false
        //execute the function
        UpdateProfilePic()
    }
    
    //upload pic
    @objc fileprivate func UploadProfilePic() {
        print("Loading gallery")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editProfilePic = info[.editedImage] as? UIImage {
            Avatar.image = editProfilePic
        }
        
        //dismiss controller
        dismiss(animated: true, completion: nil)
    }
    
    // custom body of HTTP request to upload image file
    func createBodyWithParams(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
        
    }
    
    //define notify name
    static let ProfilePicture = NSNotification.Name("ProfilePicture")
    
    //Upload picture
    fileprivate func UpdateProfilePic() {
        
        //get id info user
        guard let id = userInfo?.id else {return}
        
        //network process
        guard let url = URL(string: "\(serverURL)update_profile_pic/\(id)") else {return}
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        //params to be sent in body
        let params = ["id":id]
        
        //body
        let boundary = "Boundary-\(NSUUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        
        let imageData = self.Avatar.image?.jpegData(compressionQuality: 0.5)
        //detect if image was compressed
        if imageData == nil {
            return
        }
        
        
        //Define method body
        request.httpBody = self.createBodyWithParams(parameters: params, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        
        //Start services of networking
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            //Execute in background
            DispatchQueue.main.async(execute: {
                if let err = error {
                    print("Oops something do not working well", err)
                } else {
                    print("Profile pic has been updated")
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: UpdateProfilePicController.ProfilePicture, object: "parseJSON")
                }
            })
            
        }.resume()
        
    }
    
    //hidden status bar
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

extension NSMutableData {
    func appendString(string: String) -> Void {
        guard let data = string.data(using: .utf8, allowLossyConversion: true) else {return}
        self.append(data)
    }
}
