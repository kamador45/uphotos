//
//  HomeFeedController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class HomeFeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //cell id
    let cell_id = "cell"
    
    //receive id user
    var userId:String?
    
    //creating refresh control
    var RefreshControl = UIRefreshControl()
    
    //first function in load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define gesture recognizer
        let taps = UITapGestureRecognizer(target: self, action: #selector(DetectEnviroment))
        taps.numberOfTouchesRequired = 1
        self.collectionView.addGestureRecognizer(taps)
        
        //Call notification
        NotificationCenter.default.addObserver(self, selector: #selector(FetchPosts), name: CreatePostController.Post_Made, object: "details")
        
        //reload collectionview
        RefreshControl.addTarget(self, action: #selector(ManageRefresh), for: .valueChanged)
        
        if #available(iOS 10, *) {
            collectionView.refreshControl = RefreshControl
        } else {
            collectionView.addSubview(RefreshControl)
        }
        
        //Avaible scroll
        collectionView.alwaysBounceVertical = true
        definesPresentationContext = true
        
        //detect enviroment
        if #available(iOS 12, *) {
            if self.traitCollection.userInterfaceStyle == .light {
                print("light enviroment has been detected")
                self.collectionView.backgroundColor = .white
            } else {
                print("Dark enviroment has been detected")
                self.collectionView.backgroundColor = .black
            }
        }
        
        //register cell class
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cell_id)
        
        //Calls functions
        DownloadPosts()
    }
    
    //Change enviroment when dark or light has been detected
    @objc fileprivate func DetectEnviroment() {
        DispatchQueue.main.async {
            if #available(iOS 12, *) {
                if self.traitCollection.userInterfaceStyle == .light {
                    print("light enviroment has been detected")
                    self.collectionView.backgroundColor = .white
                } else {
                    print("Dark enviroment has been detected")
                    self.collectionView.backgroundColor = .black
                }
            }
        }
    }
    
    //Show large title
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Home Feed"
            self.collectionView.contentInsetAdjustmentBehavior = .automatic
        } else {
            navigationController?.navigationItem.title = "Home Feed"
        }
    }
    
    //fetch posts
    @objc fileprivate func FetchPosts() {
        DispatchQueue.main.async {
            print("Hola Posts nuevos")
            self.ManageRefresh()
            self.collectionView.reloadData()
        }
    }
    
    //Manage refresh
    @objc fileprivate func ManageRefresh() {
        DispatchQueue.main.async {
            //execute download post function
            self.DownloadPosts()
            
            //executing refresh control
            self.collectionView.refreshControl = self.RefreshControl
            self.RefreshControl.endRefreshing()
        }
    }
    
    //create number of item
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Posts.count
    }
    
    //create cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //creating cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as! HomeCell
        
        //Pass data to cell
        cell.HomePost = Posts[indexPath.item]
        
        //returning cell
        return cell
    }
    
    //minimun line of separate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    //Defining height of cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //define hight
        var height:CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 60
        height += 60
        height += 50
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    //Create post array
    var Posts = [HomePostModel]()
    
    //Download posts
    fileprivate func DownloadPosts() {
        
        //gets current id in session
        guard let uid = userId ?? currentUser!["id"] as? String else {return}
        
        //define url like references
        guard let url = URL(string: "\(serverURL)feed_posts/\(uid)") else {return}
        
        //defining process to download posts
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                
                //ensure data
                guard let data = data else {return}
                
                //gets JSON objects
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                
                //run every object
                json?.forEach({ (data) in
                    
                    //gets data
                    let key = data
                    
                    //gets key of every object
                    guard let details = key["details"] else {return}
                    
                    print(details)
                    
                    //insert all post in model
                    let post = HomePostModel(user: userData!, uid: uid, dictPost: details as! [String:Any])
                    
                    //insert all post in array
                    self.Posts.append(post)
                })
                
                //sorting objects
                self.Posts.reverse()
                
                //update UI
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch let errorJSON {
                print("Oops something has been resulted bad with JSON ==> \(errorJSON)")
            }
        }.resume()
    }
    
    //definig status bar style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
