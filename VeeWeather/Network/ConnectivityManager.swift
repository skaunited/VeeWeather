//
//  ConnectivityManager.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//

import Foundation
import Alamofire

public enum NetworkConnectionStatus: String {
    case online
    case offline
}

public protocol NetworkConnectionStatusListener: class {
    func networkStatusDidChange(status: NetworkConnectionStatus)
}
class ConnectivityMananger: NSObject {
    
    private override init() {
        super.init()
        configureReachability()
    }
    private static let _shared = ConnectivityMananger()
    
    class func shared() -> ConnectivityMananger {
        return _shared
    }
    
    private let networkReachability: NetworkReachabilityManager? = NetworkReachabilityManager()
    
    var isNetworkAvailable: Bool {
        return networkReachability?.isReachable ?? false
    }
    
    var listeners = [NetworkConnectionStatusListener]()
    
    private func configureReachability() {
        self.networkReachability?.startListening(onUpdatePerforming: {networkStatusListener in
            log.info("Network Status Changed: \(networkStatusListener)")
            switch networkStatusListener {
            case .notReachable:
                self.notifyAllListenersWith(status: .offline)
                log.info("The network is not reachable.")
            case .unknown :
                self.notifyAllListenersWith(status: .offline)
                log.info("It is unknown whether the network is reachable.")
            case .reachable(.ethernetOrWiFi): fallthrough
                log.info("The network is reachable over the WiFi connection")
            case .reachable(.cellular):
                self.notifyAllListenersWith(status: .online)
                log.info("The network is reachable over the WWAN connection")
            }
        })
    }
    private func notifyAllListenersWith(status: NetworkConnectionStatus) {
        print("Network Connection status is \(status.rawValue)")
        for listener in listeners {
            listener.networkStatusDidChange(status: status )
        }
    }
    
    func addListener(listener: NetworkConnectionStatusListener) {
        listeners.append(listener)
    }
    
    func removeListener(listener: NetworkConnectionStatusListener) {
        listeners = listeners.filter { $0 !== listener}
    }
    func startListening() {
        self.networkReachability?.startListening(onUpdatePerforming: {networkStatusListener in
            log.info("Network Status Changed: \(networkStatusListener)")
            switch networkStatusListener {
            case .notReachable:
                self.notifyAllListenersWith(status: .offline)
                log.info("The network is not reachable.")
            case .unknown :
                self.notifyAllListenersWith(status: .offline)
                log.info("It is unknown whether the network is reachable.")
            case .reachable(.ethernetOrWiFi): fallthrough
                log.info("The network is reachable over the WiFi connection")
            case .reachable(.cellular):
                self.notifyAllListenersWith(status: .online)
                log.info("The network is reachable over the WWAN connection")
            }
        })
    }
    func stopListening() {
        networkReachability?.stopListening()
    }
}
