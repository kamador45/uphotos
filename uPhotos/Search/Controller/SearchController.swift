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
    
    
    //Arrays to users
    var filterUsers = [UserModel]()
    var users = [UserModel]()
    
    //Gets all user
    fileprivate func ListAllUsers() {
        
        //define url
        guard let url = URL(string: "\(serverURL)list_users/") else {return}
        
        //network process
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //detect any error
            if let err = error {
                print("Oops something has been result bad ==>\(err)")
            } else {
                
                do {
                    //data
                    guard let data = data else {return}
                
                    //cast to json
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [NSDictionary]
                    
                    //running every value and key
                    json?.forEach({ (data) in
                        
                        //gets data
                        let key = data
                        
                        //capture id key
                        guard let id = key["id"] as? String else {return}
                        
                        //compare current user in session
                        if userData?.id == id {
                            print("usuario en sesion encontrado ==>\(userData?.id ?? "")")
                            return
                        }
                        
                        //creating new dictionary
                        let listUsers = UserModel(uid: id, dict: key as! [String : Any] )
                        print(listUsers)
                        self.users.append(listUsers)
                    })
                    
                    print(self.users)
                    
                    //sorting users
                    self.users.sort { (u1, u2) -> Bool in
                        return u1.username.compare(u2.username) == .orderedAscending
                    }
                    
                    //assign value to new array
                    self.filterUsers = self.users

                    //reload collection view
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch let errorJSON {
                    print("Oops something has been result bad with JSON ==>\(errorJSON)")
                }
            }
        
            
        }.resume()
    }
    
    //settings collectionview cell
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterUsers.count
    }
    
    //define indexpath
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Access to cell
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: celda_id, for: indexPath) as! SearchUsrCell
        
        celda.usersList = filterUsers[indexPath.item]
        
        //return cell
        return celda
    }
    
    //Detect items selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Access to item position
        let itemSelected = filterUsers[indexPath.item]
        print(itemSelected.id)
        
        let idUser = itemSelected.id
        guard let currentId = userData?.id else {return}
        
        if (idUser == currentId) {
            print("Usuario en session ==.\(currentId)")
            print(itemSelected)
        } else {
            print("Los id son diferentes")
            print(itemSelected)
            //Loading home controller of guest user
            
        }
        
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
            filterUsers = users
        } else {
            filterUsers = self.users.filter({ (user) -> Bool in
                return user.username.lowercased().contains(text.lowercased())
            })
        }
        
        self.collectionView.reloadData()
    }
}
