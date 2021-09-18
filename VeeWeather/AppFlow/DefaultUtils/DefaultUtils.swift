//
//  DefaultUtils.swift
//  VeeWeather
//
//  Created by Skander Bahri on 18/09/2021.
//

import Foundation
struct DefaultUtils {
    
    //Singleton Pattern
    static var sharedInstance = DefaultUtils()
    let userDefaults = UserDefaults.standard
    
    // token
    var token: String? {
        get { return userDefaults.string(forKey: "token") }
        set(newValue) {
            userDefaults.set(newValue, forKey: "token") }
    }
    
    func syncronise() {
        userDefaults.synchronize()
    }
}

