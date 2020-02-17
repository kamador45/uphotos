//
//  UserProfileController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var menuView = MenuView()
    let height:CGFloat = 325
    
    //Access to model user
    var InfoUser: UserModel?
    
    //Access to model post
    var PostUsr: PostModel?
    
    //receive id user
    var userId:String?
    
    //header id
    let header_id = "header"
    let celdaId = "CeldaId"
    let celdaPost = "celdaPost"
    
    var RefreshControl = UIRefreshControl()
    
    //First function on load
    override func viewDidLoad() {
        super.viewDidLoad()

        //declare tap screen
        let taps = UITapGestureRecognizer(target: self, action: #selector(DetectEnviroment))
        taps.numberOfTouchesRequired = 1
        self.collectionView.addGestureRecognizer(taps)
        
        
        //Call notification
         NotificationCenter.default.addObserver(self, selector: #selector(Fetch), name: UpdateProfilePicController.ProfilePicture, object: "parseJSON")

        //reload collectionview
        RefreshControl.addTarget(self, action: #selector(ManageRefresh), for: .valueChanged)
        Fetch()

        if #available(iOS 10, *) {
            collectionView.refreshControl = RefreshControl
        } else {
            collectionView.addSubview(RefreshControl)
        }
        
        //detect style to add menu style
        if #available(iOS 12, *) {
            if self.traitCollection.userInterfaceStyle == .light {
                self.AddLightMenu()
            } else {
                self.AddDarkMenu()
            }
        }
        
        //register view on controller
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header_id)
        
        //register cell
        collectionView.register(ProfilePostUsrCell.self, forCellWithReuseIdentifier: celdaId)
        
        //Settings display mode
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        print(userData)
        
        //call functions
        DescargaNewInfoUsr()
        DownloadPostUsr()
        ManageActionsControllers()
    }
    
    //Chance enviroment when dark or light has been detected
    @objc fileprivate func DetectEnviroment() {
        DispatchQueue.main.async {
            if #available(iOS 12, *) {
                if self.traitCollection.userInterfaceStyle == .light {
                    print("light has been detected")
                    self.collectionView.backgroundColor = .white
                    self.AddLightMenu()
               } else {
                    print("Dark has been detected")
                    self.collectionView.backgroundColor = .black
                    self.AddDarkMenu()
               }
           }
        }
    }
    
    //manage fetch data
    @objc fileprivate func Fetch() {
        ManageRefresh()
        collectionView.reloadData()
    }
    
    @objc fileprivate func ManageRefresh() {
        DescargaNewInfoUsr()
        collectionView.refreshControl = RefreshControl
        RefreshControl.endRefreshing()
    }
    
    fileprivate func DescargaNewInfoUsr() {
        DescargaUsrInfo()
    }
    
    //Download info user
    fileprivate func DescargaUsrInfo() {
        
        //get id on current session
         let uid = userId ?? (userData?.id ?? "")
         
         //Execute the process in brackground
        NetworkingServices.DownloadMainInfoUsr(uid: uid) { (user) in
            DispatchQueue.main.async {
               //accede a la info del usuario
               self.InfoUser = user
               let navBar = self.InfoUser?.username
               self.navigationItem.title = navBar
            }
        }
     }
    
    //Header settings
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //Settings header view
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header_id, for: indexPath) as! UserProfileHeader
        
        DispatchQueue.main.async {
            if #available(iOS 12, *) {
                if self.traitCollection.userInterfaceStyle == .light {
                    print("light has been detected")
                    self.collectionView.backgroundColor = .white
                    header.AdaptHeadertoLight()
               } else {
                    print("Dark has been detected")
                    header.AdaptHeadertoDark()
                    self.collectionView.backgroundColor = .black
               }
           }
        }
        
        //updating info
        self.InfoUser = userData
        
        //pass data to header view
        header.userInfoProfile = InfoUser
        
        return header
    }
    
    //define number of cells
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PostByUsr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //define to size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let with = (view.frame.width - 2) / 2
        return CGSize(width: with, height: with)
    }
    
    
    //Load all post by user in cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //re use the post pic cell
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: celdaId, for: indexPath) as! ProfilePostUsrCell
        
        celda.PostData = PostByUsr[indexPath.item]
        
        return celda
    }
    
    
    var PostByUsr = [PostModel]()

    //Download post created by user
    fileprivate func DownloadPostUsr() {

        //Access to id
        let uid = userId ?? (userData?.id ?? "")
        print("encontre esto ==>\(uid)")
        
        guard let url = URL(string: "\(serverURL)find_posts/\(uid)") else {return}
        
        NetworkingPost.getPosts(from: url) { (data, response, error) in
            //Detect any error
                if let err = error {
                    print("Oops something has been bad ==>\(err)")
                } else {
                    
                    do {
                        
                        //get data
                        guard let data = data else {return}
                        
                        //serialization data
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {return}
                        
                        //define key of objects
                        let results = json.value(forKey: "results") as! [AnyObject]
                        
                        
                        //detect if exist data
                        if !(results).isEmpty {
                            
                            //Loop to objects send from server
                            for x in results {
                                
                                //receive objects
                                let objetos = x["PostDetails"]
                                
                                //send to model
                                let newDicc = PostModel(uid: uid, diccPost: objetos as! [String : Any])
                                
                                //Assign to global var
                                postDataUsr = newDicc
                                
                                self.PostByUsr.insert(postDataUsr!, at: 0)

                                
                                self.PostByUsr.sort { (p1, p2) -> Bool in
                                    return p1.createAt.compare(p2.createAt) == .orderedDescending
                                }
                                
                                print(self.PostByUsr)
                                
                                //print("Nuevo diccionario ===>\(newDicc)")
                            }
                            
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                        
                    } catch let errorJSON {
                        print("Oops something in JSON convert has been bad ==>\(errorJSON)")
                }
            }
        }
    }
    
    //define size header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.height, height: 430)
    }
    
    //Add icon to close session btn
    fileprivate func AddLightMenu() {
        let darkIcon = UIImage(named: "menu-dark.png")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: darkIcon?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.loadMenu))
    }
    
    //Add dark menu
    fileprivate func AddDarkMenu() {
        let lightIcon = UIImage(named: "menu-light.png")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: lightIcon?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.loadMenu))
    }
    
    
    //Define bbackground temporal
    var transparentView = UIView()
    
    //Loading menu options
    @objc fileprivate func loadMenu() {
        
        //share window
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        let screenSize = UIScreen.main.bounds.size
        menuView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: height)
        window?.addSubview(menuView)
        
        //Define gesture to hide view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HideView))
        
        //Add gesture to TopBar to hide card
        menuView.topBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HideView)))
        
        //Add gesture to transparentView
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.menuView.frame = CGRect(x: 0, y: screenSize.height - self.height, width: screenSize.width, height: self.height)
        }, completion: nil)
    }
    
    //Load controller in modal
    fileprivate func ManageActionsControllers() {
        menuView.UpdateInfoContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UpdateInfo)))
        
        menuView.EditPicContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditPic)))
        
        menuView.EditPortraitContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EditPortrait)))
        
        menuView.LogoutContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(RequestLogout)))
    }
    
    //Load update info user
    @objc fileprivate func UpdateInfo() {
        let editPro = UpdateInfoUsrController()
        self.present(editPro, animated: true, completion: nil)
        HideView()
    }
    
    //Update profile pic
    @objc fileprivate func EditPic() {
        let updatePic = UpdateProfilePicController()
        self.present(updatePic, animated: true, completion: nil)
        HideView()
    }
    
    //Update portrait
    @objc fileprivate func EditPortrait() {
        let updatePic = UpdatePortraitPic()
        self.present(updatePic, animated: true, completion: nil)
        HideView()
    }
    
    @objc fileprivate func RequestLogout() {
        LogoutSession()
        HideView()
    }
    
    //Hide MenuView
    @objc func HideView() {
        let screenSize = UIScreen.main.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.menuView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.height)
        }, completion: nil)
    }
    
    //End session
    @objc fileprivate func LogoutSession() {
        
        //create alert controller
        let alertController = UIAlertController(title: "", message: "Are you sure?", preferredStyle: .actionSheet)
        
        //add action to alert
        alertController.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (_) in
            do {
                DispatchQueue.main.async {
                    
                    //delete info store on userDefaults for exit session
                    UserDefaults.standard.removeObject(forKey: "parseJSON")
                    UserDefaults.standard.synchronize()
                    
                    let loginController = SignInController()
                    let navController = UINavigationController(rootViewController: loginController)
                    navController.modalPresentationStyle = .overFullScreen
                    self.present(navController, animated: true, completion: nil)
                }
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
