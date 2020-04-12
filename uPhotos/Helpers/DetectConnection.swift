//
//  DetectConnection.swift
//  uPhotos
//
//  Created by Kevin Amador Rios on 2/28/20.
//  Copyright © 2020 Kevin Amador Rios. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Reachability {
    
    //detect connect
    class func isConnectedToNetwork() -> Bool {
        
        //zero address
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0,0,0,0,0,0,0,0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        //default route reachability
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        //define flags
        var flag: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flag) ==  false {
            return false
        }
        
        //only detect wifi
//        let isReachable = flag == .reachable
//        let needsConnection = flag == .connectionRequired
//        let rets = (isReachable && !needsConnection)
//        return rets
        
        //wifi and mobile data
        let isReachable = (flag.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flag.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        return ret
    }
}
