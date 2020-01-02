//
//  UploadPicController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/24/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit
import Photos

class UploadPicController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //id objects
    let celda_id = "celda_id"
    let header_id = "header_id"
    
    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register classes
        collectionView.register(CellPics.self, forCellWithReuseIdentifier: celda_id)
        collectionView.register(HeaderPics.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header_id)
        
        //execute all functions
        DetectEnviroment()
        CreateOptionsNavBar()
        DownloadAllPictures()
    }
    
    //Detect environment
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
    
    //create options navbar
    fileprivate func CreateOptionsNavBar() {
        
        //Define color
        navigationController?.navigationBar.tintColor = .systemPink
        
        //create cancel button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Cancel))
        
        //create next button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(SetupPost))
    }
    
    //Detect selected item
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.ImageSelected = ImageArray[indexPath.item]
        
        self.collectionView.reloadData()
        
        let indexPath = IndexPath(item: 0, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    //reference to assets
    var assets = [PHAsset]()
    
    //reference to image selected
    var ImageSelected: UIImage?
    
    //Create array of images
    var ImageArray = [UIImage]()
    
    //Download all picture from your library
    fileprivate func DownloadAllPictures() {
        
        //Load status
        let status = PHPhotoLibrary.authorizationStatus()
        
        if status == .notDetermined {
            //check permission
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.6) {
                    self.LoadPhotos()
                }
            }
        } else if status == .denied {
            let alert = UIAlertController(title: "Photos", message: "Would like to access to your photos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            
            //Load settings app
            self.present(alert, animated: true, completion: nil)
        } else if status == .authorized {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.6) {
                    self.LoadPhotos()
                }
            }
        } else {
            let alert = UIAlertController(title: "Check", message: "Check your permissions", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
            
            //Load settings app
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Load all photos
    fileprivate func LoadPhotos() {
        //define manager
        let imgManager = PHImageManager.default()
        
        //define mode of request
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        //define size
        let targetSize = CGSize(width: 200, height: 200)
        
        //define options to assets
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        //check data from carrete
        if let fetchResults: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            //check that to it major of zero
            if fetchResults.count > 0 {
                for i in 0..<fetchResults.count {
                    let assets = fetchResults.object(at: i)

                    imgManager.requestImage(for: fetchResults.object(at: i), targetSize: targetSize, contentMode: .aspectFit, options: requestOptions) { (image, err) in
                        if let images = image {
                            //insert object in assets array
                            self.assets.append(assets)
                            self.ImageArray.append(images)

                            if self.ImageSelected == nil {
                                self.ImageSelected = images
                            }

                            self.collectionView.reloadData()
                        }
                    }
                }
            } else {
                print("not picture found")
                DownloadAllPictures()
                self.collectionView.reloadData()
            }
        }
    }
    
    //number of items
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: celda_id, for: indexPath) as! CellPics
        
        //load all picture stored in array in new cell
        celda.PhotoView.image = ImageArray[indexPath.item]
        
        //return cell
        return celda
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 2) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    //reference to picture show in header
    var header: HeaderPics?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header_id, for: indexPath) as! HeaderPics
        
        self.header = header
        
        //load picture in header
        header.PhotoView.image = ImageSelected
        
        if let selectedImages = ImageSelected {
            if let index = self.ImageArray.firstIndex(of: selectedImages) {
                
                //Access to assets objects
                let selecteAssets = self.assets[index]
                let targetSize = CGSize(width: 600, height: 600)
                let managerImage = PHImageManager.default()
                
                //try to get objects
                managerImage.requestImage(for: selecteAssets, targetSize: targetSize, contentMode: .aspectFit, options: nil) { (images, info) in
                    header.PhotoView.image = images
                }
            }
        }
        
        return header
    }
    
    //setup details
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    //Load CreatePostController
    @objc fileprivate func SetupPost() {
        //Hold controller
        let createPostController = CreatePostController()
        
        //Load selected image send from header view
        createPostController.ImageToPost = header?.PhotoView.image
        
        //load controller
        navigationController?.pushViewController(createPostController, animated: true)
    }
    
    //Cancel options
    @objc fileprivate func Cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}
