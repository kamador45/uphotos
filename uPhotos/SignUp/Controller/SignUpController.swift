//
//  SignUpController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/23/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SignUpController: UIViewController {
    
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
        btn.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
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
        //btn.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        //execute all functions
        CreateGradienteBackground()
        SetObjectsView()
    }
    
    //Settings objects
    fileprivate func SetObjectsView() {
        
        //Add to main views
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
            SecondaryView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SecondaryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            SecondaryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            SecondaryView.heightAnchor.constraint(equalToConstant: view.frame.height / 2)
        ])
        
        
        //StackView firstname and lastname
        let stackView = UIStackView(arrangedSubviews: [FirstnameTxt,LastnameTxt])
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        //Add to secondary view
        SecondaryView.addSubview(stackView)
    
        //Constraint
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: SecondaryView.topAnchor, constant: 10),
            stackView.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5),
            stackView.rightAnchor.constraint(equalTo: SecondaryView.rightAnchor, constant: -5),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //stackview email
        let StackViewEmail = UIStackView(arrangedSubviews: [EmailTxt])
        StackViewEmail.axis = .vertical
        StackViewEmail.spacing = 5
        StackViewEmail.distribution = .fillEqually
        StackViewEmail.translatesAutoresizingMaskIntoConstraints = false
        
        //Add to secondary view
        SecondaryView.addSubview(StackViewEmail)
        
        //Constraint
        NSLayoutConstraint.activate([
            StackViewEmail.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5),
            StackViewEmail.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5),
            StackViewEmail.rightAnchor.constraint(equalTo: SecondaryView.rightAnchor, constant: -5),
            StackViewEmail.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //Create StackView
        let StackViewUsr = UIStackView(arrangedSubviews: [UsernameTxt, PasswordTxt])
        StackViewUsr.translatesAutoresizingMaskIntoConstraints = false
        StackViewUsr.axis = .horizontal
        StackViewUsr.distribution = .fillEqually
        StackViewUsr.spacing = 5
        
        //Add to secondary view
        SecondaryView.addSubview(StackViewUsr)
        
        //Constraint
        NSLayoutConstraint.activate([
            StackViewUsr.topAnchor.constraint(equalTo: StackViewEmail.bottomAnchor, constant: 5),
            StackViewUsr.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5),
            StackViewUsr.rightAnchor.constraint(equalTo: SecondaryView.rightAnchor, constant: -5),
            StackViewUsr.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
        //Add to Secondary View
        SecondaryView.addSubview(SignUpBtn)
        
        //Constraint
        NSLayoutConstraint.activate([
            SignUpBtn.topAnchor.constraint(equalTo: StackViewUsr.bottomAnchor, constant: 5),
            SignUpBtn.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5)
        ])
        
        //Add to Secondary View
        SecondaryView.addSubview(OrLbl)
        
        //Constraint
        NSLayoutConstraint.activate([
            OrLbl.topAnchor.constraint(equalTo: SignUpBtn.bottomAnchor, constant: 5),
            OrLbl.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5)
        ])
        
        //Add SignIn btn to secondary views
        SecondaryView.addSubview(SignInBtn)
        
        //Constraint
        NSLayoutConstraint.activate([
            SignInBtn.topAnchor.constraint(equalTo: OrLbl.bottomAnchor, constant: 5),
            SignInBtn.leftAnchor.constraint(equalTo: SecondaryView.leftAnchor, constant: 5),
        ])
    }
    
    @objc fileprivate func SignUp() {
        
        //capture safe mode the data
        guard let firstname = FirstnameTxt.text else {return}
        guard let lastname = LastnameTxt.text else {return}
        guard let email = EmailTxt.text else {return}
        guard let username = UsernameTxt.text else {return}
        guard let password = PasswordTxt.text else {return}
        
        if firstname.isEmpty || lastname.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty {
            
            //keep the process in background
            DispatchQueue.main.async {
                
                //Contiene el mensaje de error
                let mg = UILabel()
                mg.textColor = UIColor.white
                mg.textAlignment = .center
                mg.font = UIFont(name: "Avenir Next", size: 17)
                mg.text = "Oops something went wrong!"
                mg.numberOfLines = 0
                mg.layer.zPosition = 1
                mg.clipsToBounds = true
                mg.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.6)
                mg.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 8)
                
                //Se agrega a la vista
                self.view.addSubview(mg)
                
                //Proceso de animacion
                UIView.animate(withDuration: 1.5, delay: 3, options: .curveEaseOut, animations: {
                    mg.alpha = 0.0
                }, completion: { (_) in
                    mg.removeFromSuperview()
                })
            }
        } else {
            
        }
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
