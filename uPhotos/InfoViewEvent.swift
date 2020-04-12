//
//  ErrorView.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 2/25/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import UIKit

class InfoViewEvent {
    
    //init services
    init() {}
    
    //create function
    static func ShowingMessage(message:String, color:UIColor) {
        
        //detect that info error not showing
        if infoViewShowing == false {
            //convert value to true
            infoViewShowing = true
            
            //define background
            let infoViewHeight = UIApplication.shared.keyWindow!.bounds.height / 10
            let infoView_Y = 0 - infoViewHeight
            
            let infoView = UIView(frame: CGRect(x: 0, y: infoView_Y, width: UIApplication.shared.keyWindow!.bounds.width, height: infoViewHeight))
            infoView.backgroundColor = color
            UIApplication.shared.keyWindow!.addSubview(infoView)
            
            //infoview label
            let infoLabelWidth = infoView.bounds.width
            let infoLabelHeight = (infoView.bounds.height + UIApplication.shared.keyWindow!.bounds.height) / 8
            
            let infoLabel = UILabel()
            infoLabel.frame.size.width = infoLabelWidth
            infoLabel.frame.size.height = infoLabelHeight
            infoLabel.numberOfLines = 0
            infoLabel.text = message
            infoLabel.font = .systemFont(ofSize: 20)
            infoLabel.textAlignment = .center
            infoLabel.textColor = UIColor.white
            
            //add to view
            infoView.addSubview(infoLabel)
            
            //Define animation
            UIView.animate(withDuration: 0.2, animations: {
                infoView.frame.origin.y = 0
            }, completion: { (finished:Bool) in
                if finished {
                    UIView.animate(withDuration: 0.1, delay: 2.5, options: .curveLinear, animations: {
                        infoView.frame.origin.y = infoView_Y
                    }) { (finished:Bool) in
                        if finished {
                            infoView.removeFromSuperview()
                            infoLabel.removeFromSuperview()
                            infoViewShowing = false
                        }
                    }
                }
            })
        
        }
    }
    
}
