//
//  ViewController.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 8/23/19.
//  Copyright © 2019 Kevin Amador Rios. All rights reserved.
//

import UIKit

class SignInController: UIViewController, UITextFieldDelegate {
    
    //Access to view
    let signInView: SignInView = {
        let sv = SignInView()
        return sv
    }()

    //first function on load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //calling delegates to Textfield
        signInView.UsernameTxt.delegate = self
        signInView.UsernameTxt.tag = 0
        signInView.PasswordTxt.delegate = self
        signInView.PasswordTxt.tag = 1
        
        //define background
        CreateGradienteBackground()
        
        //hidden navigationbar
        self.navigationController?.isNavigationBarHidden = true
        
        //Load view in controller
        signInView.signInController = self
        signInView.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HideKeyword)))

    }
    
    //Active animation
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.6) {
            self.signInView.scrollView.contentOffset = CGPoint(x: 0, y: 100)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.6) {
            self.signInView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    //Active return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = signInView.UsernameTxt.superview?.viewWithTag(textField.tag + 1) as? UITextField {
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
    
    //Sign In user
    @objc func SignIn() {
        
        //get objects
        guard let username = signInView.UsernameTxt.text else {return}
        guard let password = signInView.PasswordTxt.text else {return}
        
        //call to network request
        NetworkingSignIn.SignIn(username: username, password: password)
    }
    
    
    //load SignUp view
    @objc func SignUp() {
        let controller = SignUpController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //Hide Keyword
    @objc fileprivate func HideKeyword() {
        self.view.endEditing(true)
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //change status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

