//
//  AppDelegate.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/23/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import UIKit

//manage data with global var
var userData:UserModel?
var postDataUsr:PostModel?
var listUsers:SearchModel?
var currentUser: NSDictionary?
var guestUser: NSDictionary?
let appDelegates: AppDelegate = UIApplication.shared.delegate as! AppDelegate
var infoViewShowing = false
var users = [UserModel]()

//global address to server
var serverURL = "http://192.168.1.166:1337/"
// "http://10.9.45.183:1337/"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //load data content send from server
        currentUser = UserDefaults.standard.value(forKey: "parseJSON") as? NSDictionary

        if currentUser != nil {
            DispatchQueue.main.async {
                let id = currentUser!["id"] as? String
                if id != nil {
                    self.CheckStatusUsr(id: id!)
                }
            }
        }
        
        //return value
        return true
    }
    
    //define the rootvViewController
    func Login() {
        let controller = MainTabBarController()
        window?.rootViewController = controller
    }
    
    //try to check if status user is active or not
    func CheckStatusUsr(id:String) {
        
        //define url
        guard let url = URL(string: "\(serverURL)status_usr/\(id)") else {return}
        
        //load networking services
        NetworkingServices.getData(from: url) { (data, response, error) in
            if let err = error {
                print("Oops something has been bad ==>\(err)")
            } else {
                do {
                    guard let data = data else {
                        return
                    }
                    
                    //gets json
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                    
                    //run every element of array
                    json?.forEach({ (data) in
                        
                        //store data
                        let state = data
                        
                        //access to value
                        guard let prueba = state as? [String:Any] else {return}
                        let x = prueba["status"] as? String
                        
                        if x != "ACTIVE" {
                            DispatchQueue.global(qos: .background).async {
                                UserDefaults.standard.removeObject(forKey: "parseJSON")
                                UserDefaults.standard.synchronize()
                            }
                        } else {
                            DispatchQueue.main.async {
                                userData = UserModel(uid: id, dict: currentUser as! [String : Any])
                                self.Login()
                            }
                        }
                    })
                    
                }
            }
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

