//
//  ViewController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/23/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import UIKit

class SignInController: UIViewController, UITextFieldDelegate {
    
    //Settings all objects on view
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
        btn.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
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
        btn.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
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
    

    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Define background color
        view.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        
        //define delegate
        UsernameTxt.delegate = self
        UsernameTxt.tag = 0
        PasswordTxt.delegate = self
        PasswordTxt.tag = 1
        
        //Execute functions
        CreateGradienteBackground()
        SetObjectsView()
    }
    
    //Set main objects
    fileprivate func SetObjectsView() {
        
        //Add to main view
        view.addSubview(brandApp)
        view.addSubview(CopyRightApp)
        
        //Constraint
        NSLayoutConstraint.activate([
            brandApp.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height / 5),
            brandApp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            brandApp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            CopyRightApp.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            CopyRightApp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            CopyRightApp.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
        ])
        
        //Create secondary view
        let SecondaryView = UIView()
        SecondaryView.translatesAutoresizingMaskIntoConstraints = false
        
        //add to main view
        view.addSubview(SecondaryView)
        
        //Constraint View
        NSLayoutConstraint.activate([
            SecondaryView.topAnchor.constraint(equalTo: brandApp.bottomAnchor, constant: 20),
            SecondaryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            SecondaryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            SecondaryView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        
        //Create StackView
        let stackView = UIStackView(arrangedSubviews: [UsernameTxt, PasswordTxt])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        //Add to secondary view
        SecondaryView.addSubview(stackView)
        
        //Constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: SecondaryView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: SecondaryView.rightAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        //Add SignIn btn to secondary views
        SecondaryView.addSubview(SignInBtn)
        
        //Constraint
        NSLayoutConstraint.activate([
            SignInBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            SignInBtn.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5),
        ])
        
        //Add to Secondary View
        SecondaryView.addSubview(OrLbl)
        
        //Constraint
        NSLayoutConstraint.activate([
            OrLbl.topAnchor.constraint(equalTo: SignInBtn.bottomAnchor, constant: 5),
            OrLbl.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5)
        ])
        
        //Add to Secondary View
        SecondaryView.addSubview(SignUpBtn)
        
        //Constraint
        NSLayoutConstraint.activate([
            SignUpBtn.topAnchor.constraint(equalTo: OrLbl.bottomAnchor, constant: 5),
            SignUpBtn.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5)
        ])
    }
    
    //Create backgroundColor grandient
    fileprivate func CreateGradienteBackground() {
        let grandient:CAGradientLayer = CAGradientLayer()
        grandient.frame.size = self.view.frame.size
        grandient.startPoint = CGPoint(x: -0.0, y: 0.6)
        grandient.endPoint = CGPoint(x: 0.8, y: -0.0)
        grandient.colors = [UIColor.red.withAlphaComponent(8).cgColor, UIColor.white.withAlphaComponent(0.5).cgColor]
        self.view.layer.addSublayer(grandient)
    }
    
    //Sign In user
    @objc fileprivate func SignIn() {
        print("Hola")
    }
    
    //Load Sign Up View
    @objc fileprivate func SignUp() {
        print("Hola :)")
    }
    
    //Active return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = PasswordTxt.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            next?.resignFirstResponder()
        }
        
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

