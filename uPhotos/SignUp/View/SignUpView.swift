//
//  SignUpView.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 1/3/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SignUpView: UIView {
    
    //Access to controller throught view
    unowned var signUpController:SignUpController? {
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
    
    let FirstnameTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Firstname"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        txt.textColor = UIColor.white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let LastnameTxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Lastname"
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 15)
        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        txt.textColor = UIColor.white
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()
    
    let EmailTxt:UITextField = {
           let txt = UITextField()
           txt.placeholder = "Email"
           txt.borderStyle = .roundedRect
           txt.font = UIFont.boldSystemFont(ofSize: 15)
           txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
           txt.textColor = UIColor.white
           txt.autocapitalizationType = .none
           txt.translatesAutoresizingMaskIntoConstraints = false
           return txt
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
    
    let SignUpBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.titleLabel?.textAlignment = .left
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(SignUpController.SignUp), for: .touchUpInside)
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
    
    let SignInBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign In", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        btn.titleLabel?.textAlignment = .left
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(SignUpController.SignIn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

   let CopyRightApp: UILabel = {
       let lbl = UILabel()
       lbl.text = "μPhotos All right reserved © 2020."
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
    
    //init view
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Execute functions
        SettingsScrollView()
        SettingsMainObjects()
        SettingsForm()
    }
    
    //Settings scrollview object
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
        
        //Hide keyword
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HideKeyword)))
    }
    
    //Settigns main objects to view
    fileprivate func SettingsMainObjects() {
        
        //Add to main view
        scrollView.addSubview(containerBrand)
        
        //detect version of iOS
        if #available(iOS 11.0, *) {
            
            //define safe area
            let guide = safeAreaLayoutGuide
            
            //Define constraint
            NSLayoutConstraint.activate([
                containerBrand.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: screenHeight/5),
                containerBrand.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                containerBrand.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                containerBrand.heightAnchor.constraint(equalToConstant: 50)
            ])
        } else {
            //define constraint
            NSLayoutConstraint.activate([
                containerBrand.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: screenHeight/5),
                containerBrand.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
                containerBrand.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
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
        
        //Add to main view
        scrollView.addSubview(CopyRightApp)
        
        //Define constraint
        NSLayoutConstraint.activate([
            CopyRightApp.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            CopyRightApp.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            CopyRightApp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])
    }
    
    //Settings Sign Up form
    fileprivate func SettingsForm() {
        
        //Add to main view
        scrollView.addSubview(containerFields)
        
        //define constraint
        NSLayoutConstraint.activate([
            containerFields.topAnchor.constraint(equalTo: containerBrand.bottomAnchor, constant: 10),
            containerFields.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            containerFields.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            containerFields.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        //create stackView
        let stackView = UIStackView(arrangedSubviews: [FirstnameTxt, LastnameTxt])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Add to secondary view
        containerFields.addSubview(stackView)
        
        //define constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerFields.topAnchor, constant: 20),
            stackView.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: containerFields.rightAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //creating second stackview
        let stackView2 = UIStackView(arrangedSubviews: [EmailTxt])
        stackView2.axis = .horizontal
        stackView2.spacing = 5
        stackView2.distribution = .fillEqually
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        
        //Add to main view
        containerFields.addSubview(stackView2)
        
        //define constraint
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            stackView2.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5),
            stackView2.rightAnchor.constraint(equalTo: containerFields.rightAnchor, constant: -5),
            stackView2.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //Creating third stackview
        let stackview3 = UIStackView(arrangedSubviews: [UsernameTxt,PasswordTxt])
        stackview3.axis = .horizontal
        stackview3.spacing = 5
        stackview3.distribution = .fillEqually
        stackview3.translatesAutoresizingMaskIntoConstraints = false

        //adding stactview third to main view
        containerFields.addSubview(stackview3)

        //define constraint
        NSLayoutConstraint.activate([
            stackview3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 5),
            stackview3.leftAnchor.constraint(equalTo: containerFields.leftAnchor, constant: 5),
            stackview3.rightAnchor.constraint(equalTo: containerFields.rightAnchor, constant: -5),
            stackview3.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //adding Sign Up button to main view
        containerFields.addSubview(SignUpBtn)

        //define constraint
        NSLayoutConstraint.activate([
            SignUpBtn.topAnchor.constraint(equalTo: stackview3.bottomAnchor, constant: 5),
            SignUpBtn.leftAnchor.constraint(equalTo: stackview3.leftAnchor, constant: 5)
        ])

        //adding msg to main view
        containerFields.addSubview(OrLbl)

        //define constraint
        NSLayoutConstraint.activate([
            OrLbl.topAnchor.constraint(equalTo: SignUpBtn.bottomAnchor, constant: 5),
            OrLbl.leftAnchor.constraint(equalTo: stackview3.leftAnchor, constant: 5),
        ])

        //adding Sign In button to main view
        containerFields.addSubview(SignInBtn)

        //define constraint
        NSLayoutConstraint.activate([
            SignInBtn.topAnchor.constraint(equalTo: OrLbl.bottomAnchor, constant: 5),
            SignInBtn.leftAnchor.constraint(equalTo: stackview3.leftAnchor, constant: 5)
        ])
    }
    
    //Setup view in controller
    fileprivate func setupView() {
        
        //disable constraint
        translatesAutoresizingMaskIntoConstraints = false
        
        //detect controller
        if let signUpController = signUpController {
            
            //Add to view
            signUpController.view.addSubview(self)
            
            //Constraint
            leftAnchor.constraint(equalTo: signUpController.view.leftAnchor, constant: 0).isActive = true
            rightAnchor.constraint(equalTo: signUpController.view.rightAnchor, constant: 0).isActive = true
            heightAnchor.constraint(equalToConstant: signUpController.view.frame.height).isActive = true
        }
    }
    
    //Hide keyword
    @objc fileprivate func HideKeyword() {
        self.endEditing(true)
    }
    
    //Observer textfield
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
