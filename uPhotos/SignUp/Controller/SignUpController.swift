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
    
    //first function in load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load view in controller
        signUpView.signUpController = self
        
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
    
    //Create account
    @objc func SignUp() {
        
        //get value of textfield
        guard let firstname = signUpView.FirstnameTxt.text else {return}
        guard let lastname = signUpView.LastnameTxt.text else {return}
        guard let email = signUpView.EmailTxt.text else {return}
        guard let username = signUpView.UsernameTxt.text else {return}
        guard let password = signUpView.PasswordTxt.text else {return}
        
        //start network services
        NetworkingSignUp.SignUp(firstname: firstname, lastname: lastname, email: email, username: username, password: password)
        
    }
    
    //load signIn view
    @objc func SignIn() {
        let controller = SignInController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //detect tap and hide keyword
    @objc fileprivate func HideKeyword() {
        self.view.endEditing(true)
        print("tap detected")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
