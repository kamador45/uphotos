//
//  SignInView.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 10/27/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SignInView: UIView {
    
    //Access to controller throught view
    unowned var signInController:SignInController? {
        didSet {
            DispatchQueue.main.async {
                self.setupView()
            }
        }
    }
    
    //Access to screen
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    //Create objects
    let brandApp: UILabel = {
        let lbl = UILabel()
        lbl.text = "μPhotos"
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 40)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let UsernameTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Username"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.autocapitalizationType = .none
        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        txt.textColor = UIColor.white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let PasswordTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Password"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.autocapitalizationType = .none
        txt.isSecureTextEntry = true
        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        txt.textColor = UIColor.white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let SignInBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign In", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.titleLabel?.textAlignment = .left
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(SignInController.SignIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let OrLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Or"
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let SignUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.titleLabel?.textAlignment = .left
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(SignInController.SignUp), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    let CopyRightApp: UILabel = {
        let lbl = UILabel()
        lbl.text = "μPhotos All right reserved © 2019."
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isUserInteractionEnabled = true
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    let containerBrand: UIView = {
        let uv = UIView()
        uv.isUserInteractionEnabled = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()

    let containerFields: UIView = {
        let uv = UIView()
        uv.isUserInteractionEnabled = true
        uv.translatesAutoresizingMaskIntoConstraints = false
        return uv
    }()
    
    //Init services
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Execute functions
        SettingsScrollView()
        SettingsMainObjects()
        SettingsForm()
    }
    
    //Setup view in controller
    fileprivate func setupView() {
        
        //disable constraint
        translatesAutoresizingMaskIntoConstraints = false
        
        //detect controller
        if let signInController = signInController {
            signInController.view.addSubview(self)
            leftAnchor.constraint(equalTo: signInController.view.leftAnchor, constant: 0).isActive = true
            rightAnchor.constraint(equalTo: signInController.view.rightAnchor, constant: 0).isActive = true
            heightAnchor.constraint(equalToConstant: signInController.view.frame.height).isActive = true
        }
    }
    
    //Settings ScrollView Object
    fileprivate func SettingsScrollView() {
        
        //Add to main view
        addSubview(scrollView)
        
        //define constraint
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            scrollView.heightAnchor.constraint(equalToConstant: screenHeight)
        ])
        
        //hide keyword
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HideKeyword)))
    }
    
    //Settings main objects in view
    fileprivate func SettingsMainObjects() {
        
        //Add to main view
        scrollView.addSubview(containerBrand)
        
        //detect ios version
        if #available(iOS 11.0, *) {
            let guide = safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                containerBrand.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: screenHeight/5),
                containerBrand.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                containerBrand.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                containerBrand.heightAnchor.constraint(equalToConstant: 50)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerBrand.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: screenHeight/5),
                containerBrand.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
                containerBrand.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
                containerBrand.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        //Add to main view
        containerBrand.addSubview(brandApp)
        
        //Constraint
        NSLayoutConstraint.activate([
            brandApp.centerYAnchor.constraint(equalTo: containerBrand.centerYAnchor),
            brandApp.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            brandApp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])
        
        //add to main view
        scrollView.addSubview(CopyRightApp)

        NSLayoutConstraint.activate([
            CopyRightApp.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            CopyRightApp.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            CopyRightApp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
        ])
    }
    
    //Settings Sign In form
    fileprivate func SettingsForm() {
        
        //add to main view
        scrollView.addSubview(containerFields)
        
        //Create StackView
        let stackView = UIStackView(arrangedSubviews: [UsernameTxt, PasswordTxt])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10

        //Add to secondary view
        containerFields.addSubview(stackView)

        //Constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerFields.topAnchor, constant: 40),
            stackView.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: containerFields.rightAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        //Add SignIn btn to secondary views
        containerFields.addSubview(SignInBtn)

        //Constraint
        NSLayoutConstraint.activate([
            SignInBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            SignInBtn.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5),
        ])

        //Add to Secondary View
        containerFields.addSubview(OrLbl)

        //Constraint
        NSLayoutConstraint.activate([
            OrLbl.topAnchor.constraint(equalTo: SignInBtn.bottomAnchor, constant: 5),
            OrLbl.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5)
        ])

        //Add to Secondary View
        containerFields.addSubview(SignUpBtn)

        //Constraint
        NSLayoutConstraint.activate([
            SignUpBtn.topAnchor.constraint(equalTo: OrLbl.bottomAnchor, constant: 5),
            SignUpBtn.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5)
        ])
        
        //detect ios version
        if #available(iOS 11.0, *) {
            //define constraint
            NSLayoutConstraint.activate([
                containerFields.topAnchor.constraint(equalTo: containerBrand.bottomAnchor, constant: 5),
                containerFields.leftAnchor.constraint(equalTo: containerBrand.leftAnchor, constant: 0),
                containerFields.rightAnchor.constraint(equalTo: containerBrand.rightAnchor, constant: 0),
                containerFields.heightAnchor.constraint(equalToConstant: 330),
            ])
        } else {
            //define constraint
            NSLayoutConstraint.activate([
                containerFields.topAnchor.constraint(equalTo: containerBrand.bottomAnchor, constant: 5),
               containerFields.leftAnchor.constraint(equalTo: containerBrand.leftAnchor, constant: 0),
               containerFields.rightAnchor.constraint(equalTo: containerBrand.rightAnchor, constant: 0),
               containerFields.heightAnchor.constraint(equalToConstant: 330)
            ])
        }
    }
    
    //Hide Keyword
    @objc fileprivate func HideKeyword() {
        self.endEditing(true)
    }
    
    //observer textfield
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //Helper to find some errors
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
