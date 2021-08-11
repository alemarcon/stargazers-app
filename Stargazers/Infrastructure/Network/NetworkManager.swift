//
//  NetworkManager.swift
//  Stargazers
//
//  Created by Alessandro Marcon on 11/08/2021.
//

import Foundation
import Alamofire

enum NetworkManagerStatus {
    case notReachable
    case unknown
    case ethernetOrWiFi
    case cellular
}

class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

    func startNetworkReachabilityObserver() {
        
        // start listening
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            
            var networkStatus: NetworkManagerStatus = .unknown
            switch status {
                case .notReachable:
                    networkStatus = .notReachable
                case .unknown :
                    networkStatus = .unknown
                case .reachable(.ethernetOrWiFi):
                    networkStatus = .ethernetOrWiFi
                case .reachable(.cellular):
                    networkStatus = .cellular
            }
            self?.delegate?.networkRechabilityStatus(status: networkStatus)
            
        })
        
    }
    
    func stopNetworkReachabilityObserver() {
        reachabilityManager?.stopListening()
    }
    
}

protocol NetworkManagerDelegate: AnyObject {
    func networkRechabilityStatus(status: NetworkManagerStatus)
}
