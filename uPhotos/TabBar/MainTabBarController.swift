//
//  MainTabBarController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //First function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        //Execute functions
        SetupController()

        //execute animate function
        AnimateBrand()
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = tabBarController.viewControllers?.firstIndex(of: viewController)
        
        //detect number of index
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let uploadController = UploadPicController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: uploadController)
            
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    
    //Setup Controller and detect the session
    func SetupController() {
        
        //getting id user from session
        let id = userData?.id
        
        //Detect if user it is log in !(userInfo.id).isEmpty
        if id != nil {
            
            DispatchQueue.main.async {
                //gets username in session
                let username = currentUser!["username"] as! String
                //message
                let message = "Welcome" +  " " + username
                //show welcome message
                InfoViewEvent.ShowingMessage(message: message, color: .systemGreen)
            }
            
            //Home Controller
            let homeNavController = self.TemplateControllers(unselected: #imageLiteral(resourceName: "home_unselected.png"), selected: #imageLiteral(resourceName: "home_selected.png"), rootViewController: HomeFeedController(collectionViewLayout: UICollectionViewFlowLayout()))
            
            //Search Controller
            let searchNavController = self.TemplateControllers(unselected: #imageLiteral(resourceName: "search_unselected.png"), selected: #imageLiteral(resourceName: "search_selected.png"), rootViewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()))
            
            //Upload Controller
            guard let un_selected = UIImage(named: "gallery_unselected.png") else {return}
            guard let selected = UIImage(named: "gallery_selected.png") else {return}
            let uploadNavController = self.TemplateControllers(unselected: un_selected, selected: selected)
            
            //Notify Controller
            let notifyNavController = self.TemplateControllers(unselected: #imageLiteral(resourceName: "notify_unselected.png"), selected: #imageLiteral(resourceName: "notify_selected.png"), rootViewController: NotifyController(collectionViewLayout: UICollectionViewFlowLayout()))
            
            //Carga el controlador y se inicializa el collectionview
            let layout = UICollectionViewFlowLayout()
            let userProfileController = UserProfileController(collectionViewLayout: layout)
            
            //User Profile Controller
            let UserProfilenavController = UINavigationController(rootViewController: userProfileController)
            
            //Carga icono sin seleccionar
            let img = UIImage(named: "profile_unselected")
            UserProfilenavController.tabBarItem.image = img
            
            //Carga icono seleccionado
            UserProfilenavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected.png")
            
            //settings controller
            
            //define color
            self.tabBar.tintColor = .systemPink
            
            //storage all controllers
            self.viewControllers = [homeNavController,
                                    searchNavController,
                                    uploadNavController,
                                    notifyNavController,
                                    UserProfilenavController]
            
            //set icons
            guard let items = self.tabBar.items else { return }
            
            //run every items
            for item in items {
                item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
            }
            
        } else {
            DispatchQueue.main.async {
                let SignController = SignInController()
                let NavController = UINavigationController(rootViewController: SignController)
                NavController.modalPresentationStyle = .overFullScreen
                self.present(NavController, animated: true, completion: nil)
            }
            
            return
        }
    }
    
    //creating animation to tab bar
    func AnimateBrand() {
        
        //red layer
        let layer = UIView()
        layer.frame = self.view.frame
        layer.backgroundColor = .systemRed
        self.view.addSubview(layer)
        
        //logotipo of app
        let logo = UIImageView()
        logo.image = UIImage(named: "mupics.png")
        logo.frame.size.width = 100
        logo.frame.size.height = 100
        logo.center = view.center
        self.view.addSubview(logo)
        
        //creating animation
        UIView.animate(withDuration: 0.5, delay: 2, options: .curveLinear, animations: {
            logo.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        }) { (finished:Bool) in
            if finished {
                UIView.animate(withDuration: 0.5) {
                    logo.transform = CGAffineTransform.init(scaleX: 20, y: 20)
                    UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
                        logo.alpha = 0
                        layer.alpha = 0
                    }, completion: nil)
                }
            }
        }
    }
    
    
    //template controller for tabbar
    fileprivate func TemplateControllers(unselected: UIImage, selected:UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected
        
        return navController
    }
}
