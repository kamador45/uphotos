//
//  SignUpController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/23/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class SignUpController: UIViewController, UITextFieldDelegate {
    
    //Access to view
    let signUpView: SignUpView = {
        let sv = SignUpView()
        return sv
    }()
    
    //Settings all objects on view
//    let brandApp: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "μPhotos"
//        lbl.textColor = UIColor.white
//        lbl.textAlignment = .center
//        lbl.font = UIFont.boldSystemFont(ofSize: 40)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
//    let FirstnameTxt:UITextField = {
//        let txt = UITextField()
//        txt.placeholder = "Firstname"
//        txt.borderStyle = .roundedRect
//        txt.font = UIFont.boldSystemFont(ofSize: 15)
//        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        txt.textColor = UIColor.white
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        return txt
//    }()
//
//    let LastnameTxt:UITextField = {
//        let txt = UITextField()
//        txt.placeholder = "Lastname"
//        txt.borderStyle = .roundedRect
//        txt.font = UIFont.boldSystemFont(ofSize: 15)
//        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        txt.textColor = UIColor.white
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        return txt
//    }()
//
//    let EmailTxt:UITextField = {
//        let txt = UITextField()
//        txt.placeholder = "Email"
//        txt.borderStyle = .roundedRect
//        txt.font = UIFont.boldSystemFont(ofSize: 15)
//        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        txt.textColor = UIColor.white
//        txt.autocapitalizationType = .none
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        return txt
//    }()
//
//    let UsernameTxt:UITextField = {
//        let txt = UITextField()
//        txt.placeholder = "Username"
//        txt.borderStyle = .roundedRect
//        txt.font = UIFont.boldSystemFont(ofSize: 15)
//        txt.autocapitalizationType = .none
//        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        txt.textColor = UIColor.white
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        return txt
//    }()
//
//    let PasswordTxt:UITextField = {
//        let txt = UITextField()
//        txt.placeholder = "Password"
//        txt.borderStyle = .roundedRect
//        txt.font = UIFont.boldSystemFont(ofSize: 15)
//        txt.autocapitalizationType = .none
//        txt.isSecureTextEntry = true
//        txt.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
//        txt.textColor = UIColor.white
//        txt.translatesAutoresizingMaskIntoConstraints = false
//        return txt
//    }()
//
//    let SignUpBtn: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("Sign Up", for: .normal)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        btn.titleLabel?.textAlignment = .left
//        btn.tintColor = .white
//        btn.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//    let OrLbl: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "Or"
//        lbl.textColor = UIColor.white
//        lbl.textAlignment = .center
//        lbl.font = UIFont.boldSystemFont(ofSize: 17)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
//    let SignInBtn: UIButton = {
//        let btn = UIButton(type: .system)
//        btn.setTitle("Sign In", for: .normal)
//        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        btn.titleLabel?.textAlignment = .left
//        btn.tintColor = .white
//        btn.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//
//
//    let CopyRightApp: UILabel = {
//        let lbl = UILabel()
//        lbl.text = "μPhotos All right reserved © 2019."
//        lbl.textColor = UIColor.white
//        lbl.textAlignment = .center
//        lbl.font = UIFont.boldSystemFont(ofSize: 17)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        return lbl
//    }()
//
//    let scrollView: UIScrollView = {
//        let sv = UIScrollView()
//        sv.isUserInteractionEnabled = true
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        return sv
//    }()
//
//    let containerBrand: UIView = {
//        let uv = UIView()
//        uv.isUserInteractionEnabled = true
//        uv.translatesAutoresizingMaskIntoConstraints = false
//        return uv
//    }()
//
//    let containerFields: UIView = {
//        let uv = UIView()
//        uv.isUserInteractionEnabled = true
//        uv.translatesAutoresizingMaskIntoConstraints = false
//        return uv
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load view in controller
        signUpView.signUpController = self
        
        //define background
