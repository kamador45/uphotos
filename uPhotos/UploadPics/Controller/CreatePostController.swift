//
//  CreatePostController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/30/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class CreatePostController: UIViewController {
    
    //Load image selected in header and prepare to make post
    var ImageToPost: UIImage? {
        didSet {
            //load image selected in head
            self.PhotoView.image = self.ImageToPost
        }
    }
    
    //ImageView to load pic selected
    let PhotoView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //Textview
    let PostViewText: UITextView = {
        let tv = UITextView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0), textContainer: nil)
        tv.textAlignment = .justified
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.layer.borderColor = UIColor.black.cgColor
        tv.isEditable = true
        tv.isUserInteractionEnabled = true
        tv.layer.borderWidth = 2
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //First function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        //Execute function
        SetupMainObjects()
        SetupRightButton()
    }
    
    //Settings main objects
    fileprivate func SetupMainObjects() {
        
        //create a container
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        //add to mainView
        view.addSubview(container)
        
        //define constraint
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0),
            container.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            container.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            container.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
        
        //add photo view to container
        container.addSubview(PhotoView)
        
        //define constraint
        NSLayoutConstraint.activate([
            PhotoView.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            PhotoView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0),
            PhotoView.widthAnchor.constraint(equalToConstant: 120),
            PhotoView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        //add text view to container
        container.addSubview(PostViewText)
        
        //define constraint
        NSLayoutConstraint.activate([
            PostViewText.topAnchor.constraint(equalTo: PhotoView.topAnchor),
            PostViewText.leftAnchor.constraint(equalTo: PhotoView.rightAnchor, constant: 3),
            PostViewText.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0),
            PostViewText.widthAnchor.constraint(equalToConstant: 120),
            PostViewText.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    //Create right button to make a post
    fileprivate func SetupRightButton() {
        //Create button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(CreatePost))
    }
    
    //Create post
    @objc fileprivate func CreatePost() {
        
        //Capture datas
        guard let text = PostViewText.text else {return}
        guard let postImg = ImageToPost else {return}
        guard let uid = userData?.id else {return}
        guard let imageWidth = ImageToPost?.size.width else {return}
        guard let imageHeight = ImageToPost?.size.height else {return}
        
        
        //Check data
        if !(uid).isEmpty || !(text).isEmpty || !(postImg.images)!.isEmpty || imageWidth != 0 || imageHeight != 0 {

            guard let url = URL(string: "http://localhost:1337/post/\(uid)") else {return}
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "POST"


            let boundary = "Boundary-\(NSUUID().uuidString)"
            let imageData = postImg.jpegData(compressionQuality: 0.5)


            //detect if is nil
            if imageData == nil {
                return
            }

            //settings value in multipart form data
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            //Prepare params to send to server
            let params = [
                "id":uid,
                "caption":text,
                "imageWidth":imageWidth,
                "imageHeight":imageHeight
                ] as [String : Any]

            //define body
            request.httpBody = NetworkingPost.createBodyWithParams(parameters:params,filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data

            //Send parameters
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if let err = error {
                    print("Oops something had resulted bad ==>\(err)")
                } else {
                    guard let data = data else {return}
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                        print(json)
                    } catch let errorJSON {
                        print("oops something had result bad errorJSON ==>\(errorJSON)")
                    }
                }
            }

            //resume
            dataTask.resume()
        }
    }
    
    //hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
