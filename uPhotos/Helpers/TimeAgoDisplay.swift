//
//  TimeAgoDisplay.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 5/2/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import UIKit


extension Date {
    
    func TimeAgoDisplay() -> String {
        
        let segundosAgo = Int(Date().timeIntervalSince(self))
        
        let mins = 60
        let hour = 60 * mins
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quoInt: Int
        let unit: String
        
        //Compara los datos
        if segundosAgo <  mins {
            quoInt = segundosAgo
            unit = "second"
        } else if segundosAgo < hour {
            quoInt = segundosAgo / mins
            unit = "mins"
        } else if segundosAgo < day {
            quoInt = segundosAgo / hour
            unit = "hour"
        } else if segundosAgo < week {
            quoInt = segundosAgo / day
            unit = "day"
        } else if segundosAgo < month {
            quoInt = segundosAgo / week
            unit = "week"
        } else {
            quoInt = segundosAgo / month
            unit = "month"
        }
        
        //Retorna el valor
        return "\(quoInt) \(unit) \(quoInt == 1 ? "":"s") ago online"
    }
}
