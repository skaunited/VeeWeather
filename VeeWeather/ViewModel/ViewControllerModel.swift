//
//  ViewControllerModel.swift
//  VeeWeather
//
//  Created by Skander Bahri on 16/09/2021.
//

import Foundation

protocol ViewControllerModelProtocol {
    func getDebugTest()
}

class ViewControllerModel: ViewControllerModelProtocol{
    func getDebugTest() {
        // Now let’s log!
        log.verbose("not so important")  // prio 1, VERBOSE in silver
        log.debug("something to debug")  // prio 2, DEBUG in green
        log.info("a nice information")   // prio 3, INFO in blue
        log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
        log.error("ouch, an error did occur!")  // prio 5, ERROR in red
    }
    
    func saief() {
        print("saief")
    }
    
    
}
