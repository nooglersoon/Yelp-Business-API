//
//  ViewController+Extension.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation
import SystemConfiguration
import UIKit

enum AlertType {
    case errorConnection
    case errorFetchData
    case confirmSaveData
}

extension UIViewController {
    
    func showAlert(with alertType: AlertType, completion: ((UIAlertAction)->Void)?){
        
        var title: String = ""
        var message: String = ""
        
        switch alertType {
        case .errorConnection:
            title = "Connection Error"
            message = "Please Check Your Connection"
        case .errorFetchData:
            title = "Failed Fetching Data"
            message = "Please Comeback soon :)"
        case .confirmSaveData:
            title = "Success"
            message = "Success Add to Favorites"
        }
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    

    class Reachability {
        
        static func isConnectedToNetwork() -> Bool {
            
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            
            return ret
            
        }
       
    }
    
}