//        view.backgroundColor = .red
        
        //hidden navigationbar
        navigationController?.isNavigationBarHidden = true
        
        //setting textfield for to use return button
        //define delegate
        signUpView.FirstnameTxt.delegate = self
        signUpView.FirstnameTxt.tag = 0
        signUpView.LastnameTxt.delegate = self
        signUpView.LastnameTxt.tag = 1
        signUpView.EmailTxt.delegate = self
        signUpView.EmailTxt.tag = 2
        signUpView.UsernameTxt.delegate = self
        signUpView.UsernameTxt.tag = 3
        signUpView.PasswordTxt.delegate = self
        signUpView.PasswordTxt.tag = 4
        
        //execute all functions
        CreateGradienteBackground()
        //SettingsScrollObject()
        //SettingsMainObjects()
        //SettingsForm()
        //SetObjectsView()
    }
    
    //Activate animation
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.6) {
            self.signUpView.scrollView.contentOffset = CGPoint(x: 0, y: 100)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.6) {
            self.signUpView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    //Active return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //pass another field
        if let nextField = signUpView.UsernameTxt.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            next?.resignFirstResponder()
        }
        
        return false
    }
    
    //Create backgroundColor grandient
      fileprivate func CreateGradienteBackground() {
          let grandient:CAGradientLayer = CAGradientLayer()
          grandient.frame.size = self.view.frame.size
          grandient.startPoint = CGPoint(x: -0.0, y: 0.6)
          grandient.endPoint = CGPoint(x: 0.8, y: -0.0)
          grandient.colors = [UIColor.red.cgColor, UIColor.white.cgColor]
          self.view.layer.addSublayer(grandient)
      }
    
//    @objc func SignUp() {
//
//        //Count number of chars for to enable the button
//        guard let firstname = FirstnameTxt.text else { return }
//        guard let lastname = LastnameTxt.text else { return }
//        guard let email = EmailTxt.text else { return }
//        guard let username = UsernameTxt.text else { return }
//        guard let password = PasswordTxt.text else { return }
//
//        if firstname.isEmpty || lastname.isEmpty || email.isEmpty || username.isEmpty || password.isEmpty {
//
//            DispatchQueue.main.async {
//
//                //Contiene el mensaje de error
//                let mg = UILabel()
//                mg.textColor = UIColor.white
//                mg.textAlignment = .center
//                mg.font = UIFont(name: "Avenir Next", size: 17)
//                mg.text = "Oops something went wrong!"
//                mg.numberOfLines = 0
//                mg.layer.zPosition = 1
//                mg.clipsToBounds = true
//                mg.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.6)
//                mg.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height / 8)
//
//                //Se agrega a la vista
//                self.view.addSubview(mg)
//
//                //Proceso de animacion
//                UIView.animate(withDuration: 1.5, delay: 3, options: .curveEaseOut, animations: {
//                    mg.alpha = 0.0
//                }, completion: { (_) in
//                    mg.removeFromSuperview()
//                })
//            }
//
//        } else {
//
//            //Process for to Sign Up
//            guard let url = NSURL(string: "\(serverURL)sign_up/") else { return }
//
//            print(url)
//
//            //Set url for to start request
//            let request = NSMutableURLRequest(url: url as URL)
//
//            //Define method
//            request.httpMethod = "POST"
//
//            //Define body post
//            let body = "first_name=\(firstname)&last_name=\(lastname)&email=\(email)&username=\(username)&password=\(password)"
//            request.httpBody = body.data(using: .utf8)
//
//            let session = URLSession.shared
//            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//
//                guard let data = data else { return }
//
//                if let err = error {
//                    print("Oops something go mad ==>\(err)")
//                } else {
//
//                    do {
//                        //cast to JSON Object
//                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
//
//                        //Access to id send from server
//                        guard let id = json!["id"] as? String else {return}
//
//                        //Store data in dictionary
//                        let parseJSON = UserModel(uid: id, dict: json as! [String : Any])
//
//                        //Detect if exist some data
//                        if !(id).isEmpty {
//
//                            print("I found this data \(id)")
//
//                            //encode objects receive from server
//                            UserDefaults.standard.set(try? PropertyListEncoder().encode(parseJSON), forKey: "parseJSON")
//
//                            //convert data to object
//                            guard let InfoDataUser = UserDefaults.standard.object(forKey: "parseJSON") as? Data else {return}
//
//                            //decode and insert all data in model
//                            guard let userInfo = try? PropertyListDecoder().decode(UserModel.self, from: InfoDataUser) else {return}
//
//                            //Store all info in global var
//                            userData = userInfo
//
//                            //Load tabcontrollers
//                            DispatchQueue.main.async {
//                                appDelegates.Login()
//                            }
//                        }
//
//                    //Catch any error
//                    } catch let errorJSON {
//                        print("Ocurrio un error ===> \(errorJSON)")
//                    }
//                }
//            }
//
//            //finished request
//            task.resume()
//        }
//    }
    
    //load signIn view
    @objc func SignIn() {
        let controller = SignInController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc fileprivate func HideKeyword() {
        self.view.endEditing(true)
        print("tap detected")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
