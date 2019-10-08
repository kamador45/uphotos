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
    
    //Access to model user
    var InfoUser: UserModel?
    
    //receive id user
    var userId:String?
    
    //header id
    let header_id = "header"
    let celdaId = "CeldaId"
    
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
        
        //register view on controller
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header_id)
        
        //register cell
        collectionView.register(ProfilePostUsrCell.self, forCellWithReuseIdentifier: celdaId)
        
        //call functions
        DescargaNewInfoUsr()
        BtnLogOut()
    }
    
    //Chance enviroment when dark or light has been detected
    @objc fileprivate func DetectEnviroment() {
        DispatchQueue.main.async {
            if #available(iOS 12, *) {
                if self.traitCollection.userInterfaceStyle == .light {
                    print("light has been detected")
                    self.collectionView.backgroundColor = .white
               } else {
                    print("Dark has been detected")
                    self.collectionView.backgroundColor = .black
               }
           }
        }
    }
    
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
               print(user)
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
        return 7
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //re use the post pic cell
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: celdaId, for: indexPath) as! ProfilePostUsrCell
        
        return celda
    }
    
    //define size header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.height, height: 430)
    }
    
    //Add icon to close session btn
    fileprivate func BtnLogOut() {
        
        let img = UIImage(named: "logout.png")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: img?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(LogoutSession))
    }
    
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
