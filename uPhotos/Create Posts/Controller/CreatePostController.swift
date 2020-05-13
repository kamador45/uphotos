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
    
    //define notify name
    static let Post_Made = NSNotification.Name("Post_Made")
    
    //Create post
    @objc fileprivate func CreatePost() {
        
        //Capture datas
        guard let text = PostViewText.text else {return}
        guard let postImg = ImageToPost else {return}
        guard let uid = userData?.id else {return}
        guard let imageWidth = ImageToPost?.size.width else {return}
        guard let imageHeight = ImageToPost?.size.height else {return}

        //disable button
        navigationItem.rightBarButtonItem?.isEnabled = false

        //Check data
        if !(uid).isEmpty || !(text).isEmpty || !(postImg.images)!.isEmpty || imageWidth != 0 || imageHeight != 0 {

            //Load petition to make request to server
            NetworkingPost.CreatePostNetwork(uid: uid, Caption: text, PostImg: postImg, ImageWidth: Int(imageWidth), ImageHeight: Int(imageHeight))

            //auto dissmis
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
