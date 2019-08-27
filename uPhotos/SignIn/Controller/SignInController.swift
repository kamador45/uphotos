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
        
        //hidden navigationbar
        navigationController?.isNavigationBarHidden = true
        
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
        
        guard let username = UsernameTxt.text else {return}
        guard let password = PasswordTxt.text else {return}
        
        if username.isEmpty || password.isEmpty {
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
            //Process for to Sign Up
            guard let url = URL(string: "http://localhost:1337/sign_in/") else { return }
            
            //start request
            let request = NSMutableURLRequest(url: url)
            
            //define method
            request.httpMethod = "POST"
            
            //define body
            let body = "username=\(username)&password=\(password)"
            request.httpBody = body.data(using: .utf8)
            
            //start session
            let session = URLSession.shared
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                //capture data send from server
                guard let data = data else {return}
                
                //detect some errors
                if let err = error {
                    print("Something go mad ==> \(err)")
                } else {
                    
                    do {
                        
                        //serialization
                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                        
                        //store all json data in model 
                        guard let parseJSON = UserModel(dict: json as! [String : Any]) else {
                            print("Error to parse data")
                            return
                        }
                        
                        //access to object
                        let id = parseJSON.id
                        
                        //detect if exist some data
                        if id != nil {
                            print("I found this data ==>\(id)")
                            
                            //keep process on background
                            DispatchQueue.main.async {
                                
                                //encode objects receive from server
                                UserDefaults.standard.set(try? PropertyListEncoder().encode(parseJSON), forKey: "parseJSON")
                                
                                //convert data to object
                                guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}
                                
                                //decode and insert all data in model
                                guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}
                                
                                //Store all info in global var
                                userData = userInfo
                            }
                            
                            DispatchQueue.main.async {
                                guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                                mainTabBarController.SetupController()
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                        } else {
                            
                        }
                        
                    } catch let errorParse {
                        print("error to parse JSON ==> \(errorParse)")
                    }
                }
            }
            task.resume()
        }
    }
    
    
    //load SignUp view
    @objc fileprivate func SignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
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

