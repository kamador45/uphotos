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
    
    let cell_id = "cell"
    
    //first function in load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //define gesture recognizer
        let taps = UITapGestureRecognizer(target: self, action: #selector(DetectEnviroment))
        taps.numberOfTouchesRequired = 1
        self.collectionView.addGestureRecognizer(taps)
        
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
    }
    
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
    
    //create number of item
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    //create cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //creating cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell_id, for: indexPath) as! HomeCell
        
        //Will pass data to view
        
        return cell
    }
    
    //minimun line of separate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //define hight
        var height:CGFloat = 40 + 8 + 8
        height += view.frame.width
        height += 60
        height += 60
        height += 60
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
