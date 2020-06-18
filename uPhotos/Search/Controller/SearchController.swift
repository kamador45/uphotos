//
//  SearchController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //id cell
    let celda_id = "CeldaId"
    
    //first function in load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register cell class
        collectionView.register(SearchUsrCell.self, forCellWithReuseIdentifier: celda_id)
        
        //hide keyboard
        collectionView.keyboardDismissMode = .onDrag
        
        //define scroll
        collectionView.alwaysBounceVertical = true
        
        //hide searchbar when user load another controller
        definesPresentationContext = true
        
        //Execute all function
        DetectEnviroment()
        ListAllUsers()
        SearchNavBar()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Add to main view
         if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.title = "Find Users"
            self.collectionView.contentInsetAdjustmentBehavior = .automatic
         } else {
            navigationController?.navigationItem.title = "Find Users"
        }
    }
    
    
    //Settings SearchBar
    func SearchNavBar() {
        //Search bar
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Find Users"
        search.searchBar.autocapitalizationType = .none
        if #available(iOS 11.0, *) {
            navigationItem.searchController = search
        }
    }
    
    //references
    var filterUsrs = [UserModel]()
    var users = [UserModel]()
    
    //load all users
    fileprivate func ListAllUsers() {
        print(users)
        print(filterUsrs)
        
        //reference to download users
        guard let url = URL(string: "\(serverURL)list_users/") else {return}
        
        print(url)
        
        //networking services
        NetworkingSearch.getData(from: url) { (data, response, error) in
            //detect if exist error
            if let err = error {
                print("Oops something has been wrong ==>\(err)")
            } else {
                do {
                    //gets data
                    guard let data = data else {return}
                    
                    //gets json and create dictionary
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                    
                    //run objects
                    json?.forEach({ (data) in
                        
                        //Access to key
                        let key = data
                        
                        //gets id user
                        guard let id = key["id"] as? String else {return}
                        
                        //avoid user connected appear in UI
                        if id == userData?.id {
                            print("Se encontro al usuario en session")
                            return
                        }
                        
                        //create dictionary
                        guard let dict = key as? [String:Any] else {return}
                        
                        //Store info of user model
                        let user = UserModel(uid: id, dict: dict)
                        
                        //insert data in array
                        self.users.append(user)
                    })
                    
                    //sort users
                    self.users.sort { (u1, u2) -> Bool in
                        return u1.username.compare(u2.username) == .orderedAscending
                    }
                    
                    //store all users in array filter to do searchs
                    self.filterUsrs = self.users
                    
                    //reload collectionview
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch let errorJSON {
                    print("Oops error with errorJSON ==>\(errorJSON)")
                }
            }
        }
        
    }
    
    //settings collectionview cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterUsrs.count
    }
    
    //define indexpath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Access to cell
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: celda_id, for: indexPath) as! SearchUsrCell
        
        //showing list users
        celda.usersList = filterUsrs[indexPath.item]
        
        //return cell
        return celda
    }
    
    //Detect items selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //get user selected
        let userSelected = filterUsrs[indexPath.item]
        print(userSelected)
        
        //Init collectionview controller
        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        
        //access to id of user selected
        userProfileController.userId = userSelected.id
        
        //load controller
        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    //Settings cells of collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //define size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 65)
    }
    
    //define space between cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

//Extension to make search of users
extension SearchController: UISearchResultsUpdating {
    
    //update interface and make the filter
    func updateSearchResults(for searchController: UISearchController) {
        //capture text
        guard let text = searchController.searchBar.text else {return}
        
        //Detect if exist any data
        if text.isEmpty {
            filterUsrs = users
            print(filterUsrs)
        } else {
            filterUsrs = users.filter({ (user) -> Bool in
                return user.username.lowercased().contains(text.lowercased())
            })
        }
        
        //reload collection view
        self.collectionView.reloadData()
    }
}
