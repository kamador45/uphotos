//
//  MenuView.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/22/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class MenuView: UIView {
    
    //add top bar
    let topBar: UIView = {
        let tb = UIView()
        tb.backgroundColor = .lightGray
        tb.layer.cornerRadius = 4
        tb.clipsToBounds = true
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    let container:UIView = {
       let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let MsgLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor.lightGray
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //Edit profile
    let iconUsr: UIImageView = {
        let img = UIImage(named: "user-dark.png")
        let iv = UIImageView(image: img)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let MsgUpdateInfo: UILabel = {
        let lbl = UILabel()
        lbl.text = "Edit profile"
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    let UpdateInfoContainer: UIView = {
        let uv = UIView()
        uv.isUserInteractionEnabled = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    //Edit Profile picture
    let EditPic: UIImageView = {
        let img = UIImage(named: "camera-dark.png")
        let iv = UIImageView(image: img)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let MsgEditPic: UILabel = {
        let lbl = UILabel()
        lbl.text = "Profile Pic"
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    let EditPicContainer: UIView = {
        let uv = UIView()
        uv.isUserInteractionEnabled = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    //Edit Portrait picture
    let EditPortrait: UIImageView = {
        let img = UIImage(named: "portrait-dark.png")
        let iv = UIImageView(image: img)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let MsgEditPortrait: UILabel = {
        let lbl = UILabel()
        lbl.text = "Portrait Pic"
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    let EditPortraitContainer: UIView = {
        let uv = UIView()
        uv.isUserInteractionEnabled = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    //Logout btn
    let LogoutIcon: UIImageView = {
        let img = UIImage(named: "logout.png")
        let iv = UIImageView(image: img)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let MsgLogout: UILabel = {
        let lbl = UILabel()
        lbl.text = "Logout"
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    let LogoutContainer: UIView = {
        let uv = UIView()
        uv.isUserInteractionEnabled = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    //First function on load
    override init(frame: CGRect) {
        super.init(frame: frame)
        //execute function
        backgroundColor = .white
        SettingsObjects()
        LoadMenu()
    }
    
    
    //Settings objects
    fileprivate func SettingsObjects() {
        //add to view
        addSubview(topBar)
        
        //define constraint
        NSLayoutConstraint.activate([
            topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            topBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            topBar.widthAnchor.constraint(equalToConstant: 50),
            topBar.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 10),
            container.leftAnchor.constraint(equalTo: leftAnchor),
            container.rightAnchor.constraint(equalTo: rightAnchor),
            container.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        container.addSubview(MsgLabel)
        
        NSLayoutConstraint.activate([
            MsgLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            MsgLabel.leftAnchor.constraint(equalTo: container.leftAnchor),
            MsgLabel.rightAnchor.constraint(equalTo: container.rightAnchor)
        ])
        
        //line separator
        let Separator = UIView()
        Separator.backgroundColor = UIColor.lightGray
        Separator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(Separator)
        
        NSLayoutConstraint.activate([
            Separator.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 0),
            Separator.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            Separator.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            Separator.heightAnchor.constraint(equalToConstant: 0.6)
        ])
        
        //constainer update info
        addSubview(UpdateInfoContainer)
        
        //define constraint
        NSLayoutConstraint.activate([
            UpdateInfoContainer.topAnchor.constraint(equalTo: Separator.bottomAnchor, constant: 0),
            UpdateInfoContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            UpdateInfoContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            UpdateInfoContainer.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //add to view
        UpdateInfoContainer.addSubview(iconUsr)
        
        //define constraint
        NSLayoutConstraint.activate([
            iconUsr.centerYAnchor.constraint(equalTo: UpdateInfoContainer.centerYAnchor),
            iconUsr.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            iconUsr.widthAnchor.constraint(equalToConstant: 30),
            iconUsr.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        //add to view
        UpdateInfoContainer.addSubview(MsgUpdateInfo)
        
        //define constraint
        NSLayoutConstraint.activate([
            MsgUpdateInfo.centerYAnchor.constraint(equalTo: iconUsr.centerYAnchor, constant: 0),
            MsgUpdateInfo.leftAnchor.constraint(equalTo: iconUsr.rightAnchor, constant: 10),
        ])
        
        //line separator
        let Separator2 = UIView()
        Separator2.backgroundColor = UIColor.lightGray
        Separator2.translatesAutoresizingMaskIntoConstraints = false

        //add to view
        addSubview(Separator2)

        NSLayoutConstraint.activate([
            Separator2.topAnchor.constraint(equalTo: UpdateInfoContainer.bottomAnchor, constant: 0),
            Separator2.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            Separator2.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            Separator2.heightAnchor.constraint(equalToConstant: 0.6)
        ])
        
        //Add to main view
        addSubview(EditPicContainer)
        
        //Define constraint
        NSLayoutConstraint.activate([
            EditPicContainer.topAnchor.constraint(equalTo: Separator2.bottomAnchor),
            EditPicContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            EditPicContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            EditPicContainer.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //add to view
        EditPicContainer.addSubview(EditPic)
        
        //define constraint
        NSLayoutConstraint.activate([
            EditPic.centerYAnchor.constraint(equalTo: EditPicContainer.centerYAnchor),
            EditPic.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            EditPic.widthAnchor.constraint(equalToConstant: 30),
            EditPic.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        //add to view
        EditPicContainer.addSubview(MsgEditPic)
        
        //define constraint
        NSLayoutConstraint.activate([
            MsgEditPic.centerYAnchor.constraint(equalTo: EditPic.centerYAnchor),
            MsgEditPic.leftAnchor.constraint(equalTo: EditPic.rightAnchor, constant: 10)
        ])
        
        //line separator
        let Separator3 = UIView()
        Separator3.backgroundColor = UIColor.lightGray
        Separator3.translatesAutoresizingMaskIntoConstraints = false

        //add to view
        addSubview(Separator3)

        NSLayoutConstraint.activate([
            Separator3.topAnchor.constraint(equalTo: EditPicContainer.bottomAnchor, constant: 0),
            Separator3.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            Separator3.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            Separator3.heightAnchor.constraint(equalToConstant: 0.6)
        ])
        
        //add to view
        addSubview(EditPortraitContainer)
        
        //define constraint
        NSLayoutConstraint.activate([
            EditPortraitContainer.topAnchor.constraint(equalTo: Separator3.bottomAnchor, constant: 0),
            EditPortraitContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            EditPortraitContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            EditPortraitContainer.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //add to view
        EditPortraitContainer.addSubview(EditPortrait)
        
        //define constraint
        NSLayoutConstraint.activate([
            EditPortrait.centerYAnchor.constraint(equalTo: EditPortraitContainer.centerYAnchor),
            EditPortrait.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            EditPortrait.widthAnchor.constraint(equalToConstant: 30),
            EditPortrait.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        //add to view
        EditPortraitContainer.addSubview(MsgEditPortrait)
        
        //define constraint
        NSLayoutConstraint.activate([
            MsgEditPortrait.centerYAnchor.constraint(equalTo: EditPortrait.centerYAnchor),
            MsgEditPortrait.leftAnchor.constraint(equalTo: EditPortrait.rightAnchor, constant: 10)
        ])
        
        //line separator
        let Separator4 = UIView()
        Separator4.backgroundColor = UIColor.lightGray
        Separator4.translatesAutoresizingMaskIntoConstraints = false

        //add to view
        addSubview(Separator4)

        NSLayoutConstraint.activate([
            Separator4.topAnchor.constraint(equalTo: EditPortraitContainer.bottomAnchor, constant: 0),
            Separator4.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            Separator4.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            Separator4.heightAnchor.constraint(equalToConstant: 0.6)
        ])
        
        //Logout
        //add to view
        addSubview(LogoutContainer)
        
        //define constraint
        NSLayoutConstraint.activate([
            LogoutContainer.topAnchor.constraint(equalTo: Separator4.bottomAnchor, constant: 0),
            LogoutContainer.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            LogoutContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            LogoutContainer.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        //add to view
        LogoutContainer.addSubview(LogoutIcon)
        
        //define constraint
        NSLayoutConstraint.activate([
            LogoutIcon.centerYAnchor.constraint(equalTo: LogoutContainer.centerYAnchor),
            LogoutIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            LogoutIcon.widthAnchor.constraint(equalToConstant: 30),
            LogoutIcon.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        //add to view
        LogoutContainer.addSubview(MsgLogout)
        
        //define constraint
        NSLayoutConstraint.activate([
            MsgLogout.centerYAnchor.constraint(equalTo: LogoutIcon.centerYAnchor),
            MsgLogout.leftAnchor.constraint(equalTo: LogoutIcon.rightAnchor, constant: 10)
        ])
        
        //line separator
        let Separator5 = UIView()
        Separator5.backgroundColor = UIColor.lightGray
        Separator5.translatesAutoresizingMaskIntoConstraints = false

        //add to view
        addSubview(Separator5)

        NSLayoutConstraint.activate([
            Separator5.topAnchor.constraint(equalTo: LogoutContainer.bottomAnchor, constant: 0),
            Separator5.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            Separator5.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            Separator5.heightAnchor.constraint(equalToConstant: 0.6)
        ])
        
    }
    
    //Pass info to card
    fileprivate func LoadMenu() {
        let username = currentUser!["username"] as? String
        MsgLabel.text = "Hey \(username ?? "")!"
    }
    
    //set round corners
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.topLeft, .topRight], radius: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
